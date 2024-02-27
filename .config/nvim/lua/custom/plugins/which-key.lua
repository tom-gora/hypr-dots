----------------------------------------------[ modification to whichkey ]
local M = {}
local configs = require "custom.configs.which-key_conf"

M = {
  "folke/which-key.nvim",
  opts = configs.opts,
  config = configs.config_function,
}

return M
