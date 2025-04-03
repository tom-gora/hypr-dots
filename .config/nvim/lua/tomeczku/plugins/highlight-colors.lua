if vim.g.vscode then
	return
end

local M

M = {
	"brenoprata10/nvim-highlight-colors",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	opts = {},
}

return M
