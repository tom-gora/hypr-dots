local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.gitsigns_conf")
end

M = {
	"lewis6991/gitsigns.nvim",
	cond = vim.g.vscode == nil,
	event = conf.events,
	config = conf.config_function,
}
return M
