local M = {}
local conf = require("tomeczku.configs.lsp_conf")

M = {
	"neovim/nvim-lspconfig",
	config = conf.config_fuction,
}

return M
