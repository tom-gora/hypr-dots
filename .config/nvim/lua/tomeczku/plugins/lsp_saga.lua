local M = {}
local conf = require("tomeczku.configs.lsp_saga_conf")

M = {
  'nvimdev/lspsaga.nvim',
  event = "LspAttach",
  config = true,
  opts = conf.opts,
  dependencies = conf.dependecies
}

return M
