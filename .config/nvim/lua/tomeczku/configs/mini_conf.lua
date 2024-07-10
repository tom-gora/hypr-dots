local M = {}

M.indentscope = {
  opts = {
    draw = {
      delay = 0,
      animation = function()
        return 0
      end,
    },
    symbol = "░",
    options = {
      border = "both",
      indent_at_cursor = true,
      try_as_border = true,
    },
  },

  init_function = function()
    vim.api.nvim_create_autocmd("FileType", {
      -- define table of buffers to skip
      pattern = {
        "alpha",
        "coc-explorer",
        "dashboard",
        "fzf", -- fzf-lua
        "help",
        "lazy",
        "lazyterm",
        "lspsagafinder",
        "mason",
        "nnn",
        "notify",
        "NvimTree",
        "qf",
        "starter", -- mini.starter
        "toggleterm",
        "Trouble",
        "neoai-input",
        "neoai-*",
        "neoai-output",
        "neo-tree",
        "neo-*",
        "noice",
        "sourcegraph",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
        vim.schedule(function()
          ---@diagnostic disable-next-line: undefined-global
          if MiniIndentscope then
            MiniIndentscope.undraw()
          end
        end)
      end,
    })
  end,
}

return M
