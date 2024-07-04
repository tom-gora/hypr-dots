---@type NvPluginSpec[]
local M = {}

M = {
  "stevearc/conform.nvim",
  --  for users those who want auto-save conform + lazyloading!
  lazy = false,
  event = "BufWritePre",
  config = function()
    require "custom.configs.conform_conf"
  end,
}

return M
