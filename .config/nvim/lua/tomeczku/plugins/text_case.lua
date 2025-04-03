if vim.g.vscode then
	return
end

local M, opts, key_list

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

key_list = {
	"<leader>~",

	{
		"<leader>~u",
		"<cmd>lua require('textcase').current_word('to_upper_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Upper Case",
	},
	{
		"<leader>~l",
		"<cmd>lua require('textcase').current_word('to_lower_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Lower Case",
	},
	{
		"<leader>~s",
		"<cmd>lua require('textcase').current_word('to_snake_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Snake Case",
	},
	{
		"<leader>~d",
		"<cmd>lua require('textcase').current_word('to_dash_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Dash Case",
	},
	{
		"<leader>~k",
		"<cmd>lua require('textcase').current_word('to_dot_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Dot Case",
	},
	{
		"<leader>~f",
		"<cmd>lua require('textcase').current_word('to_phrase_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Phrase Case",
	},
	{
		"<leader>~c",
		"<cmd>lua require('textcase').current_word('to_camel_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Camel Case",
	},
	{
		"<leader>~p",
		"<cmd>lua require('textcase').current_word('to_pascal_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Pascal Case",
	},
	{
		"<leader>~t",
		"<cmd>lua require('textcase').current_word('to_title_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Title Case",
	},
	{
		"<leader>~w",
		"<cmd>lua require('textcase').current_word('to_path_case')<CR>",
		mode = { "n" },
		desc = "Current Word to Path Case",
	},
	-- visual
	{
		"<leader>~u",
		"<cmd>lua require('textcase').current_word('to_upper_case')<CR>",
		mode = { "x" },
		desc = "Selection to Upper Case",
	},
	{
		"<leader>~l",
		"<cmd>lua require('textcase').current_word('to_lower_case')<CR>",
		mode = { "x" },
		desc = "Selection to Lower Case",
	},
	{
		"<leader>~s",
		"<cmd>lua require('textcase').current_word('to_snake_case')<CR>",
		mode = { "x" },
		desc = "Selection to Snake Case",
	},
	{
		"<leader>~d",
		"<cmd>lua require('textcase').current_word('to_dash_case')<CR>",
		mode = { "x" },
		desc = "Selection to Dash Case",
	},
	{
		"<leader>~k",
		"<cmd>lua require('textcase').current_word('to_dot_case')<CR>",
		mode = { "x" },
		desc = "Selection to Dot Case",
	},
	{
		"<leader>~f",
		"<cmd>lua require('textcase').current_word('to_phrase_case')<CR>",
		mode = { "x" },
		desc = "Selection to Phrase Case",
	},
	{
		"<leader>~c",
		"<cmd>lua require('textcase').current_word('to_camel_case')<CR>",
		mode = { "x" },
		desc = "Selection to Camel Case",
	},
	{
		"<leader>~p",
		"<cmd>lua require('textcase').current_word('to_pascal_case')<CR>",
		mode = { "x" },
		desc = "Selection to Pascal Case",
	},
	{
		"<leader>~t",
		"<cmd>lua require('textcase').current_word('to_title_case')<CR>",
		mode = { "x" },
		desc = "Selection to Title Case",
	},
	{
		"<leader>~w",
		"<cmd>lua require('textcase').current_word('to_path_case')<CR>",
		mode = { "x" },
		desc = "Selection to Path Case",
	},
	-- lsp rename hoo<cmd>ks
	{
		"<leader>~U",
		"<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Upper Case",
	},
	{
		"<leader>~L",
		"<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Lower Case",
	},
	{
		"<leader>~S",
		"<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Snake Case",
	},
	{
		"<leader>~D",
		"<cmd>lua require('textcase').lsp_rename('to_dash_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Dash Case",
	},
	{
		"<leader>~K",
		"<cmd>lua require('textcase').lspRename('to_dot_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Dot Case",
	},
	{
		"<leader>~F",
		"<cmd>lua require('textcase').lsp_rename('to_phrase_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Phrase Case",
	},
	{
		"<leader>~C",
		"<cmd>lua require('textcase').lspRename('to_camel_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Camel Case",
	},
	{
		"<leader>~P",
		"<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Pascal Case",
	},
	{
		"<leader>~T",
		"<cmd>lua require('textcase').lsp_rename('to_title_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Title Case",
	},
	{
		"<leader>~W",
		"<cmd>lua require('textcase').lspRename('to_path_case')<CR>",
		mode = { "n" },
		desc = "LSP Rename to Path Case",
	},
}

M = {
	"johmsalas/text-case.nvim",
	enabled = true,
	cond = vim.g.vscode == nil,
	lazy = true,
	opts = opts,
	keys = key_list,
	cmd = "TextCaseStartReplacingCommand",
}

return M
