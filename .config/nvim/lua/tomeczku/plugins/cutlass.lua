local M = {}
local opts = require("tomeczku.configs.cutlass_conf").opts

M = {
  "gbprod/cutlass.nvim",
  event = "BufReadPost",
  opts = opts,
}

return M
