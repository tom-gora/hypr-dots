if vim.g.vscode then
	return
end

local M

M = {
	-- -- replacing snacks' scroll as the latter is buggy AF on repeated j/k movements
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	version = "*",
	-- 	opts = {
	-- 		open = { enable = false },
	-- 		close = { enable = false },
	-- 	},
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
	},
	{
		"echasnovski/mini.move",
		cond = vim.g.vscode == nil,
		version = "*",
		opts = {
			reindent_linewise = true,
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
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
}

return M
