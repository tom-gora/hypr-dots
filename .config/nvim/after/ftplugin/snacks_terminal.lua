-- force window styles
vim.schedule(function()
	local st = vim.b.snacks_terminal
	if not st or not st.cmd or not st.cmd[1] then
		return
	end

	if tostring(st.cmd[1]) == "lazygit" then
		vim.b.lazygit = true
		vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
			border = "solid",
			title_pos = "right",
			title = " 󰊢 LazyGit ",
		})
		return
	end
end)

vim.keymap.set(
	{ "n", "i", "x" },
	"<C-t>",
	"<cmd>lua Snacks.terminal.toggle()<cr>",
	{ silent = true, noremap = true, desc = "which_key_ignore" }
)
