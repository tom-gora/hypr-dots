local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.mason_conf")
end

M = {
	"williamboman/mason-lspconfig.nvim",
	cond = vim.g.vscode == nil,
	dependencies = conf.dependencies,
	config = conf.config_function,
}

return M
