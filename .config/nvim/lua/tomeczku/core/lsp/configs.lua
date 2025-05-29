local M = {}

M.lua_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name },
		filetypes = { "lua" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_markers = {
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
		},
		workspace_required = false,
		settings = {
			Lua = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
				diagnostics = {
					globals = { "vim", "vim.g", "Snacks", "_G" },
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	}
	vim.lsp.enable(name)
end

M.bash_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "start" },
		filetypes = { "bash", "sh", "zsh" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_markers = { ".git" },
		settings = {
			bashIde = {
				globPattern = "*@(.sh|.inc|.bash|.command)",
			},
		},
	}
	vim.lsp.enable(name)
end

M.emmet_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "--stdio" },
		-- Make it attach to additional filetypes
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
	-- Pass path to typescript for astro to work
	local get_typescript_server_path = function(root_dir)
		local project_roots = vim.fs.find("node_modules", { path = root_dir, upward = true, limit = math.huge })
		for _, project_root in ipairs(project_roots) do
			local typescript_path = project_root .. "/typescript"
			---@diagnostic disable-next-line: undefined-field, deprecated
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
			if config.init_options and not config.init_options.typescript.tsdk then
				config.init_options.typescript.tsdk = get_typescript_server_path(config.root_dir)
			end
		end,
	}
	vim.lsp.enable(name)
end

M.phpactor_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "language-server" },
		-- Same extended filetype pool for phpactor to include blade files
		filetypes = { "blade", "php" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_markers = { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" },
	}
	vim.lsp.enable(name)
end

M.tailwind_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "--stdio" },
		before_init = function(_, config)
			if not config.settings then
				config.settings = {}
			end
			if not config.settings.editor then
				config.settings.editor = {}
			end
			if not config.settings.editor.tabSize then
				config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
			end
		end,
		workspace_required = true,
		-- Same, but explicitly get all supported types using the plugin helper
		filetypes = require("tailwind-tools.filetypes").get_all(),
		capabilities = capabilities,
		on_attach = on_attach,
		root_markers = {
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
		},
		settings = {
			tailwindCSS = {
				validate = true,
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidScreen = "error",
					invalidVariant = "error",
					invalidConfigPath = "error",
					invalidTailwindDirective = "error",
					recommendedVariantOrder = "warning",
				},
				classAttributes = {
					"class",
					"className",
					"class:list",
					"classList",
					"ngClass",
				},
				includeLanguages = {
					eelixir = "html-eex",
					eruby = "erb",
					templ = "html",
					htmlangular = "html",
				},
			},
		},
	}
	vim.lsp.enable(name)
end

M.css_variables_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "--stdio" },
		filetypes = { "css", "scss", "less" },
		root_markers = { "package.json", ".git" },
		settings = {
			cssVariables = {
				blacklistFolders = {
					"**/.cache",
					"**/.DS_Store",
					"**/.git",
					"**/.hg",
					"**/.next",
					"**/.svn",
					"**/bower_components",
					"**/CVS",
					"**/dist",
					"**/node_modules",
					"**/tests",
					"**/tmp",
				},
				lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
			},
		},
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
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_markers = { "go.mod", ".git" },
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = false,
				analyses = {
					unusedparams = true,
					unreachable = true,
				},
				-- report vulnerabilities
				vulncheck = "Imports",
				staticcheck = true,
				gofumpt = true,
			},
		},
	}
	vim.lsp.enable(name)
end

M.yaml_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "--stdio" },
		filetypes = { "yaml" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_markers = { ".git" },
		settings = {
			redhat = {
				telemetry = {
					enabled = false,
				},
			},
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
		init_options = {
			provideFormatter = true,
		},
		single_file_support = true,
		root_markers = { "package.json", ".git" },
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

M.harper_setup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { name, "--stdio" },
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"c",
			"cpp",
			"cs",
			"gitcommit",
			"go",
			"html",
			"java",
			"javascript",
			"lua",
			"markdown",
			"nix",
			"python",
			"ruby",
			"rust",
			"swift",
			"toml",
			"typescript",
			"typescriptreact",
			"haskell",
			"cmake",
			"typst",
			"php",
			"dart",
		},
		root_markers = { ".git" },
		settings = {
			["harper-ls"] = {
				userDictPath = vim.o.spellfile,
				linters = {
					SpellCheck = false,
					SpelledNumbers = false,
					AnA = true,
					SentenceCapitalization = false,
					UnclosedQuotes = true,
					WrongQuotes = false,
					LongSentences = true,
					RepeatedWords = true,
					Spaces = true,
					Matcher = true,
					CorrectNumberSuffix = true,
				},
				codeActions = {
					ForceStable = false,
				},
				markdown = {
					IgnoreLinkTitle = false,
				},
				diagnosticSeverity = "hint",
				isolateEnglish = false,
				dialect = "British",
			},
		},
	}
	vim.lsp.enable(name)
end

M.dockerComposeSetup = function(capabilities, on_attach, name)
	vim.lsp.config[name] = {
		cmd = { "docker-compose-langserver", "--stdio" },
		filetypes = { "yaml.docker-compose" },
		root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
		capabilities = capabilities,
		on_attach = on_attach,
		single_file_support = true,
	}
	vim.lsp.enable(name)
end

return M
