---@type NvPluginSpec[]
local M = {}
local overrides = require "custom.configs.chad_overrides_conf"

M = {
  "williamboman/mason.nvim",
  opts = overrides.mason,
}

return M
