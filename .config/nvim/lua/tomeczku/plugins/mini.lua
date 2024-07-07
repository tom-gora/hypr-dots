local M = {}
local config = require "tomeczku.configs.mini_conf"

M = {
  "echasnovski/mini.indentscope",
  event = "VeryLazy",
  opts = config.indentscope.opts,
  init = config.indentscope.init_function,
}

return M
