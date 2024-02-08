---@type NvPluginSpec[]
local M = {}

local overrides = require "custom.configs.overrides"

M = {
  "nvim-treesitter/nvim-treesitter",
  opts = overrides.treesitter,
}

return M
