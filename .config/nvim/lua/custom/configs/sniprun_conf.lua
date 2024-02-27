local M = {}

M.commands = {
  "SnipRun",
  "SnipInfo",
  "SnipClose",
  "SnipReset",
  "SnipReplMemoryClean",
}

M.config_function = function()
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
end

return M
