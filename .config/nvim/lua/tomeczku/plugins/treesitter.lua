if vim.g.vscode then
	return
end

local M, config_function, dependencies, init_function, required

required = require("tomeczku.core.language_support").required_ts_parsers

dependencies = {
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

config_function = function()
	local ts = require("nvim-treesitter.configs")
	local parsers_conf = require("nvim-treesitter.parsers").get_parser_configs()
	ts.setup({
		ensure_installed = required,
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
				init_selection = "<S-l>",
				node_incremental = "<S-l>",
				scope_incremental = false,
				node_decremental = "<S-h>",
			},
		},
	})

	-- specifically to enable hyprland configuration files treesitter parsing
	vim.filetype.add({
		pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
	})
	vim.filetype.add({
		pattern = {
			[".*%.blade%.php"] = "blade",
		},
	})
	parsers_conf.blade = {
		install_info = {
			url = "https://github.com/EmranMR/tree-sitter-blade",
			files = { "src/parser.c" },
			branch = "main",
		},
		filetype = "blade",
	}
end

init_function = function(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

M = {
	"nvim-treesitter/nvim-treesitter",
	cond = vim.g.vscode == nil,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = dependencies,
	init = init_function,
	build = ":TSUpdate",
	config = config_function,
}

return M
