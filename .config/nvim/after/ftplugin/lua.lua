vim.b.lua = true

-- misbehavior relating to relative paths....
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "which_key_ignore" })
