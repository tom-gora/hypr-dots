if vim.g.vscode then
	return
end

local M, legacy

legacy = vim.g.legacy_cmp

-- if legacy cmp not set use blink
if not legacy or legacy == false then
	local blink_dependencies = {
		"rafamadriz/friendly-snippets",
		"luckasRanarison/tailwind-tools.nvim",
		{
			"supermaven-inc/supermaven-nvim",
			lazy = true,
			config = function()
				require("supermaven-nvim").setup({
					condition = function()
						if vim.g.SUPERMAVEN_DISABLED == 1 then
							return false
						end
						return true
					end,
					-- ignore_filetypes = { cpp = true }, -- or { "cpp", }
					log_level = "off",
					-- disable inline ai as I prefer using cmp suggestions
					disable_inline_completion = true,
					disable_keymaps = true,
				})
				-- HACK: use snacks to suppress the annoying popup about missing nvim-cmp
				-- there is none, as blink is in use
				require("snacks.notifier").hide()
			end,
		},
		{
			"huijiro/blink-cmp-supermaven",
			lazy = true,
			dependencies = { "supermaven-inc/supermaven-nvim" },
		},
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				local ls = require("luasnip")
				local vsc = require("luasnip.loaders.from_vscode")
				ls.filetype_extend("php", { "blade" })
				vsc.load_standalone({ path = "~/.config/nvim/snippets/vscode/go.code-snippets" })
			end,
		},
		"jdrupal-dev/css-vars.nvim",
		-- {
		-- 	"saghen/blink.compat",
		-- 	version = "*",
		-- 	lazy = false,
		-- },
	}

	local blink_opts = {
		enabled = function()
			return not vim.tbl_contains({ "qf", "oil" }, vim.bo.filetype)
				and vim.bo.buftype ~= "prompt"
				and vim.b.completion ~= false
		end,
		keymap = {
			preset = "none",
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-a>"] = { "select_and_accept" },
			["<CR>"] = { "accept", "fallback" },

			["<C-f>"] = { "scroll_documentation_up", "fallback" },
			["<C-b>"] = { "scroll_documentation_down", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			ghost_text = { enabled = true },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 1000,
				window = {
					border = "rounded",
					scrollbar = false,
				},
			},
			menu = {
				border = "rounded",
				min_width = 18,
				max_height = 12,
				scrollbar = false,
				direction_priority = { "s", "n" },

				auto_show = true,
				draw = {
					padding = { 2, 2 },
					gap = 2,
					columns = {
						{
							"label",
							"label_description",
							gap = 2,
						},
						{ "kind", "kind_icon", gap = 2 },
					},
				},
			},
		},
		signature = { window = { border = "rounded" } },
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "supermaven", "omni", "css_vars" },
			providers = {
				lsp = { min_keyword_length = 1 },
				buffer = { min_keyword_length = 2 },
				omni = { min_keyword_length = 3 },
				snippets = { min_keyword_length = 2 },
				path = {
					enabled = true,
					min_keyword_length = 0,
					opts = {
						get_cwd = function(_)
							return vim.fn.getcwd()
						end,
					},
				},
				-- lazydev = {
				-- 	name = "LazyDev",
				-- 	module = "lazydev.integrations.blink",
				-- 	-- make lazydev completions top priority (see `:h blink.cmp`)
				-- 	score_offset = 100,
				-- },
				supermaven = {
					enabled = true,
					name = "supermaven",
					module = "blink-cmp-supermaven",
					async = true,
					transform_items = function(_, items)
						for _, item in ipairs(items) do
							item.kind_icon = ""
							item.kind_name = "Supermaven"
						end
						return items
					end,
				},
				css_vars = {
					name = "css-vars",
					module = "css-vars.blink",
					min_keyword_length = 2,
					opts = {
						-- WARNING: The search is not optimized to look for variables in JS files.
						-- If you change the search_extensions you might get false positives and weird completion results.
						search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
					},
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	}

	M = {
		"saghen/blink.cmp",
		cond = vim.g.vscode == nil,
		version = "1.*",
		event = "InsertEnter",
		dependencies = blink_dependencies,
		build = "cargo build --release",
		opts = blink_opts,
	}
else
	-- old cmp.nvim config
	local cmp_dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"luckasRanarison/tailwind-tools.nvim",
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function(_, opts)
				if opts then
					require("luasnip").config.setup(opts)
				end
				vim.tbl_map(function(type)
					require("luasnip.loaders.from_" .. type).lazy_load()
				end, { "vscode", "snipmate", "lua" })
				-- friendly-snippets - enable standardized comments snippets
				require("luasnip").filetype_extend("php", { "blade" })
			end,
		},
		-- for autocompletion
		"saadparwaiz1/cmp_luasnip",
		-- useful snippets
		{
			"rafamadriz/friendly-snippets",
			config = function()
				-- TODO: load global snippets
			end,
		},
		"onsails/lspkind.nvim", -- vs-code like pictograms
	}

	local cmp_config_function = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		local icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Color = " ",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
			Supermaven = "",
		}

		local opts = {
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				-- exit snippet alternatively with c-h or esc
				["<C-h>"] = cmp.mapping.abort(),
				-- jump to next slot
				["<C-]>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				-- jump to prev slot
				["<C-[>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				-- accept alternatively with enter or C-l, or c-a
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-a>"] = cmp.mapping.confirm({ select = false }),
				["<C-l>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip", option = { show_autosnippets = true } },
				{ name = "supermaven" },
				{ name = "lua_ls" },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "nvim_lua" },
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local tt_ok, tt = pcall(require, "tailwind-tools.cmp")
					if tt_ok then
						-- colorize tailwind classes
						vim_item = tt.lspkind_format(entry, vim_item)
					end
					vim_item.kind = string.format("%s", icons[vim_item.kind])
					vim_item.menu = ({
						nvim_lsp = "│lsp ",
						supermaven = "│ai",
						luasnip = "│snip",
						buffer = "│buff",
						path = "│path",
						cmdline = "│cmd ",
						cmdline_history = "│hist ",
						nvim_lsp_document_symbol = "│sym ",
						rg = "│rg  ",
						["html-css"] = "│css ",
					})[entry.source.name]

					return vim_item
				end,
			},
		}

		lspkind.init({
			symbol_map = {
				Supermaven = "",
			},
		})
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup(opts)
	end

	M = {
		"hrsh7th/nvim-cmp",
		cond = vim.g.vscode == nil,
		lazy = true,
		event = "InsertEnter",
		dependencies = cmp_dependencies,
		config = cmp_config_function,
	}
end

return M
