local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.telescope_conf")
end

M = {
	"nvim-telescope/telescope.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	branch = "0.1.x",
	dependencies = conf.dependencies,
	config = conf.config_function,
}

return M
