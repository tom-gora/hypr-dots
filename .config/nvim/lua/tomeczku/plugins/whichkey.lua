local M = {}
local configs
if not vim.g.vscode then
	configs = require("tomeczku.configs.whichkey_conf")
end

M = {
	"folke/which-key.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	init = configs.init_function,
	opts = configs.opts,
	config = configs.config_function,
}

return M
