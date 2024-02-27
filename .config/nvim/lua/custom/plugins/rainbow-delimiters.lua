-- --------------------------------------------[ colored pairs of delimiters ]
local M = {}
local configs = require "custom.configs.rainbow-delimiters_conf"

M = {
  "HiPhish/rainbow-delimiters.nvim",
  lazy = false,
  config = configs.config_function,
}

return M
