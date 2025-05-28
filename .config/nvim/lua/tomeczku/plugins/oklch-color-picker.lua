if vim.g.vscode then
	return
end

local M, opts

opts = {
	highlight = {
		style = "foreground+virtual_eol",
		bold = false,
		virtual_text = "",
		enabled_lsps = { "tailwindcss", "tailwindcss-language-server", "css-lsp", "css-variables-language-server" },
		emphasis = {
			-- Distance (0..1) to the editor background where emphasis activates (first item for dark themes, second for light ones).
			threshold = { 0.2, 0.17 },
			-- How much (0..255) to offset the color (first item for dark colors, second for light ones).
			amount = { 15, -80 },
		},
	},
}

M = {
	"eero-lehtinen/oklch-color-picker.nvim",
	event = "VeryLazy",
	version = "*",
	keys = {
		{
			"<leader>fc",
			function()
				require("oklch-color-picker").pick_under_cursor()
			end,
			desc = "Color pick under cursor",
		},
	},
	opts = opts,
}

return M
