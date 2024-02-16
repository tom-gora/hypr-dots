local M = {}

M = {
  "michaelb/sniprun",
  build = "sh install.sh 1",
  cmd = {
    "SnipRun",
    "SnipInfo",
    "SnipClose",
    "SnipReset",
    "SnipReplMemoryClean",
  },
  config = function()
    local sniprun = require "sniprun"
    sniprun.setup {
      display = { "Terminal" },
      display_options = {
        terminal_line_number = false, -- whether show line number in terminal window
        terminal_signcolumn = false, -- whether show signcolumn in terminal window
        terminal_width = 40, --# change the terminal display option width (if vertical)
        terminal_position = "vertical",
      },
      snipruncolors = {
        SniprunFloatingWinOk = { fg = "#e0def4" },
      },
    }
  end,
}

return M
