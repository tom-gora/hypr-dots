local M

M = {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	---@module "quicker"
	---@type quicker.SetupOptions
	opts = {
		edit = { enabled = false },
		highlight = {
			treesitter = true,
			lsp = true,
			load_buffers = false,
		},
		follow = { enabled = true },
	},
}

return M
