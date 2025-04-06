local M, ignore = {}, { desc = "which_key_ignore" }

M = {
	-- navigate within insert mode
	["<C-h>"] = { "<Left>", ignore },
	["<C-l>"] = { "<Right>", ignore },
	["<C-j>"] = { "<Down>", ignore },
	["<C-k>"] = { "<Up>", ignore },
}

return M
