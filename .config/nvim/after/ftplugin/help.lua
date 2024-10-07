vim.b.help = true

vim.keymap.set("n", "<leader>q", function()
	if vim.bo.filetype == "help" then
		vim.api.nvim_win_close(0, true)
	else
		return
	end
end, { desc = "which_key_ignore" })
