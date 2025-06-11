if vim.g.vscode then
	return
end

local M

M = {
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
	},
	{
		"echasnovski/mini.move",
		cond = vim.g.vscode == nil,
		version = "*",
		opts = {
			reindent_linewise = true,
			mappings = {
				left = "<a-h>",
				right = "<a-l>",
				down = "<a-j>",
				up = "<a-k>",

				-- Move current line in Normal mode
				line_left = "<a-h>",
				line_right = "<a-l>",
				line_down = "<a-j>",
				line_up = "<a-k>",
			},
		},
	},
	{
		"echasnovski/mini.ai",
		cond = vim.g.vscode == nil,
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		config = function()
			local symbol = "▏"
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none(),
				},
				symbol = symbol,
				options = {
					try_as_border = true,
				},
			})
		end,
	},
}

return M
