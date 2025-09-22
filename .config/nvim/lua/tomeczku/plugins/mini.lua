if vim.g.vscode then
	return
end

local M

M = {
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			local opts = {
				highlight_duration = 1000,
				custom_surroundings = {
					["("] = { output = { left = "(", right = ")" } },
					["/"] = { output = { left = "/*\n", right = "\n*/" } },
				},
			}
			require("mini.surround").setup(opts)
		end,
	},
	{
		"echasnovski/mini.move",
		cond = vim.g.vscode == nil,
		version = "*",
		config = function()
			local opts = {
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
			}
			require("mini.move").setup(opts)
		end,
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
			require("mini.indentscope").setup({
				draw = {
					delay = 50,
					animation = require("mini.indentscope").gen_animation.none(),
				},
				symbol = "▏",
				options = { try_as_border = true },
			})
		end,
	},
	{
		"echasnovski/mini.notify",
		version = "*",
		config = function()
			local n = require("mini.notify")

			local win_config = function()
				local has_statusline = vim.o.laststatus > 0
				local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
				return {
					title = "",
					border = "solid",
					anchor = "SE",
					col = vim.o.columns,
					row = vim.o.lines - bottom_space,
				}
			end
			n.setup({
				lsp_progress = {
					duration_last = 3000,
				},
				window = {
					config = win_config,
					winblend = 20,
				},
			})
			vim.notify = n.make_notify()
		end,
	},
}

return M
