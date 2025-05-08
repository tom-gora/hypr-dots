if vim.g.vscode then
	return
end

local M, opts

opts = {
	runtime = vim.env.VIMRUNTIME,
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "wezterm-types", mods = { "wezterm" } },
	},
	integrations = {
		lspconfig = false,
		cmp = false,
		blink = true,
	},
	enabled = function(_)
		return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
	end,
}

M = {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = opts,
		init = function()
			vim.g.lazydev_enabled = true
		end,
	},
}

return M
