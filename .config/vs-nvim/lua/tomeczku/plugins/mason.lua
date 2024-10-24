local M = {}

local conf = require("tomeczku.configs.mason_conf")

M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = conf.dependencies,
  config = conf.config_function,
}

return M
