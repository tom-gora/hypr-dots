local M = {}
local config_function = require("tomeczku.configs.better_escape_conf").config_function

M = {
  "max397574/better-escape.nvim",
  event = "VeryLazy",
  config = config_function,
}

return M
