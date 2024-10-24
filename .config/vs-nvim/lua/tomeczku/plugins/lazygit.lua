local M = {}
local conf = require("tomeczku.configs.lazygit_conf")

M = {
  "kdheepak/lazygit.nvim",
  cmd = conf.cmd,
  window_chars = conf.chars,
  config = conf.config_function,
}

return M
