local M = {}

M.mason = {
	ui = {
		border = "rounded",
		height = 0.8,
		width = 0.7,
	},
	automatic_installation = true,
	ensure_installed = {
		-- lua stuff "lua_ls",
		"stylua",
		"luacheck",

		-- web dev stuff
		"emmet_language_server",
		"cssls",
		"html",
		"jsonls",
		"ts_ls",
		"prettier",
		"prettierd",
		"tailwindcss",
		"astro",
		-- "stimulus-language-server",

		--shell
		"bashls",
		"shfmt",

		-- OTHER
		-- poor mans java ls
		-- "jdtls",
		-- and a formatter
		-- "google-java-format",
		-- c#
		-- "csharp-language-server", -- damn wont do, schoo requires older .net
		"omnisharp",
		-- xml stuff
		"lemminx",
		"xmlformatter",
		-- hyprland configurations ls
		"hyprls",
		--go stuff
		"gopls",
		"gofumpt",
		--yaml
		"yamlls",
		"docker_compose_language_service",

		--
		-- LINTERS
		"htmlhint",
		"revive",
		"shellcheck",
		"eslint_d",
		"blade-formatter",
	},
}

M.mason_lspconfig = {
	ensure_installed = {
		"bashls",
		"lua_ls",
		"omnisharp",
		"lemminx",
		"emmet_language_server",
		"cssls",
		"cssmodules_ls",
		"html",
		"jsonls",
		"ts_ls",
		"tailwindcss",
		-- "intelephense",
		"phpactor",
		"astro",
		"gopls",
		-- "hyprls",
	},
}

M.dependencies = {
	"williamboman/mason.nvim",
	lazy = false,
	cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll" },
	config = function()
		local mason = M.mason
		require("mason").setup(mason)
	end,
}

M.config_function = function()
	require("mason-lspconfig").setup(M.mason_lspconfig)
end

return M
