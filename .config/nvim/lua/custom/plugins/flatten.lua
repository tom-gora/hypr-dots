local M = {}

M = {
  "willothy/flatten.nvim",
  opts = {
    window = "alternate",
    one_per = {
      kitty = false,
    }
  },
  -- Ensure that it runs first to minimize delay when opening file from terminal
  lazy = false,
  priority = 1001,
}

return M
