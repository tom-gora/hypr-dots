local M = {}

M = {
  "gbprod/cutlass.nvim",
  event = "BufReadPost",
  opts = require "custom.configs.cutlass_conf",
}

return M
