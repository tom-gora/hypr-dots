local api = vim.api
local fn = vim.fn
local autocmd = api.nvim_create_autocmd

local lsp_hacks = api.nvim_create_augroup("lspHacks", { clear = true })
local ui_helpers = api.nvim_create_augroup("UiHelpers", { clear = true })
local yank_highlight = api.nvim_create_augroup("YankHighlight", { clear = true })
local swaync_hack = api.nvim_create_augroup("SwayncHack", { clear = true })

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

-- disable buggy anims in completion windows where snacks clash with blink
autocmd("User", {
	group = ui_helpers,
	pattern = "BlinkCmpMenuOpen",
	callback = function()
		vim.g.snacks_animate = false
	end,
})

autocmd("User", {
	group = ui_helpers,
	pattern = "BlinkCmpMenuClose",
	callback = function()
		vim.g.snacks_animate = true
	end,
})

--
-- visual hints for active split
autocmd("WinEnter", {
	group = ui_helpers,
	callback = function()
		vim.cmd(
			"setlocal winhighlight=CursorLineNr:CursorLineNr,LineNr:LineNr,LineNrAbove:LineNrAbove,LineNrBelow:LineNrBelow,MiniIndentscopeSymbol:MiniIndentscopeSymbol,CursorLine:CursorLine"
		)
	end,
})

autocmd("WinLeave", {
	group = ui_helpers,
	callback = function()
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

-- disable annoying diagnostic noise in .env files. those are not bash scripts
autocmd({ "BufNewFile", "BufReadPost" }, {
	group = lsp_hacks,
	pattern = ".env*",
	callback = function(e)
		vim.diagnostic.enable(false, { bufnr = e.buf })
	end,
})
