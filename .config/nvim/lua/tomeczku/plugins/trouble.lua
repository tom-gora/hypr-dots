local M
M = {
	"folke/trouble.nvim",
	opts = {
		focus = true,
		auto_jump = true,
		auto_close = true,
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>ll",
			"<cmd>Trouble diagnostics toggle <cr>",
			desc = "Trouble LSP Diagnostics",
		},
		{
			"<leader>lb",
			"<cmd>Trouble diagnostics toggle  filter.buf=0<cr>",
			desc = "Trouble LSP Buffer Diagnostics",
		},
		{
			"<leader>ld",
			"<cmd>Trouble lsp_definitions",
			desc = "Trouble LSP Definitions",
		},

		{
			"<leader>lD",
			"<cmd>Trouble lsp_type_definitions",
			desc = "Trouble LSP Type Definitions",
		},
		{
			"<leader>ls",
			"<cmd>Trouble symbols toggle <cr>",
			desc = "Trouble Symbols",
		},
		{
			"<leader>lS",
			"<cmd>Trouble document_symbols toggle <cr>",
			desc = "Trouble Document Symbols",
		},
		{
			"<leader>lr",
			"<cmd>Trouble lsp_references toggle  win.position=right<cr>",
			desc = "Trouble References",
		},
		{
			"<leader>lI",
			"<cmd>Trouble lsp_implementations  win.position=right<cr>",
			desc = "Trouble References",
		},
		{
			"<leader>lq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Trouble Quickfix List",
		},
	},
}

return M
