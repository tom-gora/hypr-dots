local M = {}
local config_function
if not vim.g.vscode then
	config_function = require("tomeczku.configs.better_escape_conf").config_function
end

M = {
	"max397574/better-escape.nvim",
	cond = vim.g.vscode == nil,
	event = "InsertEnter",
	config = config_function,
}

return M
