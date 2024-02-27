-- ----------------------------------------------------[ scope visualisation ]
local M = {}
local config = require "custom.configs.mini-indentscope_conf"

M = {
  "echasnovski/mini.indentscope",
  lazy = false,
  event = "BufReadPost",
  opts = config.opts,
  init = config.init_function,
}

return M
