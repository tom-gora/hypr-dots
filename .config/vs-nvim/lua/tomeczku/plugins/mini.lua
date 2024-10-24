local M = {}
local config = require("tomeczku.configs.mini_conf")
M = {
	{
		"echasnovski/mini.indentscope",
		event = "VeryLazy",
		opts = config.indentscope.opts,
		init = config.indentscope.init_function,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			highlight_duration = 1000,
			custom_surroundings = {
				["("] = { output = { left = "(", right = ")" } },
				["/"] = { output = { left = "/*\n", right = "\n*/" } },
			},
		},
		config = true,
	},
	{
		"echasnovski/mini.move",
		version = "*",
		opts = config.move.opts,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		event = "VeryLazy",
		config = true,
	},
}

return M
