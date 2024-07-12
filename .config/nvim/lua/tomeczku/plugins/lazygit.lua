local M = {}

M = {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  window_chars = { "", "", "", "", "", "", "", "", },
  config = function()
    vim.g.lazygit_floating_window_use_plenary = 0
    vim.g.lazygit_floating_window_border_chars = { '', '', '', '', '', '', '', '' }
  end
}

return M
