local M = {}
local conf = require "custom.configs.flash_conf"

M = {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = conf.opts,
  keys = conf.keys,
}

return M
