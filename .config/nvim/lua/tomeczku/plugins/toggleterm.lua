local M = {}
local configs
if not vim.g.vscode then
	configs = require("tomeczku.configs.toggleterm_conf")
end

M = {
	"akinsho/toggleterm.nvim",
	cond = vim.g.vscode == nil,
	version = "*",
	event = "VeryLazy",
	opts = configs.opts,
	config = configs.config_function,
}

return M
