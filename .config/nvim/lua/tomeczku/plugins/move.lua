local M = {}
local conf = require "tomeczku.configs.move_conf"

M = {
  "fedepujol/move.nvim",
  cmd = { "MoveBlock", "MoveLine", "MoveWord" },
  opts = conf.opts,
  config = conf.set_binds()

}

return M
