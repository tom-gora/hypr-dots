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

	-- per lsp adjustments

	for _, lsp in ipairs(lsps) do
		if lsp == "bashls" then
			-- make bashls attach to additional filetypes
			lspconfig.bashls.setup({
				capabilities = capabilities,
				filetypes = { "sh", "zsh" },
			})
		elseif lsp == "emmet_language_server" then
			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
				filetypes = {
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
				init_options = {
					typescript = {
						tsdk = vim.fs.normalize("/usr/local/lib/node_modules/typescript/lib"),
					},
				},
			})
		elseif lsp == "phpactor" then
			-- same extended filetype pool for phpactor to include blade files
			lspconfig.phpactor.setup({
				capabilities = capabilities,
				filetypes = { "blade", "php" },
			})
		elseif lsp == "tailwindcss" then
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = require("tailwind-tools.filetypes").get_all(),
			})
		elseif lsp == "astro" then
			--pass path to typescript for astro to work
			lspconfig.astro.setup({
				capabilities = capabilities,
				init_options = {
					typescript = {
						tsdk = vim.fs.normalize("/usr/local/lib/node_modules/typescript/lib"),
					},
				},
			})
		elseif lsp == "tsserver" or lsp == "ts_ls" then
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
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
				capabilities = capabilities,
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
				capabilities = capabilities,
				filetypes = { "php" },
			})
		elseif lsp == "gopls" then
			lspconfig.gopls.setup({
				capabilities = capabilities,
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

	local lsp_hacks = vim.api.nvim_create_augroup("LspHacks", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_hacks,
		callback = function(e)
			local c = vim.lsp.get_client_by_id(e.data.client_id)
			if c then
				c.server_capabilities.semanticTokensProvider = nil
			end
		end,
	})

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

	-- and intelephense
	-- vim.api.nvim_create_autocmd({ "FileType" }, {
	-- 	group = lsp_hacks,
	-- 	pattern = "php",
	-- 	callback = function()
	-- 		vim.lsp.start({
	-- 			name = "intelephense",
	-- 			cmd = { "intelephense", "--stdio" },
	-- 			root_dir = vim.fn.getcwd(),
	-- 		})
	-- 	end,
	-- })
end

return M
