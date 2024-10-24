local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.noice_conf")
end

M = {
	"folke/noice.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	opts = conf.opts,
	dependencies = conf.dependencies,
	config = vim.schedule(conf.no_spinner),
}

return M
