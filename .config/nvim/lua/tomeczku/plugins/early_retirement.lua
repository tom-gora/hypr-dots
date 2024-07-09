local M = {}
local opts = require("tomeczku.configs.early_retirement_conf").opts
M = {
  "chrisgrieser/nvim-early-retirement",
  config = true,
  event = "VeryLazy",
  opts = opts,
}

return M
