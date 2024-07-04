local M = {}

M = {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  opts = {
    colors = { func = "#519aba" },
    keywords = {
      FUNCTION = {
        icon = "󰊕",
        color = "func",
        alt = { "FUNC", "FN" },
        --
      },
    },
  },
}

return M
