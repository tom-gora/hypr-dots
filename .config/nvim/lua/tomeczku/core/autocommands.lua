local augroup = function(group)
	return vim.api.nvim_create_augroup(group, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- for highliting the text on yank
autocmd("TextYankPost", {
	group = augroup("YankHighlight"),
	callback = function()
		vim.highlight.on_yank({
			timeout = 200,
			higroup = "MatchWord",
		})
	end,
	pattern = "*",
})

-- in windows at least half the screen width open help as vertical float with wrap
vim.api.nvim_create_autocmd({ "WinNew", "BufEnter" }, {
	group = augroup("UiHelpers"),
	callback = function()
		if vim.bo.buftype == "help" or vim.bo.filetype == "man" then
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
				local help_win_width = math.floor(vim.o.columns * 0.45)
				local help_win_height = math.floor(vim.o.lines * 0.92)
				local offset = vim.o.columns - (help_win_width + 3)
				-- vim.cmd("vert resize " .. help_win_width)
				vim.wo.wrap = true
				vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
					relative = "editor",
					width = help_win_width,
					height = help_win_height,
					row = 1,
					col = offset,
					border = "rounded",
					title = "   RTFM ",
					title_pos = "left",
					style = "minimal",
				})
				vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf)
				vim.bo.bufhidden = bufhidden
			end
		end
	end,
})

autocmd("BufWritePost", {
	group = augroup("SwayncHack"),
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
