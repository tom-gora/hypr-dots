if vim.g.vscode then
	return
end

local M, opts

opts = {
	edit = { enabled = false },
	highlight = {
		treesitter = true,
		lsp = true,
		load_buffers = false,
	},
	follow = { enabled = true },
}

M = {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	opts = opts,
}

return M
