local M = {}

M.cmd = {
  "LazyGit",
  "LazyGitConfig",
  "LazyGitCurrentFile",
  "LazyGitFilter",
  "LazyGitFilterCurrentFile",
}

M.config_function = function()
  -- HACK: to not draw the inbuilt ancient method borders
  vim.g.lazygit_floating_window_use_plenary = 0
  vim.g.lazygit_floating_window_border_chars = { '', '', '', '', '', '', '', '' }
end

M.chars = { "", "", "", "", "", "", "", "", }

return M
