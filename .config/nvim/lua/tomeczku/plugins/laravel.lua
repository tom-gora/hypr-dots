local M = {}
local config = require("tomeczku.configs.laravel_conf")

M = {
	{
		"adalessa/laravel.nvim",
		lazy = true,
		ft = config.ft,
		dependencies = config.dependencies,
		cmd = config.cmd,
		config = true,
	},

	config.bladenav,
}
return M
