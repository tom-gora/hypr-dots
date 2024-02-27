local M = {}

M = {
  "sourcegraph/sg.nvim",
  event = "VeryLazy",
  build = "nvim -l build/init.lua",
  opts = { enable_cody = true },
}

return M
