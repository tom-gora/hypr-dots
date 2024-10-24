local M = {}
local conf
if not vim.g.vscode then
	conf = require("tomeczku.configs.treesitter_conf")
end

M = {
	"nvim-treesitter/nvim-treesitter",
	cond = vim.g.vscode == nil,
	event = conf.event,
	dependencies = conf.dependencies,
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	build = ":TSUpdate",
	config = conf.config_function,
}

return M
