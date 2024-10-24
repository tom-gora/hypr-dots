local M = {}
local opts
if not vim.g.vscode then
	opts = require("tomeczku.configs.cutlass_conf").opts
end

M = {
	"gbprod/cutlass.nvim",
	cond = vim.g.vscode == nil,
	event = "BufReadPost",
	opts = opts,
}

return M
