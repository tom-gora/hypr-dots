-- settings specific to quickfix list
vim.b.qf = true

local qf_win_width = math.floor(vim.o.columns * 0.96)
local qf_win_height = math.floor(vim.o.lines * 0.3)
local offset = vim.o.columns - (qf_win_height + 3)
vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
	relative = "editor",
	width = qf_win_width,
	height = qf_win_height,
	row = offset,
	col = 3,
	border = "rounded",
	title = "  QuickFix ",
	title_pos = "left",
	style = "minimal",
})
vim.keymap.set("n", "<leader>q", function()
	if vim.bo.filetype == "qf" then
		vim.api.nvim_win_close(0, true)
	else
		return
	end
end, { desc = "which_key_ignore" })

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
