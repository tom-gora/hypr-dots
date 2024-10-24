local M = {}
local conf = require("tomeczku.configs.noice_conf")

M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = conf.opts,
  dependencies = conf.dependencies,
  config = vim.schedule(conf.no_spinner)
}

return M
