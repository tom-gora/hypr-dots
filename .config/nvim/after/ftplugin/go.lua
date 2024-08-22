vim.b.go = true

vim.api.nvim_set_keymap(
	"n",
	"<leader>x",
	"<cmd>RunGoProject<CR>",
	{ noremap = true, silent = true, desc = " Execute in Terminal" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>X",
	"<cmd>ToggleGoRunner<CR>",
	{ noremap = true, silent = true, desc = " Toggle Go Runner" }
)
