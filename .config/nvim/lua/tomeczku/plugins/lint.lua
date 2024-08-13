-- luacheck: globals vim
local M = {}
local conf = require("tomeczku.configs.lint_conf")

M = {
	"rshkarin/mason-nvim-lint",
	dependencies = {
		{
			"mfussenegger/nvim-lint",
			event = conf.event,
			config = conf.config_function,
		},
	},
}
return M
