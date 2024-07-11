local M = {}
local conf = require("tomeczku.configs.lsp_conf")


M = {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim" },
  cmd = { "LspInstall", "LspUninstall" },
  config = conf.config_fuction,
}

return M
