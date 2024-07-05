local M = {}
M = {
  "nvim-zh/colorful-winsep.nvim",
  config = true,
  event = { "WinNew" },
  opts = {
    symbols = { "─", "│", "╭", "╮", "╰", "╯" },
    anchor = {
      up = { width = 0, x = -1, y = 0 },
      right = { height = 1, x = 0, y = 0 },
      left = { height = 1, x = 0, y = -1 },
      bottom = { width = 0, x = 2, y = 0 },
    }
  }
}

return M
