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
        "fzf", -- fzf-lua
        "help",
        "lazy",
        "lazyterm",
        "lspsagafinder",
        "mason",
        "notify",
        "qf",
        "starter", -- mini.starter
        "toggleterm",
        "Trouble",
        "neoai-input",
        "neoai-*",
        "neoai-output",
        "neo-*",
        "oil",
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

M.move = {
  opts = {
    reindent_linewise = true,
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = '<a-h>',
      right = '<a-l>',
      down = '<a-j>',
      up = '<a-k>',

      -- Move current line in Normal mode
      line_left = '<a-h>',
      line_right = '<a-l>',
      line_down = '<a-j>',
      line_up = '<a-k>',
    },
  }
}

return M
