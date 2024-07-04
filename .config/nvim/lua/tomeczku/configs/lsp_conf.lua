local M = {}

M.config_fuction = function()
	local lspconfig = require("lspconfig")
	local mason_conf = require("tomeczku.configs.mason_conf")
	local lsps = mason_conf.mason_lspconfig.ensure_installed
	for _, lsp in ipairs(lsps) do
		lspconfig[lsp].setup({})
	end
	lspconfig.lua_ls.setup({
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
end

return M
