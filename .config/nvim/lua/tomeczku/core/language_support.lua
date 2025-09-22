local M = {}

M.mason_required_packages = {
	-- LSP (Language Servers)
	"bash-language-server",
	"emmet-language-server",
	"html-lsp",
	-- "lua-language-server",
	"emmylua_ls",
	"docker-compose-language-service",
	"yaml-language-server",
	"json-lsp",
	"tailwindcss-language-server",
	"lemminx",
	"phpactor",
	"hyprls",
	"dockerfile-language-server",
	"gopls",
	"typescript-language-server",
	"astro-language-server",
	"css-variables-language-server",
	"cssmodules-language-server",
	"css-lsp",
	"marksman",
	-- "harper-ls",
	-- Formattes
	"svelte-language-server",
	"prettierd",
	"blade-formatter",
	"gofumpt",
	"prettier",
	"xmlformatter",
	"shfmt",
	"stylua",
	-- Linters
	"revive",
	"stylelint",
	"luacheck",
	"htmlhint",
	"shellcheck",
	"eslint_d",
	"markuplint",
}

M.autoMasonInstall = function()
	local r = require("mason-registry")
	local m_api = require("mason.api.command")
	local failed = ""
	for _, pkg in ipairs(M.mason_required_packages) do
		if not r.is_installed(pkg) then
			local ok, _ = pcall(m_api.MasonInstall, { pkg })
			if not ok then
				failed = failed .. ",\n " .. pkg
			end
			vim.notify("Installing : " .. pkg, vim.log.levels.INFO)
		end
	end
	if #failed > 0 then
		vim.notify("Failed to autoinstall: \n" .. failed, vim.log.levels.ERROR, { timeout = 5000 })
	end
end

-- these work via plugin's ensure_istalled table without manual installation call
M.required_ts_parsers = {
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
	"hyprlang",
	"regex",
	"rasi",
	"gomod",
	"go",
	"gosum",
	"gowork",
	"goctl",
}

-- these are just assignment declarations. formatters are installed by mason
M.required_formatters = {
	lua = { "stylua" },
	javascript = { "prettierd" },
	javascriptreact = { "prettierd" },
	typescript = { "prettierd" },
	typescriptreact = { "prettierd" },
	html = { "prettierd" },
	markdown = { "prettierd" },
	zshrc = { "shfmt" },
	css = { "prettierd" },
	cshtml = { "prettierd" },
	json = { "prettierd" },
	sh = { "shfmt" },
	xml = { "xmlformatter" },
	csproj = { "xmlformatter" },
	java = { "google-java-format" },
	astro = { "prettier" },
	php = { "pint" },
	blade = { "blade-formatter" },
	svg = { "xmlformat" },
	go = { "gofumpt" },
	yaml = { "prettierd" },
	["yaml.docker-compose"] = { "prettierd" },
}

return M
