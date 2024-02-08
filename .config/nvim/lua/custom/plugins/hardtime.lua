local M = {}

M = {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    require("hardtime").setup {
      enabled = true,
      allow_different_key = true,
      disable_mouse = true,
      disabled_keys = {
        ["<Up>"] = { "n", "i" },
        ["<Down>"] = { "n", "i" },
        ["<Left>"] = { "n", "i" },
        ["<Right>"] = { "n", "i" },
      },
      disabled_filetypes = { "minifiles" },
    }
  end,
}

return M
