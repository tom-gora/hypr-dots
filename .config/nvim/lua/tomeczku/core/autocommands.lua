local augroup = function(group)
  return vim.api.nvim_create_augroup(group, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd
local win_adjustments = augroup("WinAdjustments")

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
-- and tweaking the windows
autocmd("BufEnter", {
  group = win_adjustments,
  pattern = "*",
  callback = function()
    vim.schedule(function()
      if vim.bo.filetype == "qf" then
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
      if vim.bo.filetype == "sagaoutline" then
        local outline_win_width = 29
        local outline_win_height = math.floor(vim.o.lines * 0.92)
        local offset = vim.o.columns - (outline_win_width + 2)
        vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(),
          {
            relative = "editor",
            width = outline_win_width,
            height = outline_win_height,
            focusable = true,
            row = 1,
            col = offset,
            border = "rounded",
            title = "   Outline ",
            title_pos = "left",
            style = "minimal"
          })
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


-- in windows at least half the screen width open help splits vertical with wrap
vim.api.nvim_create_autocmd({ "WinNew", "BufEnter" }, {
  group = augroup("UiHelpers"),
  callback = function()
    if vim.bo.buftype == "help" or vim.bo.filetype == "man" then
      local origin_win = vim.fn.win_getid(vim.fn.winnr "#")
      local origin_buf = vim.api.nvim_win_get_buf(origin_win)
      -- NOTE: this is because I still want it to split vertically when I have window
      -- taking half the screen in a tiler and don't need to adhere to 80 columns
      -- of traditional terminal width
      local origin_textwidth = vim.bo[origin_buf].textwidth
      if origin_textwidth == 0 then
        origin_textwidth = 50
      end
      if vim.api.nvim_win_get_width(origin_win) >= origin_textwidth + 50 then
        local help_buf = vim.fn.bufnr()
        local bufhidden = vim.bo.bufhidden
        vim.bo.bufhidden = "hide"

        local old_help_win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(origin_win)
        vim.api.nvim_win_close(old_help_win, false)

        vim.cmd "vsplit"
        -- set my own dybamic width to the split
        local help_win_width = math.floor(vim.o.columns * 0.45)
        local help_win_height = math.floor(vim.o.lines * 0.92)
        local offset = vim.o.columns - (help_win_width + 3)
        -- vim.cmd("vert resize " .. help_win_width)
        vim.wo.wrap = true
        vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(),
          {
            relative = "editor",
            width = help_win_width,
            height = help_win_height,
            row = 1,
            col = offset,
            border = "rounded",
            title = "   RTFM ",
            title_pos = "left",
            style = "minimal"
          })
        vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf)
        vim.bo.bufhidden = bufhidden
      end
    end
  end
})
