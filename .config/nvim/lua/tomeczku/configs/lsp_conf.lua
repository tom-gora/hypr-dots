local M = {}
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	nmap("<leader>lp", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
	nmap("<leader>ln", vim.diagnostic.goto_next, "Go to next diagnostic message")
	vim.keymap.set("i", "<leader>lg", vim.lsp.buf.signature_help, { buffer = 0 })
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")

	nmap("<leader>lc", vim.lsp.buf.code_action, "LSP: Code Actions")
	nmap("<leader>lR", vim.lsp.buf.rename, "LSP: Rename Symbol")

	nmap("<leader>lf", vim.lsp.buf.format, "LSP: Format Buffer")
	nmap("<leader>li", "<cmd>LspInfo<cr>", "LSP: Info")
end
local capabilities
local ok, blink = pcall(require, "blink.cmp")
if ok then
	capabilities = require("blink.cmp").get_lsp_capabilities()
else
	capabilities = vim.lsp.protocol.make_client_capabilities()
end

M.config_fuction = function()
	-- additionally configure lspinfo win border
	require("lspconfig.ui.windows").default_options = { border = "rounded" }

	local lspconfig = require("lspconfig")

	local root_pattern = lspconfig.util.root_pattern
	local mason_conf = require("tomeczku.configs.mason_conf")
	local lsps = mason_conf.mason_lspconfig.ensure_installed

	-- per lsp adjustments
	for _, lsp in ipairs(lsps) do
		if lsp == "bashls" then
			lspconfig.bashls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				-- make it attach to additional filetypes
				filetypes = { "sh", "zsh" },
			})
		elseif lsp == "emmet_language_server" then
			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				-- make it attach to additional filetypes
				filetypes = {
					"astro",
					"css",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"typescriptreact",
					"blade",
				},
			})
		elseif lsp == "astro" then
			--pass path to typescript for astro to work
			lspconfig.astro.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = {
					typescript = {
						tsdk = vim.fs.normalize("/usr/local/lib/node_modules/typescript/lib"),
					},
				},
			})
		elseif lsp == "phpactor" then
			lspconfig.phpactor.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				-- same extended filetype pool for phpactor to include blade files
				filetypes = { "blade", "php" },
			})
		elseif lsp == "tailwindcss" then
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				-- same but expliocitly  get supported types from plugin helper function
				filetypes = require("tailwind-tools.filetypes").get_all(),
			})
		elseif lsp == "tsserver" or lsp == "ts_ls" then
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				-- same spiel
				filetypes = {
					"astro",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"javascript",
					"javascriptreact",
					"javascript.jsx",
				},
				-- make it not confused in some non-standard projects
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
				capabilities = capabilities,
				on_attach = on_attach,
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end
					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
				end,
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
				capabilities = capabilities,
				on_attach = on_attach,
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
				on_attach = on_attach,
				init_options = {
					configurationSection = { "html", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
				single_file_support = true,
				filetypes = {
					"html",
					"javascript",
				},
			})
		elseif lsp == "gopls" then
			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				completeUnimported = true,
				analyses = { unusedparams = true },
				staticcheck = true,
			})
		elseif lsp == "yamlls" then
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				flags = lsp_flags,
				settings = {
					yaml = {
						format = {
							enable = true,
						},
						schemaStore = {
							enable = true,
						},
					},
				},
			})
		elseif lsp == "cssls" then
			-- custom capabilities for cssls because otherwise no completions work??
			local c = vim.lsp.protocol.make_client_capabilities()
			c.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.cssls.setup({
				capabilities = c,
				on_attach = on_attach,
				filetypes = { "css", "scss", "less" },
				provideFormatter = true,
				single_file_support = true,
				cmd = { "vscode-css-language-server", "--stdio" },
				settings = {
					css = {
						validate = true,
					},
					less = {
						validate = true,
					},
					scss = {
						validate = true,
					},
				},
			})
		else
			lspconfig[lsp].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end
	end

	local lsp_hacks = vim.api.nvim_create_augroup("LspHacks", { clear = true })

	-- vim.api.nvim_create_autocmd("LspAttach", {
	-- 	group = lsp_hacks,
	-- 	callback = function(e)
	-- 		local c = vim.lsp.get_client_by_id(e.data.client_id)
	-- 		if c then
	-- 			c.server_capabilities.semanticTokensProvider = nil
	-- 		end
	-- 	end,
	-- })

	-- setup hyprls
	vim.api.nvim_create_autocmd({ "FileType" }, {
		group = lsp_hacks,
		pattern = "hyprlang",
		callback = function()
			vim.lsp.start({
				name = "hyprls",
				cmd = { "hyprls" },
				root_dir = vim.fn.getcwd(),
			})
		end,
	})
end

return M
