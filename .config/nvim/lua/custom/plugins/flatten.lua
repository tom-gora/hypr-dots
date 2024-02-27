local M = {}

M = {
  "willothy/flatten.nvim",
  opts = require "custom.configs.flatten_conf",
  -- Ensure that it runs first to minimize delay when opening file from terminal
  lazy = false,
  priority = 1001,
}

return M
