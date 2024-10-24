local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.text_case_conf")
end

M = {
	"johmsalas/text-case.nvim",
	cond = vim.g.vscode == nil,
	lazy = true,
	dependencies = conf.dependencies,
	config = conf.config_function,
	keys = conf.key_list,
	cmd = conf.cmd_list,
}

return M
