local M = {}

M.dependencies = {
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	"nvim-telescope/telescope-file-browser.nvim",
	"nvim-treesitter/nvim-treesitter",
	"debugloop/telescope-undo.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-telescope/telescope-symbols.nvim",
	"folke/todo-comments.nvim",
}

M.config_function = function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local previewers = require("telescope.previewers")
	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				vertical = {
					mirror = true,
					prompt_position = "top",
				},
				width = 0.6,
				height = 0.86,
			},
			file_ignore_patterns = { "node_modules", "%. " },
			path_display = { "smart" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
			buffer_previewer_maker = previewers.buffer_previewer_maker,
			mappings = {
				n = {
					["q"] = actions.close,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-a>"] = actions.select_default,
					["<C-l>"] = actions.select_default,
					["<CR>"] = actions.select_default,
				},
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-a>"] = actions.select_default,
					["<C-l>"] = actions.select_default,
					["<CR>"] = actions.select_default,
				},
			},
		},

		extensions = {
			undo = {},
			["ui-select"] = {},
			file_browser = {
				hijack_netrw = true,
			},
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
		extensions_list = { "fzf", "undo", "ui-select", "file_browser" },
	})
	telescope.load_extension("ui-select")
	telescope.load_extension("undo")
	telescope.load_extension("fzf")
	telescope.load_extension("file_browser")
end

return M
