-- tailwind configs that work found here:
-- https://github.com/Wansmer/nvim-config/blob/4d7fa6c02474f38755202e679cb7e398b5e96e44/lua/config/plugins/cmp.lua#L121
--

local M = {}

M.cmp_dependencies = {
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

M.cmp_config_function = function()
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

M.blink_dependencies = {
	"rafamadriz/friendly-snippets",
	"luckasRanarison/tailwind-tools.nvim",
	-- "supermaven-inc/supermaven-nvim",
	{ "giuxtaposition/blink-cmp-copilot", after = { "copilot.lua" } },
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
			local ls = require("luasnip")
			local vsc = require("luasnip.loaders.from_vscode")
			ls.filetype_extend("php", { "blade" })
			vsc.load_standalone({ path = "~/.config/nvim/snippets/vscode/go.code-snippets" })
		end,
	},
	"jdrupal-dev/css-vars.nvim",
	{
		"saghen/blink.compat",
		version = "*",
		lazy = false,
	},
}

M.blink_opts = {
	enabled = function()
		return not vim.tbl_contains({ "qf", "oil", "markdown" }, vim.bo.filetype)
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
		ghost_text = { enabled = false },
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
		default = { "lsp", "path", "snippets", "buffer", "copilot", "omni" },
		min_keyword_length = 2,
		providers = {
			copilot = {
				enabled = true,
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = -10,
				async = true,
			},
			css_vars = {
				name = "css-vars",
				module = "css-vars.blink",
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

return M
