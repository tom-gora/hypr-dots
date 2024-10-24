-- bump up notification windows zindex
vim.b.notify = true

vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
	zindex = 200,
	focusable = false,
})
