local M = {}
local conf = require("tomeczku.configs.treesitter_conf")

M = {
	"nvim-treesitter/nvim-treesitter",
	event = conf.event,
  dependencies = conf.dependencies,
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	build = ":TSUpdate",
	config = conf.config_function
}

return M
