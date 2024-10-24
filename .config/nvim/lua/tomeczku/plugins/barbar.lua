local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.barbar_conf")
end

M = {
	"romgrk/barbar.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	dependencies = conf.dependencies,
	init = conf.init_function(),
	opts = conf.opts,
}
return M
