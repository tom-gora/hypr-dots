---@type NvPluginSpec[]
local M = {}
local overrides = require "custom.configs.overrides"

M = {
  "williamboman/mason.nvim",
  opts = overrides.mason,
}

return M
