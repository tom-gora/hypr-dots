local M = {}
local conf = require("tomeczku.configs.registers_conf")

M = {
  "tversteeg/registers.nvim",
  cmd = "Registers",
  config = true,
  opts = conf.opts,
  keys = conf.keys,
  name = "registers",
}

return M
