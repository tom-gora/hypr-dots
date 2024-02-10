local M = {}

M = {
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    event = "LspAttach",
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man" },
      layout = {
        width = 40,
        win_opts = {
          statuscolumn = " ",
        },
      },
      autojump = true,
      post_jump_cmd = "normal! zt",
      show_guides = true,
      guides = {
        -- When the child item has a sibling below it
        mid_item = "├─",
        -- When the child item is the last in the list
        last_item = "╰─",
        -- When there are nested child guides to the right
        nested_top = "│ ",
        -- Raw indentation
        whitespace = "  ",
        default_direction = "float",
      },
    },
  },
}

return M
