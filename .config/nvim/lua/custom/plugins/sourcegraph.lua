local M = {}

M = {
  "sourcegraph/sg.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
  },
  build = "nvim -l build/init.lua",
  opts = {
    enable_cody = true,
  },
}

return M
