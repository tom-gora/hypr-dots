local M = {}
local init_function =
  require("custom.configs.markdown_preview_conf").init_function

M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  event = "LspAttach",
  build = "cd app && yarn install",
  init = init_function,
  ft = { "markdown" },
}

return M
