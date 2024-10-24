local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local v = vim.v

-- #############################################################################################
-- NOTE: helpers
-- #############################################################################################
local lineBreakdownFactory = function(line)
	local indexStart, indexEnd = string.find(line, "%d+")
	if indexStart then
		-- extract the numeric substring
		local index = string.sub(line, indexStart, indexEnd)
		-- get the substr before index and after index
		local preIndexStr = string.sub(line, 1, (indexStart > 1) and (indexStart - 1) or 1)
		local postIndexStr = string.sub(line, indexEnd + 1)
		return index, preIndexStr, postIndexStr
	else
		-- case no digit found retrn
		return nil, line, ""
	end
end

-- npm install --save-dev left-pad XD
local lpad = function(s, length, padChar)
	padChar = padChar or " "
	local padLen = length - #s
	-- only pad if needed
	if padLen > 0 then
		return string.rep(padChar, padLen) .. s
	else
		return s
	end
end

-- a helper helper to clear cmdline properly even if ch is set to default 2 lines
local clear_both_cmd_lines = function()
	fn.timer_start(2000, function()
		cmd("echo")
		print("\n")
		cmd("echo")
	end)
end

-- ask user confirmation
local askConfirmation = function(msg)
	while true do
		local userInput = fn.input(msg)
		print(" ")
		if userInput:lower() == "y" or userInput:lower() == "yes" then
			return true
		elseif userInput:lower() == "n" or userInput:lower() == "no" then
			return false
		else
			print("Invalid input. Please enter 'y' or 'n'.")
			clear_both_cmd_lines()
		end
	end
end

-- escape chars that break sed regex when constructing a %s command string
local escapeScecialChars = function(str)
	-- NOTE: Chars to escape to be added in regex if discovered to break functionality
	return str:gsub("([/\\%%^$*?.[()={\"`'+=<>|&~@-])", "\\%1"):gsub("\n", "\\n")
end

-- #############################################################################################
-- NOTE: functions
-- #############################################################################################
--
-- INFO: quickly clear the swap directory if cluttered
local clearSwap = function()
	local swap_dir = fn.stdpath("state") .. "/swap"
	local is_empty = fn.empty(fn.glob(swap_dir .. "/*")) == 1

	if fn.isdirectory(swap_dir) == 0 then
		print("Failed to clear the directory! 󰇸")
	else
		if is_empty then
			print("Swap directory is already empty! 󰇵")
			fn.timer_start(2000, function()
				clear_both_cmd_lines()
			end)
		else
			local target = swap_dir .. "/*"
			local attempt_deletion = "bash -c 'rm -f " .. target .. "'"
			local question = "Are you sure you want to clear the content of the swap dir? (y/n) "

			local res = askConfirmation(question)

			if res then
				fn.system(attempt_deletion)
				print("Cleared the content of the swap directory! 󰇵")
				clear_both_cmd_lines()
			else
				print("Operation aborted")
				clear_both_cmd_lines()
			end
		end
	end
end
api.nvim_create_user_command("ClearSwap", clearSwap, { range = false })

--
-- INFO: close unmodified buffers
local closeUnmodifiedBuffers = function()
	local buf_list = api.nvim_list_bufs()
	for _, buf in ipairs(buf_list) do
		local modified = api.nvim_get_option_value("modified", { buf = buf })
		if modified == false then
			api.nvim_buf_delete(buf, { force = true })
		end
	end
end
api.nvim_create_user_command("CloseUnmodifiedBuffers", closeUnmodifiedBuffers, { range = false })
--
-- INFO:
-- take line and duplicate it taking vim-motion count with interated indexes
-- (count indicates how many indexed lines is needed total with the source line
-- and not how many inserions so effectively it's like count - 1)

local multiplyLineWithIndexing = function(count)
	-- store the input line content to be used as base string
	local line = fn.getline(".")
	-- store the starting line number after setting everythign up
	local currentLineNr = fn.line(".")
	local index, preIndexStr, postIndexStr = lineBreakdownFactory(line)
	if not index then
		print("No numeric substring found in the line.")
		return
	end
	-- how much lpad is needed and if to pad at all
	local padLen = 0
	local question = "Do you want indexes left-padded with `0` where needed? (y/n) "
	local res = askConfirmation(question)
	if res then
		if count > 1000 - index then
			padLen = 4
		elseif count > 100 - index then
			padLen = 3
		elseif count > 10 - index then
			padLen = 2
		end
	end
	-- pad first line if neccessary
	if padLen > 0 then
		index = lpad(index, padLen, "0")
		local paddedIndexLine = preIndexStr .. lpad(index, padLen, "0") .. postIndexStr
		api.nvim_buf_set_lines(0, currentLineNr - 1, currentLineNr, false, { paddedIndexLine })
	end
	-- loop to add remaining lines as needed
	for i = 1, count - 1 do
		local nextIndex = tostring(index + i)
		if padLen > 0 then
			nextIndex = lpad(nextIndex, padLen, "0")
		end
		local nextLine = preIndexStr .. nextIndex .. postIndexStr
		api.nvim_buf_set_lines(0, currentLineNr + i - 1, currentLineNr + i - 1, false, { nextLine })
	end
	-- jump to the end of the inserted lines
	api.nvim_feedkeys(api.nvim_replace_termcodes(count - 1 .. "j", true, false, true), "n", true)
end

api.nvim_create_user_command("MultiplyLineWithIndexing", function()
	local count = v.count
	multiplyLineWithIndexing(count)
end, { range = true, nargs = "?" })

-- INFO:
-- similar to above but fixes indexes inside selection
-- useful if copies of line to index have already beeen typed
-- select the lines and call command to fix indexes to properly iterating and padded indexes

local applyIndexingOverSelection = function()
	-- get the selection Scope
	local _, ls, _ = table.unpack(fn.getpos("'<"))
	local _, le, _ = table.unpack(fn.getpos("'>"))
	-- move cursor to top of this scope
	api.nvim_command("normal! " .. ls)
	-- scope lenght
	local linesScope = le - ls
	-- store the first line content to be used as base string
	local firstLine = fn.getline(ls)
	-- delete the selection and move one line up before adding fixed strings
	for _ = 0, linesScope do
		api.nvim_command("normal! dd")
	end
	--test if at the eof to adjust cursor if needed
	local lineCount = fn.line("$")
	local testCurLine = fn.line(".")
	if testCurLine ~= lineCount then
		api.nvim_command("normal! k")
	end
	-- store the starting line number after setting everythign up
	local currentLineNr = fn.line(".")
	-- break down the input line
	local index, preIndexStr, postIndexStr = lineBreakdownFactory(firstLine)
	-- guard clause against no index found
	if not index then
		print("No numeric substring found in the line.")
		return
	end
	-- how much lpad is needed and if to pad at all
	local padLen = 0
	local question = "Do you want indexes left-padded with `0` where needed? (y/n) "
	local res = askConfirmation(question)
	if res then
		if linesScope >= 1000 - index then
			padLen = 4
		elseif linesScope >= 100 - index then
			padLen = 3
		elseif linesScope >= 10 - index then
			padLen = 2
		end
	end
	-- make sure iteration starts from a number that was there originally
	-- and since the loop inserts incremented indexes let's start 1 below
	index = index - 1

	-- aaand loop
	for i = 1, linesScope + 1 do
		local nextIndex = tostring(index + i)
		-- only pad if needed to save operations
		if padLen > 0 then
			nextIndex = lpad(nextIndex, padLen, "0")
		end
		-- concat the next line and place it below
		local nextLine = preIndexStr .. nextIndex .. postIndexStr
		api.nvim_buf_set_lines(0, currentLineNr + i - 1, currentLineNr + i - 1, false, { nextLine })
	end
	-- force the cursor to the end of selection
	api.nvim_feedkeys(api.nvim_replace_termcodes(linesScope + 1 .. "j", true, false, true), "n", true)
end
api.nvim_create_user_command("ApplyIndexingOverSelection", applyIndexingOverSelection, { range = true })

-- INFO:my own funcs automating using native sed based search and replace
--
-- init search for cword
local searchReplaceCword = function(ignoreCase)
	local cword = fn.expand("<cword>")
	local beforeCmdSubstr = ":%s/"
	local afterCmdSubstr = "/gc"
	if ignoreCase == "true" then
		afterCmdSubstr = "/gci"
	end
	local backtrack = string.rep("<Left>", #afterCmdSubstr)
	local command = beforeCmdSubstr .. cword .. "/" .. afterCmdSubstr .. backtrack
	api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
end
api.nvim_create_user_command("SearchReplaceCword", function(data)
	local args = data.fargs
	searchReplaceCword(args[1])
end, { nargs = "*" })

-- init search for user input
local searchReplaceInit = function(ignoreCase)
	local beforeCmdSubstr = ":%s/"
	local afterCmdSubstr = "/gc"
	if ignoreCase == "true" then
		afterCmdSubstr = "/gci"
	end
	local replace = fn.input("Provide string to replace: ")
	local backtrack = string.rep("<Left>", #afterCmdSubstr)
	local command = beforeCmdSubstr .. replace .. "/" .. afterCmdSubstr .. backtrack

	api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
end
api.nvim_create_user_command("SearchReplaceInit", function(data)
	local args = data.fargs
	searchReplaceInit(args[1])
end, { nargs = "*" })

-- pass visual selection as input for search and replace
local searchReplaceVisualSelection = function()
	local _, ls, cs = table.unpack(fn.getpos("'<"))
	local _, le, ce = table.unpack(fn.getpos("'>"))
	local endLineLen = fn.getline(le):len()
	if ce > endLineLen then
		ce = endLineLen
	end
	cs = cs - 1
	ce = ce - 1

	local lines = api.nvim_buf_get_text(0, ls - 1, cs, le - 1, ce + 1, {})
	local selection = table.concat(lines, "\n")
	selection = escapeScecialChars(selection)
	local beforeCmdSubstr = ":%s/\\v"
	-- use ignore case to decrease sensitibity as multiline selections are already wonky enough
	local afterCmdSubstr = "/gci"
	local backtrack = string.rep("<Left>", #afterCmdSubstr)
	local command = beforeCmdSubstr .. selection .. "/" .. afterCmdSubstr .. backtrack

	api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
end
api.nvim_create_user_command("SearchReplaceVisualSelection", function()
	-- exit visual mode before the func call to update the marks with actual current range
	api.nvim_feedkeys(api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
	searchReplaceVisualSelection()
end, { range = true })

-- reverse of the above make a selection first and take input to search
-- within this selection
local searchReplaceInsideVisualSelection = function(ignoreCase)
	-- Get the range of the visual selection
	local _, ls, cs = table.unpack(fn.getpos("'<"))
	local _, le, ce = table.unpack(fn.getpos("'>"))
	local endLineLen = fn.getline(le):len()
	if ce > endLineLen then
		ce = endLineLen
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

	local beforeCmdSubstr = ":'<,'>s/\\v"
	local afterCmdSubstr = "/gc"
	if ignoreCase == "true" then
		afterCmdSubstr = "/gci"
	end
	local backtrack = string.rep("<Left>", #afterCmdSubstr)
	local command = beforeCmdSubstr .. replace .. "/" .. afterCmdSubstr .. backtrack

	api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
end
api.nvim_create_user_command("SearchReplaceInsideVisualSelection", function(data)
	local args = data.fargs

	-- exit visual mode before the func call to update the marks with actual current range
	api.nvim_feedkeys(api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
	searchReplaceInsideVisualSelection(args[1])
end, { nargs = "*" })
--
-- search and replace within quickfix list
-- (adds bfdo and can add | update to save right away)
local searchReplaceInQfManual = function(ignoreCase, withUpdate)
	local cword = fn.expand("<cword>")
	local beforeCmdSubstr = ":cfdo %s/"
	local afterCmdSubstr = "/gc"
	if ignoreCase == "true" then
		afterCmdSubstr = "/gci"
	end
	if withUpdate == "true" then
		afterCmdSubstr = afterCmdSubstr .. " | update"
	end
	local backtrack = string.rep("<Left>", #afterCmdSubstr)
	local command = beforeCmdSubstr .. cword .. "/" .. afterCmdSubstr .. backtrack

	api.nvim_feedkeys(api.nvim_replace_termcodes(command, true, false, true), "n", true)
end

api.nvim_create_user_command("SearchReplaceInQfManual", function(data)
	local args = data.fargs
	searchReplaceInQfManual(args[1], args[2])
end, { nargs = "*" })

-- custom toggle for supermaven
local toggleSupermaven = function()
	local sm_api = require("supermaven-nvim.api")
	-- toggle global variable for stop condition
	-- first toggle sets the none existing variable to true
	vim.g.supermaven_enable = not vim.g.supermaven_enable
	-- stop or start supermaven
	local noti = require("notify")
	local noti_opts = { title = "Supermaven", icon = "", timeout = 1000, hide_from_history = true }
	if vim.g.supermaven_enable then
		noti("ON", "info", noti_opts)
		sm_api.start()
	else
		noti("OFF", "error", noti_opts)
		sm_api.stop()
	end
end

api.nvim_create_user_command("ToggleSupermaven", toggleSupermaven, { range = false })

-- building my custom navigation command that will allow jumping to and from splits easily
