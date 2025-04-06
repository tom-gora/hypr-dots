if vim.g.vscode then
	return
end

local M, opts

opts = {
	default_keymappings_enabled = true,
	prefix = "<leader>~",
	enabled_methods = {
		"to_upper_case",
		"to_lower_case",
		"to_snake_case",
		"to_dash_case",
		"to_dot_case",
		"to_phrase_case",
		"to_camel_case",
		"to_pascal_case",
		"to_title_case",
		"to_path_case",
	},
}

M = {
	"johmsalas/text-case.nvim",
	cond = vim.g.vscode == nil,
	lazy = true,
	opts = opts,
	cmd = "TextCaseStartReplacingCommand",
}

return M
