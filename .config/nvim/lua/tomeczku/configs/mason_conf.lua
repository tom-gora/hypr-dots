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
		"tsserver",
		"prettier",
		"prettierd",
		"htmlhint",
		"stylelint",
		"tailwindcss",
		"intelephense",
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
		-- "hyprls"
		"gopls",
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
		"tsserver",
		"tailwindcss",
		"intelephense",
		"astro",
		"gopls",
		-- "hyprls",
	},
}

M.dependencies = {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll" },
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = M.mason.ensure_installed,
		},
	},

	config = function()
		local mason = M.mason
		require("mason").setup(mason)
	end,
}

M.config_function = function()
	require("mason-lspconfig").setup(M.mason_lspconfig)
end

return M
