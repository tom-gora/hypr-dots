local M = {}

M = {
  "mistricky/codesnap.nvim",
  build = "make",
  keys = {
    { "<leader>C", "<cmd>CodeSnap<cr>", mode = "x", desc = "󰄄 CodeSnap" },
  },
  opts = {
    -- save_path = "~/Pictures",
    mac_window_bar = false,
    has_breadcrumbs = true,
    has_line_number = true,
    bg_theme = "grape",
    watermark = "",
    code_font_family = "JetBrainsMonoNF-Light"
  },
}

return M
