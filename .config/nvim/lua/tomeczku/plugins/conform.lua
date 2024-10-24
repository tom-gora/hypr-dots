local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.conform_conf")
end

M = {
	"stevearc/conform.nvim",
	cond = vim.g.vscode == nil,
	--  for users those who want auto-save conform + lazyloading!
	-- lazy = false,
	event = "LspAttach",
	config = conf.config_function,
}

return M
