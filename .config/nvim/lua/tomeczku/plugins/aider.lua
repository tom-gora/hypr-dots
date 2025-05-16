local M
M = {
	"GeorgesAlkhouri/nvim-aider",
	cmd = "Aider",
	opts = {
		aider_cmd = "TERM=xterm-256color aider",
		args = {
			"--no-auto-commits",
			"--stream",
			"--fancy-input",
			"--config",
			"~/.config/aider/aider-default.conf.yml",
		},
		theme = {
			user_input_color = "#c4a7e7",
			tool_output_color = "#3e8fb0",
			tool_error_color = "#eb6f92",
			tool_warning_color = "#f6c177",
			assistant_output_color = "#9ccfd8",
			completion_menu_color = "#e0def4",
			completion_menu_bg_color = "#14161b",
			completion_menu_current_color = "#C18FFF",
			completion_menu_current_bg_color = "#14161b",
		},
		auto_reload = true,
		dependencies = {
			"folke/snacks.nvim",
		},
		picker_cfg = {
			cycle = false,
			preset = function()
				return vim.o.columns >= 106 and "ivy" or "right"
			end,
		},
		win = {
			wo = { winbar = "  AIDER" },
		},
	},
}

return M
