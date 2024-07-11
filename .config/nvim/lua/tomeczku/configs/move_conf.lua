local M = {}

M.set_binds = function()
  local opts = { noremap = true, silent = true }

  -- set plugin binds locally

  -- Normal-mode commands
  vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
  vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
  vim.keymap.set("n", "<A-l>", ":MoveWord(1)<CR>", opts)
  vim.keymap.set("n", "<A-h>", ":MoveWord(-1)<CR>", opts)

  -- Visual-mode commands
  vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
  vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
  vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
  vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
end

M.opts = {
  char = {
    enable = false,
  },
}

return M
