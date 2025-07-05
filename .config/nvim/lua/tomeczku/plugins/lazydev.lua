if vim.g.vscode then
	return
end

local M, opts, init_function

init_function = function()
	-- override the lsp names because folke might never come back from this vacation XD
	local supported_lua_lsps = { "lua_ls", "lua-language-server", "emmylua_ls" }
	---@diagnostic disable-next-line: undefined-doc-name
	---@param client vim.lsp.Client
	local function _supports_override(client)
		---@diagnostic disable-next-line: undefined-field
		return client and vim.tbl_contains(supported_lua_lsps, client.name)
	end
	require("lazydev.lsp").supports = _supports_override
	vim.g.lazydev_enabled = true
end

opts = {
	runtime = vim.env.VIMRUNTIME,
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "wezterm-types", mods = { "wezterm" } },
		{ diagnostics = {
			globals = { "vim", "vim.g", "_G" },
		} },
	},
	integrations = {
		lspconfig = false,
		coc = false,
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
		ft = "lua",
		opts = opts,
		init = init_function,
	},
}

return M
