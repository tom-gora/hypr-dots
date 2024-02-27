local M = {}
local opts = require "custom.configs.colorizer_conf"

M = {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup(opts)
  end,
}

return M
