-- ------------------------------------------------------------[ smartcolumn ]
local M = {}
M = {
  "m4xshen/smartcolumn.nvim",
  event = { "InsertEnter", "BufEnter" },
  opts = {
    colorcolumn = "80",
    disabled_filetypes = {
      "help",
      "text",
      "markdown",
      "lazy",
      "alpha",
      "mason",
      "checkhealth",
      "lsp",
      "lspinfo",
    },
    scope = "file",
  },
}

return M
