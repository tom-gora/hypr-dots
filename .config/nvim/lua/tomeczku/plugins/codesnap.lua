local M = {}

M = {
	"mistricky/codesnap.nvim",
	cond = vim.g.vscode == nil,
	build = "make",
	keys = {
		{ "<leader>C", "<cmd>CodeSnap<cr>", mode = "n", desc = "󰄄 CodeSnap" },
		{ "<leader>S", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "󰄄 CodeSnap" },
	},
	cmd = { "CodeSnap", "CodeSnapSave" },
	opts = {
		save_path = os.getenv("HOME") .. "/Pictures/CodeSnaps/" or "~/Pictures/CodeSnaps/",
		mac_window_bar = true,
		has_breadcrumbs = true,
		breadcrumbs_separator = " > ",
		has_line_number = true,
		bg_color = "#EEEEEE",
		-- bg_theme = "grape",
		watermark = "",
		title = "",
		bg_x_padding = 30,
		bg_y_padding = 20,
		code_font_family = "Operator-Caska",
	},
}

return M
