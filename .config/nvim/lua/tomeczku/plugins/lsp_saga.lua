local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.lsp_saga_conf")
end

M = {
	"nvimdev/lspsaga.nvim",
	cond = vim.g.vscode == nil,
	event = "LspAttach",
	config = true,
	opts = conf.opts,
	dependencies = conf.dependecies,
}

return M
