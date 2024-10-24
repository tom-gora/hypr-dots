local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.lsp_conf")
end

M = {
	"neovim/nvim-lspconfig",
	cond = vim.g.vscode == nil,
	dependencies = { "williamboman/mason.nvim" },
	cmd = { "LspInstall", "LspUninstall" },
	config = conf.config_fuction,
}

return M
