local M = {}
local config
if not vim.g.vscode then
	config = require("tomeczku.configs.mini_conf")
end

M = {
	-- {
	-- 	"echasnovski/mini.indentscope",
	-- 	cond = vim.g.vscode == nil,
	-- 	event = "VeryLazy",
	-- 	opts = config.indentscope.opts,
	-- 	init = config.indentscope.init_function,
	-- },
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
		cond = vim.g.vscode == nil,
		version = "*",
		opts = config.move.opts,
	},
	{
		"echasnovski/mini.ai",
		cond = vim.g.vscode == nil,
		version = "*",
		event = "VeryLazy",
		config = true,
	},
}

return M
