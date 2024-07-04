local M = {}

M.opts = {
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
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules", "%. " },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-l>"] = require("telescope.actions").select_default,
				["<C-[>"] = require("telescope.actions").preview_scrolling_left,
				["<C-]>"] = require("telescope.actions").preview_scrolling_right,
			},
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-l>"] = require("telescope.actions").select_default,
				["<C-[>"] = require("telescope.actions").preview_scrolling_left,
				["<C-]>"] = require("telescope.actions").preview_scrolling_right,
			},
		},
	},

	extensions = {
		undo = {},
		["ui-select"] = {},
		file_browser = {
			hijack_netrw = true,
		},
	},
	extensions_list = { "undo", "ui-select" },
}


M.config_function = function()
local tel = require("telescope")
	tel.setup(M.opts)
	tel.load_extension("ui-select")
	tel.load_extension("undo")
end

return M
