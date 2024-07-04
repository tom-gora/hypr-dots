local M = {}

M.config_function = function()
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
end

return M
