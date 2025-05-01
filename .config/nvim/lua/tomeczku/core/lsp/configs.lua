local M = {}

M.lua_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name },
		filetypes = { "lua" },
		root_markers = { "init.lua", ".luarc.json", ".luarc.jsonc" },
		capabilities = capabilities,
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end
		end,
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = {
						"vim",
						"vim.g",
					},
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.stdpath("config") .. "/lua",
					},
				},
			},
		},
	}
	vim.lsp.enable(name)
end

M.bash_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name },
		filetypes = { "sh", "zsh" },
		capabilities = capabilities,
		on_attach = on_attach,
		-- make it attach to additional filetypes
	}
	vim.lsp.enable(name)
end

M.emmet_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "--stdio" },
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
		capabilities = capabilities,
		on_attach = on_attach,
	}
	vim.lsp.enable(name)
end

M.astro_setup = function(capabilities, on_attach, name)
	--pass path to typescript for astro to work
	vim.lsp.config[name] = {
		cmd = { "astro-ls" },
		filetypes = { "astro" },
		capabilities = capabilities,
		on_attach = on_attach,
		init_options = {
			typescript = {
				tsdk = vim.fs.normalize("/usr/local/lib/node_modules/typescript/lib"),
			},
		},
	}
	vim.lsp.enable(name)
end

M.phpactor_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name },
		-- same extended filetype pool for phpactor to include blade files
		filetypes = { "blade", "php" },
		capabilities = capabilities,
		on_attach = on_attach,
	}
	vim.lsp.enable(name)
end

M.tailwind_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name },
		-- same but expliocitly  get supported types from plugin helper function
		filetypes = require("tailwind-tools.filetypes").get_all(),
		capabilities = capabilities,
		on_attach = on_attach,
	}
	vim.lsp.enable(name)
end

M.typesctipt_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "--stdio" },
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
		capabilities = capabilities,
		on_attach = on_attach,
		-- make it not confused in some non-standard projects
		-- root_markers = function()
		-- 	local markers = {
		-- 		"tsconfig.json",
		-- 		"package.json",
		-- 		"jsconfig.json",
		-- 	}
		-- 	for _, marker in ipairs(markers) do
		-- 		if vim.fn.findfile(marker, vim.fn.getcwd(), 0) ~= "" then
		-- 			return markers
		-- 		end
		-- 	end
		-- 	return { ".git" }
		-- end,
	}
	vim.lsp.enable(name)
end

M.omnisharp_setup = function(capabilities, on_attach, name)
	-- setup omnisharp
	vim.lsp.config[name] = {
		cmd = {
			"dotnet",
			"/home/tomeczku/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll",
		},
		filetypes = { "cs", "vb" },
		capabilities = capabilities,
		on_attach = on_attach,
		enable_editorconfig_support = true,
		enable_ms_build_load_projects_on_demand = false,
		enable_roslyn_analyzers = true,
		organize_imports_on_format = true,
		enable_import_completion = true,
		sdk_include_prereleases = true,
		analyze_open_documents_only = false,
	}
	vim.lsp.enable(name)
end

M.html_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = {
			"html",
			"javascript",
		},
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
	}
	vim.lsp.enable(name)
end

M.gopls_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name },
		filetypes = { "go", "gomod" },
		capabilities = capabilities,
		on_attach = on_attach,
		completeUnimported = true,
		analyses = { unusedparams = true },
		staticcheck = true,
	}
	vim.lsp.enable(name)
end

M.yaml_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name },
		filetypes = { "yaml" },
		capabilities = capabilities,
		on_attach = on_attach,
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
	}
	vim.lsp.enable(name)
end

M.css_setup = function(capabilities, on_attach, name)
	-- custom capabilities for cssls because otherwise no completions work??
	local c = capabilities
	c.textDocument.completion.completionItem.snippetSupport = true
	vim.lsp.config[name] = {
		cmd = { "vscode-css-language-server", "--stdio" },
		capabilities = c,
		on_attach = on_attach,
		filetypes = { "css", "scss", "less" },
		provideFormatter = true,
		single_file_support = true,
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
	}
	vim.lsp.enable(name)
end

return M
