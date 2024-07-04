local M = {}
local conf = require("tomeczku.configs.treesitter_conf")

M = {
	"nvim-treesitter/nvim-treesitter",
	event = conf.event,
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	build = ":TSUpdate",
	opts = conf.opts,
	config = true,
}

return M
