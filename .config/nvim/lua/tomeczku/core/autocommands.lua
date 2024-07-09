local augroup = function(group)
  return vim.api.nvim_create_augroup(group, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd
local binds_per_filetype_group = augroup("BindsPerFileType")

-- for highliting the text on yank
autocmd('TextYankPost', {
  group = augroup('YankHighlight'),
  callback = function()
    vim.highlight.on_yank({
      timeout = 200,
      higroup = "MatchWord",
    })
  end,
  pattern = '*',
})

-- for automatically registering and deregistering QF specific bindings when entering a qf list
autocmd("BufEnter", {
  group = binds_per_filetype_group,
  pattern = "*",
  callback = function()
    vim.schedule(function()
      if vim.bo.filetype == "qf" then
        local map = vim.api.nvim_set_keymap
        map("n", "<leader>rq", "<nop>",
          { desc = "QF Replace", noremap = true, silent = true })
        map("n", "<leader>rq1", "<cmd>lua SearchReplaceInQfManual(true, false)<cr>",
          { desc = "Ignore Case Manual", noremap = true, silent = true })
        map("n", "<leader>rq2", "<cmd>lua SearchReplaceInQfManual(true, true)<CR>",
          { desc = "Ignore Case Update", noremap = true, silent = true })
        map("n", "<leader>rq3", "<cmd>lua SearchReplaceInQfManual(false, true)<CR>",
          { desc = "Preserve Case Manual", noremap = true, silent = true })
        map("n", "<leader>rq4", "<cmd>lua SearchReplaceInQfManual(false, false)<CR>",
          { desc = "Preserve Case Update", noremap = true, silent = true })
      end
    end)
  end
})

autocmd("BufLeave", {
  group = binds_per_filetype_group,
  pattern = "*",
  callback = function()
    vim.schedule(function()
      local map = vim.api.nvim_set_keymap
      local opts = { desc = "which_key_ignore", silent = true, noremap = true }
      map("n", "<leader>rq", "<nop>", opts)
      map("n", "<leader>rqm", "<nop>", opts)
      map("n", "<leader>rqu", "<nop>", opts)
    end)
  end
})
