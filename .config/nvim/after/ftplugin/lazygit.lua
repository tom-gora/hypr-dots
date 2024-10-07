vim.b.lazygit = true

vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
	border = "rounded",
	title_pos = "left",
	title = " 󰊢 LazyGit ",
})

vim.keymap.set("n", "<leader>q", function()
	if vim.bo.filetype == "lazygit" then
		vim.api.nvim_win_close(0, true)
	else
		return
	end
end, { desc = "which_key_ignore" })
