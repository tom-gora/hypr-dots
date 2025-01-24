local M
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.avante_conf")
end
M = {
	"yetone/avante.nvim",
	-- enabled = false,
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = conf.opts,
	build = "make",
	dependencies = conf.deps,
}

return M
