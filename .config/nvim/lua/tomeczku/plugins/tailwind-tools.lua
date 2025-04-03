if vim.g.vscode then
	return
end

local M, opts

opts = {
	cmp = {
		highlight = "foreground",
	},
	document_color = {
		enabled = true, -- can be toggled by commands
		kind = "inline", -- "inline" | "foreground" | "background"
		inline_symbol = " ", -- only used in inline mode
		debounce = 200, -- in milliseconds, only applied in insert mode
	},
	conceal = {
		enabled = true, -- can be toggled by commands
		min_length = 15, -- only conceal classes exceeding the provided length
		symbol = "󱏿", -- only a single character is allowed
		highlight = { -- extmark highlight options, see :h 'highlight'
			fg = "#1a98d8",
		},
	},
}

M = {
	"luckasRanarison/tailwind-tools.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = opts,
}

return M
