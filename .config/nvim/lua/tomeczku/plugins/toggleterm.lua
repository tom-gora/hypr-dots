local M = {}
local configs = require("tomeczku.configs.toggleterm_conf")

M = {
  "akinsho/toggleterm.nvim",
  lazy = false,
  version = "*",
  opts = configs.opts,
  config = configs.config_function,
}

return M
