local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.oil_conf")
end

M = {
	"stevearc/oil.nvim",
	cond = vim.g.vscode == nil,
	dependencies = conf.dependecies,
	opts = conf.opts,
	init = conf.init_function,
}

return M
