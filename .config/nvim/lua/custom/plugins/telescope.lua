local M = {}

M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
  init = function()
    require("core.utils").load_mappings "telescope"
  end,
  opts = function()
    return require "custom.configs.telescope"
  end,
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "telescope")
    local telescope = require "telescope"
    telescope.setup(opts)

    -- load extensions
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}

return M