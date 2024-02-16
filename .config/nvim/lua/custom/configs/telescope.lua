local M = {}

M = {
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
      -- horizontal = {
      --   prompt_position = "top",
      --   preview_width = 0.55,
      --   results_width = 0.8,
      -- },
      vertical = {
        mirror = true,
        prompt_position = "top",
      },
      width = 0.6,
      height = 0.86,
      -- preview_cutoff = 120,
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
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = {
        ["q"] = require("telescope.actions").close,
      },
      i = {
        ["<Tab>"] = require("telescope.actions").move_selection_next,
        ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
        ["<C-n>"] = require("telescope.actions").toggle_selection
          + require("telescope.actions").move_selection_worse,
        ["<C-p>"] = require("telescope.actions").toggle_selection
          + require("telescope.actions").move_selection_better,
      },
    },
  },

  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
  extensions_list = { "themes", "terms", "undo", "ui-select" },
}

return M
