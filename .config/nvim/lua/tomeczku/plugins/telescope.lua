local M = {}
local conf = require("tomeczku.configs.telescope_conf")

M = {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  branch = "0.1.x",
  dependencies = conf.dependencies,
  config = conf.config_function,
}

return M
