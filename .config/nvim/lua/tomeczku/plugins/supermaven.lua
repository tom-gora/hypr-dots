local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.supermaven_conf")
end

M = {
	"supermaven-inc/supermaven-nvim",
	cond = vim.g.vscode == nil,
	cmd = { "SupermavenStart", "SupermavenToggle" },
	lazy = false,
	opts = conf.opts,
	config = conf.config_function,
}

return M
