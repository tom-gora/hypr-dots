local M, aider_opts, config_function

aider_opts = {
	aider_cmd = "TERM=xterm-256color aider",
	args = {
		"--no-auto-commits",
		"--stream",
		"--fancy-input",
		"--subtree-only",
		"--config",
		"$HOME/.config/aider/aider-default.conf.yml",
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
}

config_function = function()
	-- set globals for aider integrations
	_G.AIDER_RUNNING = false
	_G.AIDER_WRITING = false
	_G.AIDER_MODELS = {
		default_coding = {
			model = "openrouter/openai/gpt-4o-mini",
			weak_model = "openrouter/qwen/qwen-2.5-coder-32b-instruct",
		},
		writing = {
			model = "openrouter/google/gemini-2.5-flash-preview",
			weak_model = "openrouter/deepseek/deepseek-prover-v2:free",
		},
	}
	-- call plugin setup
	require("nvim_aider").setup(aider_opts)
end

M = {
	"GeorgesAlkhouri/nvim-aider",
	cmd = "Aider",
	config = config_function,
}

return M
