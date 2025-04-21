if vim.g.vscode then
	return
end

local M, opts

opts = {
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
}

M = {
	{
		"folke/lazydev.nvim",
		enabled = false,
		cond = vim.g.vscode == nil,
		ft = "lua", -- only load on lua files
		opts = opts,
	},
}

return M
