vim.b.lazygit = true

vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(),
  {
    border = "rounded",
    title_pos = "left",
    title = " 󰊢 LazyGit ",
  })
