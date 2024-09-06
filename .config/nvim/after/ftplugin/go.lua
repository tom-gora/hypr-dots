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

-- quick and dirty insertion of go error handling with C-E
vim.api.nvim_create_user_command("GoErrorQuickMap", function()
	-- insert "snippet"
	vim.api.nvim_put({ "if err != nil {", "", "}" }, "l", true, true)
	-- adjust cursor to start typying
	vim.api.nvim_command("normal! kk")
	vim.api.nvim_command("startinsert")
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
end, {})

vim.api.nvim_set_keymap(
	"n",
	"<leader>E",
	"<cmd>GoErrorQuickMap<cr>",
	{ noremap = true, silent = true, desc = " Quick Go Error" }
)
