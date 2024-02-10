local M = {}

M = {
  "michaelb/sniprun",
  build = "sh install.sh 1",
  cmd = {
    "SnipRun",
    "SnipInfo",
    "SnipLive",
    "SnipClose",
    "SnipReset",
    "SnipReplMemoryClean",
  },
  config = function()
    require("sniprun").setup {
      display = { "Terminal" },
      display_options = {
        terminal_scrollback = vim.o.scrollback,
        terminal_line_number = false,
        terminal_signcolumn = false,
        terminal_position = "vertical",
      },
    }
  end,
}

return M
