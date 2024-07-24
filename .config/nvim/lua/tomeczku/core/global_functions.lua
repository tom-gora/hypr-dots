-- helpers:
local escape_special_chars = function(str)
	-- NOTE: Chars to escape to be added in regex if discovered to break functionality
	return str:gsub("([/\\%%^$*?.[()={])", "\\%1"):gsub("\n", "\\n")
end
--
-- quickly clear the swap directory if cluttered
function _G.ClearSwap()
	local swap_dir = vim.fn.stdpath("state") .. "/swap"
	local function clear_both_cmd_lines()
		vim.fn.timer_start(2000, function()
			vim.cmd("echo")
			print("\n")
			vim.cmd("echo")
		end)
	end
	local is_empty = vim.fn.empty(vim.fn.glob(swap_dir .. "/*")) == 1

	if vim.fn.isdirectory(swap_dir) == 0 then
		print("Failed to clear the directory! 󰇸")
	else
		if is_empty then
			print("Swap directory is already empty! 󰇵")
			vim.fn.timer_start(2000, function()
				clear_both_cmd_lines()
			end)
		else
			local target = swap_dir .. "/*"
			local attempt_deletion = "bash -c 'rm -f " .. target .. "'"
			local long_q = "Are you sure you want to clear the content of the swap dir? (y/n) "

			local confirmed = false

			while not confirmed do
				local user_input = vim.fn.input(long_q)
				print(" ")

				if user_input:lower() == "y" then
					confirmed = true
					vim.fn.system(attempt_deletion)
					print("Cleared the content of the swap directory! 󰇵")
					clear_both_cmd_lines()
					break
				elseif user_input:lower() == "n" then
					confirmed = true
					print("Operation aborted")
					clear_both_cmd_lines()
					break
				else
					print("Invalid input. Please enter 'y' or 'n'.")
					clear_both_cmd_lines()
				end
			end
		end
	end
end

-- close unmodified buffers

_G.CloseUnmodifiedBuffers = function()
	local buf_list = vim.api.nvim_list_bufs()
	for _, buf in ipairs(buf_list) do
		local modified = vim.api.nvim_get_option_value("modified", { buf = buf })
		if modified == false then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

-- for term navigation
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	local map = vim.keymap.set
	map("t", "<esc>", [[<C-\><C-n>]], opts)
	map("t", "jk", [[<C-\><C-n>]], opts)
	map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- NOTE:
-- my own funcs automating using native search and replace

-- init search for cword
_G.SearchReplaceCword = function(ignore_case)
	local cword = vim.fn.expand("<cword>")
	local before_text = ":%s/"
	local after_text = "/gc"
	if ignore_case then
		after_text = "/gci"
	end
	local backtrack = string.rep("<Left>", #after_text)
	local command = before_text .. cword .. "/" .. after_text .. backtrack

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), "n", true)
end

-- init search for user input
_G.SearchReplaceInit = function(ignore_case)
	local before_text = ":%s/"
	local after_text = "/gc"
	if ignore_case then
		after_text = "/gci"
	end
	local replace = vim.fn.input("Provide string to replace: ")
	local backtrack = string.rep("<Left>", #after_text)
	local command = before_text .. replace .. "/" .. after_text .. backtrack

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), "n", true)
end

-- pass visual selection as input for search and replace
_G.SearchReplaceVisualSelection = function()
	local _, ls, cs = table.unpack(vim.fn.getpos("'<"))
	local _, le, ce = table.unpack(vim.fn.getpos("'>"))
	local end_line_length = vim.fn.getline(le):len()
	if ce > end_line_length then
		ce = end_line_length
	end
	cs = cs - 1
	ce = ce - 1

	local lines = vim.api.nvim_buf_get_text(0, ls - 1, cs, le - 1, ce + 1, {})
	local selection = table.concat(lines, "\n")
	selection = escape_special_chars(selection)
	local before_text = ":%s/\\v"
	-- use ignore case to decrease sensitibity as multiline selections are already wonky enough
	local after_text = "/gci"
	local backtrack = string.rep("<Left>", #after_text)
	local command = before_text .. selection .. "/" .. after_text .. backtrack

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), "n", true)
end

-- reverse of the above make a selection first and take input to search
-- within this selection
_G.SearchReplaceInsideVisualSelection = function(ignore_case)
	-- Get the range of the visual selection
	local _, ls, cs = table.unpack(vim.fn.getpos("'<"))
	local _, le, ce = table.unpack(vim.fn.getpos("'>"))
	local end_line_length = vim.fn.getline(le):len()
	if ce > end_line_length then
		ce = end_line_length
	end
	cs = cs - 1
	ce = ce - 1

	local lines = vim.api.nvim_buf_get_text(0, ls - 1, cs, le - 1, ce + 1, {})
	local selection = table.concat(lines, "\n")

	selection = escape_special_chars(selection)
	local replace = vim.fn.input("Provide string to replace: ")
	replace = escape_special_chars(replace)

	if not string.find(selection, replace) then
		print("Pattern not found within the secection 󰇸")
		return
	end

	local before_text = ":'<,'>s/\\v"
	local after_text = "/gc"
	if ignore_case then
		after_text = "/gci"
	end
	local backtrack = string.rep("<Left>", #after_text)
	local command = before_text .. replace .. "/" .. after_text .. backtrack

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), "n", true)
end

-- search and replace within quickfix list
-- (adds bfdo and can add | update to save right away)
_G.SearchReplaceInQfManual = function(ignore_case, with_update)
	local cword = vim.fn.expand("<cword>")
	local before_text = ":cfdo %s/"
	local after_text = "/gc"
	if ignore_case then
		after_text = "/gci"
	end
	if with_update then
		after_text = after_text .. " | update"
	end
	local backtrack = string.rep("<Left>", #after_text)
	local command = before_text .. cword .. "/" .. after_text .. backtrack

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), "n", true)
end

_G.AppendIds = function()
	-- Ask for the string to append IDs to
	local input_string = vim.fn.input("Enter the string to append IDs to: ")

	-- Offer delimiter options
	local delimiter = vim.fn.inputlist({
		"Choose a delimiter (type the corresponding number):",
		"1. -",
		"2. _",
		"3. .",
	})

	-- Ask if the user wants to pad with zeros
	local pad_with_zeros = vim.fn.confirm("Pad with zeros? (Y/n): ") == 1

	-- Get the visual selection range
	local _, ls, cs = table.unpack(vim.fn.getpos("'<"))
	local _, le, ce = table.unpack(vim.fn.getpos("'>"))

	-- Process each line within the selection
	for i = ls, le do
		local line = vim.fn.getline(i)
		local id = input_string .. delimiter[1] .. string.format("%02d", i - ls + 1)
		if pad_with_zeros then
			id = input_string .. delimiter[1] .. string.format("%03d", i - ls + 1)
		end
		vim.fn.setline(i, line:gsub(input_string, id))
	end
end
