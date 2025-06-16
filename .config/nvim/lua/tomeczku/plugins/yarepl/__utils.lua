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

M.set_autocmds = function()
	local repl_helpers = api.nvim_create_augroup("REPLHelpers", { clear = true })
	-- if one of active repls closed remove it from the global state list of opened ones
	api.nvim_create_autocmd("TermClose", {
		group = repl_helpers,
		callback = function(e)
			local ok, repl = pcall(api.nvim_buf_get_var, e.buf, "repl")
			if not ok then
				return
			end
			_G.ACTIVE_REPLS = vim.tbl_filter(function(item)
				return not item:match(repl)
			end, _G.ACTIVE_REPLS)
		end,
	})
end

---@param mode string
---@param lhs string
---@param repl_name string
---@param logic function
---@param desc string
---@param start_new boolean?
---@retrn void
M.map = function(mode, lhs, repl_name, logic, desc, start_new)
	vim.keymap.set(mode, lhs, function()
		if #_G.ACTIVE_REPLS > 0 and vim.tbl_contains(_G.ACTIVE_REPLS, repl_name) then
			logic()
			return
		end
		if start_new and start_new == true then
			vim.cmd("REPLStart " .. repl_name)
			return
		end
		vim.notify("REPL doesn't exist!", vim.log.levels.INFO)
	end, { silent = true, noremap = true, desc = desc })
end

return M
