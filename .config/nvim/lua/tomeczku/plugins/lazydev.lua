if vim.g.vscode then
	return
end

local M, dependencies, opts, cmp_provider

cmp_provider = {
	name = "LazyDev",
	module = "lazydev.integrations.blink",
	-- make lazydev completions top priority (see `:h blink.cmp`)
	score_offset = 100,
}

dependencies = {
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{ -- optional completion source for require statements and module annotations
		"saghen/blink.cmp",
		optional = true,
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources.default, "lazydev")
			opts.sources.providers = opts.sources.providers or {}
			opts.sources.providers["lazydev"] = cmp_provider
		end,
	},
}

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
		cond = vim.g.vscode == nil,
		ft = "lua", -- only load on lua files
		dependencies = dependencies,
		opts = opts,
	},
}

return M
