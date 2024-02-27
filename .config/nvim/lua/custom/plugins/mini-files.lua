-- ----------------------------------------------------[ mini-files FS explorer]
local M = {}
local config = require "custom.configs.mini-files_conf"

M = {
  "echasnovski/mini.files",
  version = "*",
  name = "mini.files",
  event = "VeryLazy",
  opts = config.opts,
  config = config.config_function,
}
return M
