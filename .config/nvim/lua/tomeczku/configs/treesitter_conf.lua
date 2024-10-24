local M = {}

M.config_function = function()
	local ts = require("nvim-treesitter.configs")
	ts.setup({
		ensure_installed = {
			"vim",
			"vimdoc",
			"query",
			"lua",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"c",
			"markdown",
			"markdown_inline",
			"bash",
			"c_sharp",
			"json",
			"java",
			"php",
			"sql",
			"toml",
			"xml",
			"astro",
			"qmljs",
			"qmldir",
			"hyprlang",
			"regex",
			"rasi",
			"gomod",
			"go",
			"gosum",
			"gowork",
			"goctl",
		},
		indent = {
			enable = true,
		},
		highlight = {
			enable = true,
		},
		auto_install = true,
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-S-L>",
				node_incremental = "<C-S-L>",
				-- scope_incremental = "<S-Space>",
				node_decremental = "<C-S-H>",
			},
		},
	})

	-- specifically to enable hyprland configuration files treesitter parsing
	vim.filetype.add({
		pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
	})
end

M.dependencies = {
	"windwp/nvim-ts-autotag",
	opts = {
		per_filetype = {
			["astro"] = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
}

M.event = { "BufReadPre", "BufNewFile" }

return M
