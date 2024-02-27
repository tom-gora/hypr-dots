local M = {}
local config_function = require("custom.configs.hardtime_conf").config_function

M = {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  lazy = false,
  config = config_function,
}

return M
