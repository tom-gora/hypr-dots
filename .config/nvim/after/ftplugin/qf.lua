-- settings specific to quickfix list
vim.b.qf = true

local qf_win_width = math.floor(vim.o.columns * 0.96)
local qf_win_height = math.floor(vim.o.lines * 0.3)
local offset = vim.o.columns - (qf_win_height + 3)
vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(),
  {
    relative = "editor",
    width = qf_win_width,
    height = qf_win_height,
    row = offset,
    col = 3,
    border = "rounded",
    title = "  QuickFix ",
    title_pos = "left",
    style = "minimal"
  })


local map = vim.keymap.set
map("n", "<leader>rq", "<nop>",
  { desc = "QF Replace", noremap = true, silent = true, buffer = 0 })
map("n", "<leader>rq1", "<cmd>lua SearchReplaceInQfManual(true, false)<cr>",
  { desc = "Ignore Case Manual", noremap = true, silent = true, buffer = 0 })
map("n", "<leader>rq2", "<cmd>lua SearchReplaceInQfManual(true, true)<CR>",
  { desc = "Ignore Case Update", noremap = true, silent = true, buffer = 0 })
map("n", "<leader>rq3", "<cmd>lua SearchReplaceInQfManual(false, true)<CR>",
  { desc = "Preserve Case Manual", noremap = true, silent = true, buffer = 0 })
map("n", "<leader>rq4", "<cmd>lua SearchReplaceInQfManual(false, false)<CR>",
  { desc = "Preserve Case Update", noremap = true, silent = true, buffer = 0 })