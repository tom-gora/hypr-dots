if vim.g.vscode then
	return
end

local M

local copilot_config = function()
	local opts = {
		-- disable everything, copilot only to serve as cmp provider for blink
		suggestion = { enabled = false },
		panel = { enabled = false },
		auto_trigger = false,
		-- since not using traditional virtual text disable default maps
		-- blink handles suggesion section
		keymap = {
			jump_prev = false,
			jump_next = false,
			accept = false,
			refresh = false,
			open = false,
		},
		filetypes = {
			oil = false,
			qf = false,
			markdown = false,
			help = false,
			-- never enable in env files
			sh = function()
				if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
					return false
				end
				return true
			end,
		},
		-- never attach to env files
		should_attach = function(_, bufname)
			if string.match(bufname, "env") or string.match(bufname, "oil") then
				return false
			end
			return true
		end,
	}
	--
	-- HACK: first override copilots logger function to kill the annoying
	-- and noisy notifications when disabling it by default on startup
	local silence_copilot, logger = pcall(require, "copilot.logger")
	if silence_copilot then
		logger.warn = function(msg, ...)
			if msg == "copilot is disabled" then
				return
			end
			logger.log(vim.log.levels.WARN, msg, ...)
		end
	end

	local ok, _ = pcall(require("copilot").setup, opts)
	-- if initialized ok disable by default
	if ok then
		require("copilot.command").disable()
		_G.COPILOT_ENABLED = false
	end
end

local copilot_source_opts = {
	max_completions = 3,
	max_attempts = 4,
	kind_name = "Copilot",
	kind_icon = " ",
	kind_hl = "RainbowDelimiterBlue",
	debounce = 300,
	auto_refresh = {
		-- disable auto refresh to reduce traffic, only blink requests new completions
		-- rather than requesting on each cursor move
		backward = false,
		forward = false,
	},
}

local blink_dependencies = {
	"rafamadriz/friendly-snippets",
	"luckasRanarison/tailwind-tools.nvim",
	{
		"fang2hou/blink-copilot",
		dependencies = {
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			build = ":Copilot auth",
			config = copilot_config,
		},
		opts = copilot_source_opts,
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
		-- TODO: setup proper easy pipeline to load snippets,
		-- ideally where snippets files can be just dumped into location and blink will work with those
		config = function()
			local ls = require("luasnip")
			local vsc = require("luasnip.loaders.from_vscode")
			ls.filetype_extend("php", { "blade" })
			vsc.load_standalone({ path = "~/.config/nvim/snippets/vscode/go.code-snippets" })
		end,
	},
	"jdrupal-dev/css-vars.nvim",
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
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				border = "solid",
				scrollbar = false,
			},
		},
		menu = {
			border = "solid",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
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
	signature = { window = { border = "solid" } },
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer", "omni", "css_vars", "copilot" },
		providers = {
			lsp = { min_keyword_length = 1, opts = { tailwind_color_icon = "" } },
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
				score_offset = 100,
			},
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 50,
				async = true,
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

return M
