local M, api = {}, vim.api

M.concat_args = function(args)
	local args_str = ""
	for _, arg in ipairs(args) do
		args_str = args_str .. " " .. arg
	end
	return args_str
end

M.set_split = function(bufnr, name)
	local cols = vim.o.columns
	local lines = vim.o.lines

	if cols <= 110 then
		vim.cmd("belowright split")
		local win_id = vim.api.nvim_get_current_win()
		api.nvim_buf_set_var(bufnr, "repl", name)
		api.nvim_set_option_value("winhighlight", "Normal:NormalFloat", { win = win_id }) -- Changed focused_win to win_id
		api.nvim_win_set_buf(win_id, bufnr)

		local fractional_height = math.floor(lines * 0.3)
		api.nvim_win_set_height(win_id, math.max(fractional_height, 10))
		vim.cmd("startinsert")
		_G.ACTIVE_REPLS[#_G.ACTIVE_REPLS + 1] = name
		return
	end
	vim.cmd("vsplit")
	local win_id = vim.api.nvim_get_current_win()
	api.nvim_buf_set_var(bufnr, "repl", name)
	api.nvim_win_set_option(win_id, "winhighlight", "Normal:NormalFloat")
	api.nvim_win_set_buf(win_id, bufnr)

	local fractional_width = math.floor(cols * 0.4)
	api.nvim_win_set_width(win_id, math.max(fractional_width, 35))
	vim.cmd("startinsert")
	_G.ACTIVE_REPLS[#_G.ACTIVE_REPLS + 1] = name
end

M.aider_list_files_in_chat = function()
	local root_dir = vim.fs.dirname(vim.fs.find(".git", { path = vim.fn.expand("%:p"), upward = true })[1])
		or vim.fn.getcwd()

	local history_file_path = root_dir .. "/.aider.chat.history.md"
	local file = io.open(history_file_path, "r")
	if not file then
		vim.notify("Chat history is not stored, cannot extract list of files.", vim.log.levels.INFO)
		return {}
	end

	local lines = {}
	for line in file:lines() do
		table.insert(lines, line)
	end
	file:close()

	local return_paths = {}
	local ls_marker_found = false
	local files_in_chat_marker_found = false
	local start_collecting_idx = nil

	-- Search backwards for "#### /ls"
	for i = #lines, 1, -1 do
		local line = lines[i]
		if line:find("#### /ls", 1, true) then
			ls_marker_found = true
			-- Now search backwards from this point for "Files in chat:"
			for j = i, 1, -1 do
				local sub_line = lines[j]
				if sub_line:match("Files in chat:", 1, true) then
					files_in_chat_marker_found = true
					start_collecting_idx = j + 1
					break -- Break from inner loop (found "Files in chat:")
				end
			end
			break -- Break from outer loop (found "#### /ls")
		end
	end

	if start_collecting_idx then
		-- Start collecting from the line after "Files in chat:"
		for k = start_collecting_idx, #lines do
			local path_line = lines[k]
			-- Trim whitespace from the line
			local trimmed_line = path_line:match("^%s*(.-)%s*$")
			if trimmed_line and trimmed_line ~= "" then
				table.insert(return_paths, trimmed_line)
			else
				-- Stop collecting on the first empty or whitespace-only line
				break
			end
		end
	end

	if not ls_marker_found or not files_in_chat_marker_found then
		vim.notify('Could not find "Files in chat" section in chat history.', vim.log.levels.INFO)
	end

	return return_paths
end

return M
