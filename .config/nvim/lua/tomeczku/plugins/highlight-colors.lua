local M = {}

M = {
	"brenoprata10/nvim-highlight-colors",
	event = "VeryLazy",
	-- enabled = false,
	cond = vim.g.vscode == nil,
	opts = {},
}

return M
