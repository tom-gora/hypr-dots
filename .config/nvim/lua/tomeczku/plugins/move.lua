local M = {}
local conf = require "tomeczku.configs.move_conf"

M = {
  "fedepujol/move.nvim",
  event = "BufRead",
  opts = conf.opts,
  config = conf.set_binds()

}

return M
