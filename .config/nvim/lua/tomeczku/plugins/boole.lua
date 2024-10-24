local M = {}
local opts
if not vim.g.vscode then
	opts = require("tomeczku.configs.boole_conf").opts
end

M = {
	"nat-418/boole.nvim",
	-- cond = vim.g.vscode == nil,
	opts = opts,
}

return M
