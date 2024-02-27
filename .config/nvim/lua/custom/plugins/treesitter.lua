---@type NvPluginSpec[]
local M = {}

local overrides = require "custom.configs.chad_overrides_conf"

M = {
  "nvim-treesitter/nvim-treesitter",
  opts = overrides.treesitter,
}

return M
