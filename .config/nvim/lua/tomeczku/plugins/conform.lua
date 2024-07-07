local M = {}
local conf = require("tomeczku.configs.conform_conf")

M = {
  "stevearc/conform.nvim",
  --  for users those who want auto-save conform + lazyloading!
  lazy = false,
  event = "BufWritePre",
  config = conf.config_function
}

return M
