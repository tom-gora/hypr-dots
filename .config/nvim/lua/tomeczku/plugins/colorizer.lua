local M = {}
local opts
if not vim.g.vscode then
	opts = require("tomeczku.configs.colorizer_conf")
end

M = {
	"NvChad/nvim-colorizer.lua",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	config = true,
	opts = opts,
}

return M
