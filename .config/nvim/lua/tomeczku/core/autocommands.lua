local api = vim.api
local fn = vim.fn
local autocmd = api.nvim_create_autocmd

local perf = api.nvim_create_augroup("perf", { clear = true })
local lsp_hacks = api.nvim_create_augroup("lspHacks", { clear = true })
local ui_helpers = api.nvim_create_augroup("UiHelpers", { clear = true })
local yank_highlight = api.nvim_create_augroup("YankHighlight", { clear = true })

-- for highliting the text on yank
autocmd("TextYankPost", {
	group = yank_highlight,
	callback = function()
		vim.highlight.on_yank({
			timeout = 200,
			higroup = "MatchWord",
		})
	end,
	pattern = "*",
})

-- visual hints for active split
autocmd("WinEnter", {
	group = ui_helpers,
	callback = function(e)
		local buf_type = api.nvim_get_option_value("buftype", { buf = e.buf })
		local ft = api.nvim_get_option_value("filetype", { buf = e.buf })
		local ok, skip = pcall(api.nvim_win_get_var, api.nvim_get_current_win(), "skip_bg_change")
		if buf_type == "terminal" or ft == "oil" or skip then
			return
		end
		vim.cmd(
			"setlocal winhighlight=CursorLineNr:CursorLineNr,LineNr:LineNr,LineNrAbove:LineNrAbove,LineNrBelow:LineNrBelow,MiniIndentscopeSymbol:MiniIndentscopeSymbol,CursorLine:CursorLine"
		)
	end,
})

autocmd("WinLeave", {
	group = ui_helpers,
	callback = function(e)
		local buf_type = vim.api.nvim_buf_get_option(e.buf, "buftype")
		local ft = vim.api.nvim_get_option_value("filetype", { buf = e.buf })
		local ok, skip = pcall(api.nvim_win_get_var, api.nvim_get_current_win(), "skip_bg_change")
		if buf_type == "terminal" or ft == "oil" or skip then
			return
		end
		vim.cmd(
			"setlocal winhighlight=CursorLineNr:InvisibleTxt,LineNr:InvisibleTxt,LineNrAbove:InvisibleTxt,LineNrBelow:InvisibleTxt,MiniIndentscopeSymbol:InvisibleTxt,CursorLine:InvisibleBg"
		)
	end,
})

-- helper for dynamically placing help buffer splits based on editor width
local function handleSplitWindow(direction, proportion, buf)
	local directions = { V = true, S = true }
	if not directions[direction] then
		return
	end

	local bufhidden = vim.bo.bufhidden
	vim.bo.bufhidden = "hide"

	local origin_win = fn.win_getid(fn.winnr("#"))
	local old_win = api.nvim_get_current_win()

	api.nvim_set_current_win(origin_win)
	api.nvim_win_close(old_win, false)

	if direction == "V" then
		vim.cmd("vsplit")
		local new_win = api.nvim_get_current_win()
		local new_width = math.ceil(vim.o.columns * proportion)
		api.nvim_win_set_config(new_win, { width = new_width, style = "minimal" })
	elseif direction == "S" then
		vim.cmd("split")
		local new_win = api.nvim_get_current_win()
		local new_height = math.ceil(vim.o.lines * proportion)
		api.nvim_win_set_config(new_win, { height = new_height, style = "minimal" })
	else
		error("Unknown split direction: " .. tostring(direction))
	end

	vim.wo.wrap = true
	api.nvim_win_set_buf(api.nvim_get_current_win(), buf)
	---@diagnostic disable-next-line: assign-type-mismatch
	vim.bo.bufhidden = bufhidden
end

-- in windows at least half the screen width open help as vertical float with wrap
autocmd("VimResized", {
	group = ui_helpers,
	callback = function()
		local help_buf = nil
		local current_bufs = api.nvim_list_bufs()
		for _, buf in ipairs(current_bufs) do
			local buf_type = api.nvim_get_option_value("filetype", { buf = buf })
			if buf_type == "help" or buf_type == "man" then
				help_buf = buf
				break
			end
		end

		if not help_buf then
			return
		end

		local origin_win = fn.win_getid(fn.winnr("#"))
		local origin_buf = api.nvim_win_get_buf(origin_win)
		local origin_textwidth = vim.bo[origin_buf].textwidth
		if origin_textwidth == 0 then
			origin_textwidth = 50
		end

		if api.nvim_win_get_width(origin_win) >= origin_textwidth + 50 then
			handleSplitWindow("V", 0.4, help_buf)
		else
			handleSplitWindow("S", 0.45, help_buf)
		end
	end,
})

autocmd("BufWinEnter", {
	group = ui_helpers,
	callback = function(e)
		local buf_type = api.nvim_get_option_value("filetype", { buf = e.buf })
		if buf_type ~= "help" and buf_type ~= "man" then
			return
		end
		local origin_win = fn.win_getid(fn.winnr("#"))
		local origin_buf = api.nvim_win_get_buf(origin_win)
		-- NOTE: this is because I still want it to split vertically when I have window
		-- taking half the screen in a tiler and don't need to adhere to 80 columns
		-- of traditional terminal width
		local origin_textwidth = vim.bo[origin_buf].textwidth
		if origin_textwidth == 0 then
			origin_textwidth = 50
		end
		if api.nvim_win_get_width(origin_win) >= origin_textwidth + 50 then
			handleSplitWindow("V", 0.4, e.buf)
		else
			handleSplitWindow("S", 0.45, e.buf)
		end
	end,
})

-- disable annoying diagnostic noise in `.env` files. those are not bash scripts
autocmd({ "BufNewFile", "BufReadPost", "WinEnter" }, {
	group = lsp_hacks,
	pattern = ".env*",
	callback = function(e)
		vim.diagnostic.enable(false, { bufnr = e.buf })
	end,
})

autocmd({ "BufEnter", "LspAttach" }, {
	group = lsp_hacks,
	callback = function(e)
		local plain_text_filetypes =
			{ "markdown", "markdown.mdx", "markdown.rmd", "markdown.pandoc", "tex", "txt", "log" }
		local TODO_files = {
			"todo",
			"TODO",
			"todo.md",
			"TODO.md",
			"*.todo",
			"*.todo.md",
		}

		local buf_ft = api.nvim_get_option_value("filetype", { buf = e.buf })
		local buf_clients = vim.lsp.get_clients({ bufnr = e.buf })
		if not vim.tbl_contains(plain_text_filetypes, buf_ft) or #buf_clients < 1 then
			return
		end
		for _, c in pairs(buf_clients) do
			if
				c.config.name ~= "harper-ls"
				-- early return if change has already been toggled
				---@diagnostic disable-next-line: need-check-nil, inject-field, undefined-field
				or c.config.settings["harper-ls"].linters.SentenceCapitalization == true
			then
				return
			end
			local new_linters = {
				SpellCheck = true,
				SpelledNumbers = false,
				AnA = true,
				SentenceCapitalization = true,
				UnclosedQuotes = true,
				WrongQuotes = false,
				LongSentences = true,
				RepeatedWords = true,
				Spaces = true,
				Matcher = true,
				CorrectNumberSuffix = true,
			}
			---@diagnostic disable-next-line: need-check-nil, inject-field
			c.config.settings["harper-ls"].linters = new_linters
			---@diagnostic disable-next-line: param-type-not-match
			local ok, _ = pcall(c.notify, "workspace/didChangeConfiguration", { settings = c.config.settings })
			if ok then
				vim.notify("Harper LSP settings adjusted to plain text linting levels. ", vim.log.levels.INFO)
			else
				vim.notify("Harper LSP failed to register settings for plain text linting. 󰇸", vim.log.levels.ERROR)
			end
			break
		end
	end,
})
