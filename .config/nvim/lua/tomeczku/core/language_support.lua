local M = {}

M.mason_required_packages = {
	"prettierd",
	"bash-language-server",
	"emmet-language-server",
	"html-lsp",
	"blade-formatter",
	"emmylua_ls",
	"gofumpt",
	"prettier",
	"revive",
	"docker-compose-language-service",
	"yaml-language-server",
	"xmlformatter",
	"json-lsp",
	"tailwindcss-language-server",
	"shfmt",
	"lemminx",
	"phpactor",
	"stylelint",
	"hyprls",
	"dockerfile-language-server",
	"luacheck",
	"gopls",
	"htmlhint",
	"stylua",
	"shellcheck",
	"eslint_d",
	"typescript-language-server",
	"astro-language-server",
	"cssmodules-language-server",
	"css-lsp",
	"markuplint",
	"harper-ls",
}

M.autoMasonInstall = function()
	local r = require("mason-registry")
	local m_api = require("mason.api.command")
	local failed = ""
	for _, pkg in ipairs(M.mason_required_packages) do
		if not r.is_installed(pkg) then
			-- local cmd = "MasonInstall " .. pkg
			local ok, _ = pcall(m_api.MasonInstall, { pkg })
			if not ok then
				failed = failed .. ",\n " .. pkg
			end
			vim.notify("Installing : " .. pkg, vim.log.levels.INFO)
		end
	end
	vim.notify("Failed to autoinstall: \n" .. failed, vim.log.levels.ERROR, { timeout = 5000 })
end

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
