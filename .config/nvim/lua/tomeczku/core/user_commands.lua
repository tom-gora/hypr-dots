local api = vim.api
local fn = vim.fn
local v = vim.v
local makeCmd = api.nvim_create_user_command

-- NOTE: helpers
--
---@param line string
---@return string?, string, string
local lineBreakdownFactory = function(line)
	if line == nil or line == "" then
		return nil, "", ""
	end
	local index_start, index_end = string.find(line, "%d+")
	if index_start then
		-- extract the numeric substring
		local index = string.sub(line, index_start, index_end)
		-- get the substr before index and after index
		local pre_index_str = string.sub(line, 1, index_start - 1)
		local post_index_str = string.sub(line, index_end + 1)
		return index, pre_index_str, post_index_str
	else
		-- case no digit found retrn
		return nil, line, ""
	end
end

-- npm install --save-dev left-pad XD
---@param s string
---@param length integer
---@param padChar string
---@return string
local lpad = function(s, length, padChar)
	padChar = padChar or " "
	if length <= 0 or #s >= length then
		return s
	end
	local pad_len = length - #s
	return string.rep(padChar, pad_len) .. s
end

-- ask user confirmation
---@param msg string
---@return boolean?
local askConfirmation = function(msg)
	local prompt = msg .. " [y/n]: "

	while true do
		local user_input = fn.input(prompt)
		local input_lower = user_input:lower()

		if input_lower == "y" or input_lower == "yes" then
			return true
		end

		if input_lower == "n" or input_lower == "no" then
			return false
		end

		-- Only reach here if the input was invalid
		vim.notify("Invalid input. Please enter 'y' or 'n'.")
	end
end

-- escape chars that break sed regex when constructing a %s command string
---@param str string
---@return string, integer
local escapeScecialChars = function(str)
	-- NOTE: Chars to escape to be added in regex if discovered to break functionality
	return str:gsub("([/\\%%^$*?.[()={\"`'+=<>|&~@-])", "\\%1"):gsub("\n", "\\n")
end

-- #############################################################################################
-- NOTE: commands
-- #############################################################################################
--
-- INFO: quickly clear the swap directory if cluttered
local clearSwap = function()
	local noti_opts = {
		title = "Swap Cleanup",
		icon = "󰺝 ",
		timeout = 1000,
		hide_from_history = true,
	}

	local swap_dir = fn.stdpath("state") .. "/swap"

	if fn.isdirectory(swap_dir) == 0 then
		vim.notify("Failed to clear the directory! 󰇸", vim.log.levels.ERROR, noti_opts)
		return -- Early exit
	end

	local is_empty = fn.empty(fn.glob(swap_dir .. "/*")) == 1

	if is_empty then
		vim.notify("Swap directory is already empty! 󰇵", vim.log.levels.WARN, noti_opts)
		fn.timer_start(2000, function() end)
		return
	end

	local question = "Are you sure you want to clear the content of the swap dir?"
	local res = askConfirmation(question)

	if res then
		local target = swap_dir .. "/*"
		local attempt_deletion = "bash -c 'rm -f " .. target .. "'"
		vim.fn.system(attempt_deletion)
		local exit_code = vim.v.shell_error

		if exit_code ~= 0 then
			vim.notify(
				"Failed to clear the directory! 󰇸  [Exit code: " .. tostring(exit_code) .. "]",
				vim.log.levels.ERROR,
				noti_opts
			)
			return
		end
		vim.notify("Cleared the content of the swap directory! 󰇵", vim.log.levels.INFO, noti_opts)
	else
		vim.notify("Operation aborted", vim.log.levels.INFO, noti_opts)
	end
end
makeCmd("ClearSwap", clearSwap, { range = false })

--
-- INFO: close unmodified buffers
local closeUnmodifiedBuffers = function()
	local buf_list = api.nvim_list_bufs()
	for _, buf in ipairs(buf_list) do
		local modified = api.nvim_get_option_value("modified", { buf = buf })
		local listed = api.nvim_get_option_value("buflisted", { buf = buf })
		if modified == false and listed == true then
			api.nvim_buf_delete(buf, { force = true })
		end
	end
end
makeCmd("CloseUnmodifiedBuffers", closeUnmodifiedBuffers, { range = false })
--
-- INFO:
-- take line and duplicate it taking vim-motion count with interated indexes
-- (count indicates how many indexed lines is needed total with the source line
-- and not how many inserions so effectively it's like count - 1)

---@param count integer
---@return any?
local multiplyLineWithIndexing = function(count)
	-- store the input line content to be used as base string
	local line = fn.getline(".")
	-- store the starting line number after setting everythign up
	local current_line_nr = fn.line(".")
	local index, pre_index_str, post_index_str = lineBreakdownFactory(line)
	if not index then
		print("No numeric substring found in the line.")
		return
	end
	-- how much lpad is needed and if to pad at all
	local pad_len = 0
	local question = "Do you want indexes left-padded with `0` where needed?"
	local res = askConfirmation(question)
	if res then
		if count > 1000 - index then
			pad_len = 4
		elseif count > 100 - index then
			pad_len = 3
		elseif count > 10 - index then
			pad_len = 2
		end
	end
	-- pad first line if neccessary
	if pad_len > 0 then
		index = lpad(index, pad_len, "0")
		local padded_index_line = pre_index_str .. lpad(index, pad_len, "0") .. post_index_str
		api.nvim_buf_set_lines(0, current_line_nr - 1, current_line_nr, false, { padded_index_line })
	end
	-- loop to add remaining lines as needed
	for i = 1, count - 1 do
		local next_index = tostring(index + i)
		if pad_len > 0 then
			next_index = lpad(next_index, pad_len, "0")
		end
		local nextLine = pre_index_str .. next_index .. post_index_str
		api.nvim_buf_set_lines(0, current_line_nr + i - 1, current_line_nr + i - 1, false, { nextLine })
	end
	-- jump to the end of the inserted lines
	api.nvim_feedkeys(api.nvim_replace_termcodes(count - 1 .. "j", true, false, true), "n", true)
end

makeCmd("MultiplyLineWithIndexing", function()
	local count = v.count
	multiplyLineWithIndexing(count)
end, { range = true, nargs = "?" })

-- INFO:
-- similar to above but fixes indexes inside selection
-- useful if copies of line to index have already beeen typed
-- select the lines and call command to fix indexes to properly iterating and padded indexes

---@return any?
local applyIndexingOverSelection = function()
	-- get the selection Scope
	local _, ls, _ = table.unpack(fn.getpos("'<"))
	local _, le, _ = table.unpack(fn.getpos("'>"))
	-- move cursor to top of this scope
	api.nvim_command("normal! " .. ls)
	-- scope lenght
	local lines_scope = le - ls
	-- store the first line content to be used as base string
	local first_line = fn.getline(ls)
	-- delete the selection and move one line up before adding fixed strings
	for _ = 0, lines_scope do
		api.nvim_command("normal! dd")
	end
	--test if at the eof to adjust cursor if needed
	local line_count = fn.line("$")
	local test_cur_line = fn.line(".")
	if test_cur_line ~= line_count then
		api.nvim_command("normal! k")
	end
	-- store the starting line number after setting everythign up
	local current_line_nr = fn.line(".")
	-- break down the input line
	local index, pre_index_str, post_index_str = lineBreakdownFactory(first_line)
	-- guard clause against no index found
	if not index then
		print("No numeric substring found in the line.")
		return
	end
	-- how much lpad is needed and if to pad at all
	local pad_len = 0
	local question = "Do you want indexes left-padded with `0` where needed?"
	local res = askConfirmation(question)
	if res then
		if lines_scope >= 1000 - index then
			pad_len = 4
		elseif lines_scope >= 100 - index then
			pad_len = 3
		elseif lines_scope >= 10 - index then
			pad_len = 2
		end
	end
	-- make sure iteration starts from a number that was there originally
	-- and since the loop inserts incremented indexes let's start 1 below
	index = index - 1

	-- aaand loop
	for i = 1, lines_scope + 1 do
		local next_index = tostring(index + i)
		-- only pad if needed to save operations
		if pad_len > 0 then
			next_index = lpad(next_index, pad_len, "0")
		end
		-- concat the next line and place it below
		local next_line = pre_index_str .. next_index .. post_index_str
		api.nvim_buf_set_lines(0, current_line_nr + i - 1, current_line_nr + i - 1, false, { next_line })
	end
	-- force the cursor to the end of selection
	api.nvim_feedkeys(api.nvim_replace_termcodes(lines_scope + 1 .. "j", true, false, true), "n", true)
end
makeCmd("ApplyIndexingOverSelection", applyIndexingOverSelection, { range = true })

if not vim.g.vscode then
	-- INFO:my own funcs automating using native sed based search and replace
	--
	-- init search for cword
	---@param ignoreCase boolean
	local searchReplaceCword = function(ignoreCase)
		local cword = fn.expand("<cword>")
		local before_cmd_substr = ":%s/"
		local after_cmd_substr = "/gc"
		if ignoreCase == "true" then
			after_cmd_substr = "/gci"
		end
		local backtrack = string.rep("<Left>", #after_cmd_substr)
		local command = before_cmd_substr .. cword .. "/" .. after_cmd_substr .. backtrack
		api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
	end
	makeCmd("SearchReplaceCword", function(data)
		local args = data.fargs
		searchReplaceCword(args[1])
	end, { nargs = "*" })

	-- init search for user input
	---@param ignoreCase boolean
	local searchReplaceInit = function(ignoreCase)
		local before_cmd_substr = ":%s/"
		local after_cmd_substr = "/gc"
		if ignoreCase == "true" then
			after_cmd_substr = "/gci"
		end
		local replace = escapeScecialChars(fn.input("Provide string to replace: "))
		local backtrack = string.rep("<Left>", #after_cmd_substr)
		local command = before_cmd_substr .. replace .. "/" .. after_cmd_substr .. backtrack

		api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
	end
	makeCmd("SearchReplaceInit", function(data)
		local args = data.fargs
		searchReplaceInit(args[1])
	end, { nargs = "*" })

	-- pass visual selection as input for search and replace
	local searchReplaceVisualSelection = function()
		local _, ls, cs = table.unpack(fn.getpos("'<"))
		local _, le, ce = table.unpack(fn.getpos("'>"))
		local end_line_len = fn.getline(le):len()
		if ce > end_line_len then
			ce = end_line_len
		end
		cs = cs - 1
		ce = ce - 1

		local lines = api.nvim_buf_get_text(0, ls - 1, cs, le - 1, ce + 1, {})
		local selection = table.concat(lines, "\n")
		selection = escapeScecialChars(selection)
		local before_cmd_substr = ":%s/\\v"
		-- use ignore case to decrease sensitibity as multiline selections are already wonky enough
		local after_cmd_substr = "/gci"
		local backtrack = string.rep("<Left>", #after_cmd_substr)
		local command = before_cmd_substr .. selection .. "/" .. after_cmd_substr .. backtrack

		api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
	end
	makeCmd("SearchReplaceVisualSelection", function()
		-- exit visual mode before the func call to update the marks with actual current range
		api.nvim_feedkeys(api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
		searchReplaceVisualSelection()
	end, { range = true })

	-- reverse of the above make a selection first and take input to search
	-- within this selection
	---@param ignoreCase boolean
	local searchReplaceInsideVisualSelection = function(ignoreCase)
		-- Get the range of the visual selection
		local _, ls, cs = table.unpack(fn.getpos("'<"))
		local _, le, ce = table.unpack(fn.getpos("'>"))
		local end_line_len = fn.getline(le):len()
		if ce > end_line_len then
			ce = end_line_len
		end
		cs = cs - 1
		ce = ce - 1

		local lines = api.nvim_buf_get_text(0, ls - 1, cs, le - 1, ce + 1, {})
		local selection = table.concat(lines, "\n")

		selection = escapeScecialChars(selection)
		local replace = fn.input("Provide string to replace: ")
		replace = escapeScecialChars(replace)

		if not string.find(selection, replace) then
			print("Pattern not found within the secection 󰇸")
			return
		end

		local before_cmd_substr = ":'<,'>s/\\v"
		local after_cmd_substr = "/gc"
		if ignoreCase == "true" then
			after_cmd_substr = "/gci"
		end
		local backtrack = string.rep("<Left>", #after_cmd_substr)
		local command = before_cmd_substr .. replace .. "/" .. after_cmd_substr .. backtrack

		api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
	end
	makeCmd("SearchReplaceInsideVisualSelection", function(data)
		local args = data.fargs

		-- exit visual mode before the func call to update the marks with actual current range
		api.nvim_feedkeys(api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
		searchReplaceInsideVisualSelection(args[1])
	end, { nargs = "*" })
	--
	-- search and replace within quickfix list
	-- (adds bfdo and can add | update to save right away)
	---@param ignoreCase boolean
	---@param withUpdate boolean
	local searchReplaceInQfManual = function(ignoreCase, withUpdate)
		local cword = fn.expand("<cword>")
		local before_cmd_substr = ":cfdo %s/"
		local after_cmd_substr = "/gc"
		if ignoreCase == "true" then
			after_cmd_substr = "/gci"
		end
		if withUpdate == "true" then
			after_cmd_substr = after_cmd_substr .. " | update"
		end
		local backtrack = string.rep("<Left>", #after_cmd_substr)
		local command = before_cmd_substr .. cword .. "/" .. after_cmd_substr .. backtrack

		api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
	end

	makeCmd("SearchReplaceInQfManual", function(data)
		local args = data.fargs
		searchReplaceInQfManual(args[1], args[2])
	end, { nargs = "*" })

	-- custom toggle for AI
	local toggleAi = function()
		local sm_api = require("supermaven-nvim.api")
		local noti_opts = { title = "Supermaven", icon = " ", timeout = 1000, hide_from_history = true }

		if vim.g.SUPERMAVEN_DISABLED == 1 then
			vim.notify("Supermaven ON", vim.log.levels.INFO, noti_opts)
			sm_api.start()
		else
			vim.notify("Supermaven OFF", vim.log.levels.WARN, noti_opts)
			sm_api.stop()
		end
	end

	makeCmd("ToggleAi", toggleAi, { range = false })
end
-- building my custom navigation command that will allow jumping to and from splits easily
