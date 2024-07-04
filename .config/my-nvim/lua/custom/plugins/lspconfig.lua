local M = {}

M = {
  "neovim/nvim-lspconfig",
  config = function()
    require "plugins.configs.lspconfig"
    require "custom.configs.lspconfig_conf"
  end, -- Override to setup mason-lspconfig
}

return M
