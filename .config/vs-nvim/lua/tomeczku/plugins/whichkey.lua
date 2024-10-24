local M = {}
local configs = require("tomeczku.configs.whichkey_conf")

M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = configs.init_function,
	opts = configs.opts,
	config = configs.config_function,
}

return M
