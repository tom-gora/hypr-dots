local M

M = {
	"mistricky/codesnap.nvim",
	build = "make",
	cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
	opts = {
		mac_window_bar = false,
		watermark = "",
		has_line_number = true,
		has_breadcrumbs = true,
		save_path = "~/Pictures/CodeSnaps/",
		bg_color = "#ABB2BF",
	},
}

return M
