-- ------------------------------------------------------------[ smartcolumn ]
local M = {}
M = {
  "m4xshen/smartcolumn.nvim",
  event = { "InsertEnter", "BufEnter" },
  opts = require "custom.configs.smartcolumn_conf",
}

return M
