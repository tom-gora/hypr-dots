-- luacheck: globals vim
local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.lint_conf")
end

M = {
	"rshkarin/mason-nvim-lint",
	cond = vim.g.vscode == nil,
	dependencies = {
		{
			"mfussenegger/nvim-lint",
			event = conf.event,
			config = conf.config_function,
		},
	},
}
return M
