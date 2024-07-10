local M = {}

M.opts = {
  symbol_in_winbar = { enable = false },
  lightbulb = { enable = false },
  -- ui = {
  --   code_action = "󰛩"
  -- },
  rename = {
    keys = {
      quit = "jk",
    }
  },
  outline = {
    keys = {
      jump = "<cr>",
    }
  },
}

M.dependecies = {
  'nvim-treesitter/nvim-treesitter',
  'nvim-tree/nvim-web-devicons',
}

return M
