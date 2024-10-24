local autocmd = vim.api.nvim_create_autocmd
local ui_helpers = vim.api.nvim_create_augroup("UiHelpers", { clear = true })
local yank_highlight = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
local swaync_hack = vim.api.nvim_create_augroup("SwayncHack", { clear = true })

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

-- in windows at least half the screen width open help as vertical float with wrap
autocmd({ "WinNew", "BufEnter" }, {
	group = ui_helpers,
	callback = function()
		if vim.bo.buftype ~= "help" and vim.bo.filetype ~= "man" then
			return
		end
		local origin_win = vim.fn.win_getid(vim.fn.winnr("#"))
		local origin_buf = vim.api.nvim_win_get_buf(origin_win)
		-- NOTE: this is because I still want it to split vertically when I have window
		-- taking half the screen in a tiler and don't need to adhere to 80 columns
		-- of traditional terminal width
		local origin_textwidth = vim.bo[origin_buf].textwidth
		if origin_textwidth == 0 then
			origin_textwidth = 50
		end
		if vim.api.nvim_win_get_width(origin_win) >= origin_textwidth + 50 then
			local help_buf = vim.fn.bufnr()
			local bufhidden = vim.bo.bufhidden
			vim.bo.bufhidden = "hide"

			local old_help_win = vim.api.nvim_get_current_win()
			vim.api.nvim_set_current_win(origin_win)
			vim.api.nvim_win_close(old_help_win, false)

			vim.cmd("vsplit")
			-- set my own dybamic width to the split
			local help_win_width = math.ceil(vim.o.columns * 0.4)
			vim.wo.wrap = true
			vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
				width = help_win_width,
				style = "minimal",
			})
			vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf)
			vim.bo.bufhidden = bufhidden
		end
	end,
})

autocmd("BufWritePost", {
	group = swaync_hack,
	pattern = {
		"**/swaync/config.json",
		"**/swaync/style.css",
	},
	callback = function()
		print("saved swaync config")
		vim.cmd("!swaync-client -R")
		vim.cmd("!swaync-client -rs")
	end,
})
