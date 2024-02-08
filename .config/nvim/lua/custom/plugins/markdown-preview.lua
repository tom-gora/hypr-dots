local M = {}

M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  event = "LspAttach",
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.api.nvim_create_augroup("automarkdown", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      group = "automarkdown",
      pattern = "*.md",
      callback = function()
        vim.cmd "MarkdownPreview"
      end,
    })
  end,
  ft = { "markdown" },
}

return M
