vim.b.sagaoutline = true

local outline_win_width = 29
local outline_win_height = math.floor(vim.o.lines * 0.92)
local offset = vim.o.columns - (outline_win_width + 2)
vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
	relative = "editor",
	width = outline_win_width,
	height = outline_win_height,
	focusable = true,
	row = 1,
	col = offset,
	border = "rounded",
	title = "   Outline ",
	title_pos = "left",
	style = "minimal",
})

vim.keymap.set("n", "<leader>q", function()
	if vim.bo.filetype == "sagaoutline" then
		vim.api.nvim_win_close(0, true)
	end
end, { desc = "which_key_ignore" })
