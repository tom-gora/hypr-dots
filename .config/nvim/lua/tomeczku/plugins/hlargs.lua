local M = {}
local opts
if not vim.g.vscode then
	opts = require("tomeczku.configs.hlargs_conf").opts
end

M = {
	"m-demare/hlargs.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	opts = opts,
}

return M
