local M = {}
local opts = {
	default_keymappings_enabled = true,
	prefix = "<leader>~",
	enabled_methods = {
		"to_upper_case",
		"to_lower_case",
		"to_snake_case",
		"to_dash_case",
		"to_title_dash_case",
		"to_constant_case",
		"to_dot_case",
		"to_phrase_case",
		"to_camel_case",
		"to_pascal_case",
		"to_title_case",
	},
}

M.dependencies = { "nvim-telescope/telescope.nvim" }

M.config_function = function()
	require("textcase").setup(opts)
	require("telescope").load_extension("textcase")
end
M.cmd_list = {
	"TextCaseOpenTelescope",
	"TextCaseOpenTelescopeQuickChange",
	"TextCaseOpenTelescopeLSPChange",
	"TextCaseStartReplacingCommand",
}

M.key_list = {
	"<leader>~",
	{ "<leader>~t", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope Case Picker" },
}

return M
