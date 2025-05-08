local M = {}

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
	local get_typescript_server_path = function(root_dir)
		local project_roots = vim.fs.find("node_modules", { path = root_dir, upward = true, limit = math.huge })
		for _, project_root in ipairs(project_roots) do
			local typescript_path = project_root .. "/typescript"
			---@diagnostic disable-next-line
			local stat = vim.loop.fs_stat(typescript_path)
			if stat and stat.type == "directory" then
				return typescript_path .. "/lib"
			end
		end
		return vim.fs.normalize("/usr/local/lib/node_modules/typescript/lib")
	end

	vim.lsp.config[name] = {
		cmd = { "astro-ls", "--stdio" },
		root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
		filetypes = { "astro" },
		capabilities = capabilities,
		on_attach = on_attach,
		init_options = {
			typescript = {},
		},
		---@class lsp.LSPObject.typescript
		before_init = function(_, config)
			if config.init_options and config.init_options.typescript and not config.init_options.typescript.tsdk then
				config.init_options.typescript.tsdk = get_typescript_server_path(config.root_dir)
			end
		end,
	}
	vim.lsp.enable(name)
end

M.phpactor_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "language-server" },
		-- same extended filetype pool for phpactor to include blade files
		filetypes = { "blade", "php" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_markers = { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" },
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
		root_markers = {
			"tsconfig.json",
			"package.json",
			"jsconfig.json",
			".git",
		},
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
		root_markers = { "go.mod", ".git" },
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
