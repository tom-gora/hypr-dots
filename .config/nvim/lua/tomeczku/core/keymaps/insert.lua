local M, h = {}, require("tomeczku.core.keymaps.helpers")

M = {
	-- navigate within insert mode
	["<C-h>"] = { "<Left>", h.setOpts({ desc = "ignore" }) },
	["<C-l>"] = { "<Right>", h.setOpts({ desc = "ignore" }) },
	["<C-j>"] = { "<Down>", h.setOpts({ desc = "ignore" }) },
	["<C-k>"] = { "<Up>", h.setOpts({ desc = "ignore" }) },
}

return M
