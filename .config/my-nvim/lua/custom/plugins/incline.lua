local M = {}
local config_function = require("custom.configs.incline_conf").config_function

M = {
  "b0o/incline.nvim",
  event = "VeryLazy",
  config = config_function,
}

return M
