vim.b.sagaoutline = true

local outline_win_width = 30
vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
	width = outline_win_width,
	focusable = true,
	style = "minimal",
})
