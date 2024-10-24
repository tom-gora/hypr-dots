local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.rainbow_delimiters_conf")
end

M = {
	"HiPhish/rainbow-delimiters.nvim",
	cond = vim.g.vscode == nil,
	lazy = false,
	config = conf.config_function,
}

return M
