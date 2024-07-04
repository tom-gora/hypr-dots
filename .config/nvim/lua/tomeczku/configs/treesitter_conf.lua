local M = {}

M.opts = {
	ensure_installed = {
		"vim",
		"vimdoc",
		"query",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"markdown",
		"markdown_inline",
		"bash",
		"c_sharp",
		"json",
		"java",
		"php",
		"sql",
		"toml",
		"xml",
		"astro",
		"qmljs",
		"qmldir",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
	highlight = {
		enable = true,
	},
	auto_install = true,
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-CR>",
			node_incremental = "<C-CR>",
			-- scope_incremental = "<S-Space>",
			node_decremental = "<C-bs>",
		},
	},
}

M.event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" }

return M
