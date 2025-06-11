local M

M = {
	"azorng/goose.nvim",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				preferred_picker = "fzf",
				default_global_keymaps = false,
				anti_conceal = { enabled = false },
			},
		},
	},
	config = function()
		local win_cfg = require("goose.ui.window_config")
		win_cfg.base_window_opts = {
			title = "Goose",
			title_pos = "right",
			relative = "editor",
			style = "minimal",
			border = "single",
			zindex = 50,
			width = 1,
			height = 1,
			col = 0,
			row = 0,
		}
		require("goose").setup({})
	end,
}

return M
