if vim.g.vscode then
	return
end

local M

local dependencies = {
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

local opts = {
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
		default = { "lazydev", "lsp", "path", "snippets", "buffer", "supermaven", "omni", "css_vars" },
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
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
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
	dependencies = dependencies,
	build = "cargo build --release",
	opts = opts,
}

return M
