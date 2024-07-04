local M = {}

M.init_function = function()
  vim.g.mkdp_filetypes = { "markdown" }
  vim.api.nvim_create_augroup("automarkdown", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = "automarkdown",
    pattern = "*.md",
    callback = function()
      vim.cmd "MarkdownPreview"
    end,
  })
end

return M
