-- settings specific to quickfix list
vim.b.qf = true

local map = vim.keymap.set
map("n", "<leader>rq", "<nop>", { desc = "QF Replace", noremap = true, silent = true, buffer = 0 })
map(
	"n",
	"<leader>rq1",
	"<cmd>SearchReplaceInQfManual true false<cr>",
	{ desc = "Ignore Case Manual", noremap = true, silent = true, buffer = 0 }
)
map(
	"n",
	"<leader>rq2",
	"<cmd>SearchReplaceInQfManual true true<CR>",
	{ desc = "Ignore Case Update", noremap = true, silent = true, buffer = 0 }
)
map(
	"n",
	"<leader>rq3",
	"<cmd>SearchReplaceInQfManual false true<CR>",
	{ desc = "Preserve Case Manual", noremap = true, silent = true, buffer = 0 }
)
map(
	"n",
	"<leader>rq4",
	"<cmd>SearchReplaceInQfManual false false<CR>",
	{ desc = "Preserve Case Update", noremap = true, silent = true, buffer = 0 }
)
