vim.b.gomod = true

vim.api.nvim_set_keymap(
	"n",
	"<leader>x",
	"<cmd>RunGoProject<CR>",
	{ noremap = true, silent = true, desc = " Execute in Terminal" }
)
