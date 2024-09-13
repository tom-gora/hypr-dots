local M = {}

M.config_fuction = function()
	-- additionally configure lspinfo win border
	require("lspconfig.ui.windows").default_options.border = "rounded"

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	local lspconfig = require("lspconfig")

	local root_pattern = lspconfig.util.root_pattern
	local mason_conf = require("tomeczku.configs.mason_conf")
	local lsps = mason_conf.mason_lspconfig.ensure_installed
	for _, lsp in ipairs(lsps) do
		if lsp == "bashls" then
			-- make bashls attach to additional filetypes
			lspconfig.bashls.setup({
				filetypes = { "sh", "zsh" },
			})
		elseif lsp == "astro" then
			--pass path to typescript for astro to work
			lspconfig.astro.setup({
				init_options = {
					typescript = {
						tsdk = vim.fs.normalize("/usr/local/lib/node_modules/typescript/lib"),
					},
				},
			})
		elseif lsp == "tsserver" or lsp == "ts_ls" then
			lspconfig.ts_ls.setup({
				filetypes = {
					"astro",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"javascript",
					"javascriptreact",
					"javascript.jsx",
				},
				root_dir = root_pattern({
					"tsconfig.json",
					"package.json",
					"jsconfig.json",
				}) or root_pattern({
					".git",
				}),
			})
		elseif lsp == "lua_ls" then
			-- hide annoying messages about globals from lua_ls
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		elseif lsp == "omnisharp" then
			-- setup omnisharp
			lspconfig.omnisharp.setup({
				cmd = { "dotnet", "/home/tomeczku/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
				enable_editorconfig_support = true,
				enable_ms_build_load_projects_on_demand = false,
				enable_roslyn_analyzers = true,
				organize_imports_on_format = true,
				enable_import_completion = true,
				sdk_include_prereleases = true,
				analyze_open_documents_only = false,
			})
		elseif lsp == "html" then
			lspconfig.html.setup({
				capabilities = capabilities,
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
				single_file_support = true,
				filetypes = {
					"html",
					"css",
					"javascript",
				},
			})
		elseif lsp == "intelephense" then
			lspconfig.intelephense.setup({
				filetypes = { "php" },
			})
		elseif lsp == "gopls" then
			lspconfig.gopls.setup({
				completeUnimported = true,
				analyses = { unusedparams = true },
				staticcheck = true,
				on_attach = function()
					-- "n" means normal mode
					-- {buffer=0} means only for this buffer
					-- <cmd> == :
					-- <cr> == enter

					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
				end,
			})
		else
			lspconfig[lsp].setup({ capabilities = capabilities })
		end
	end

	-- setup hyprls
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "hyprlang",
		callback = function()
			vim.lsp.start({
				name = "hyprls",
				cmd = { "hyprls" },
				root_dir = vim.fn.getcwd(),
			})
		end,
	})

	-- and intelephense
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "php",
		callback = function()
			vim.lsp.start({
				name = "intelephense",
				cmd = { "intelephense", "--stdio" },
				root_dir = vim.fn.getcwd(),
			})
		end,
	})
end

return M
