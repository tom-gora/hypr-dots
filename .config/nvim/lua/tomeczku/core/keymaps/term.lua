local M, h = {}, require("tomeczku.core.keymaps.helpers")

M = {
	["<c-h>"] = { h.tmuxNavigateAwayFromTerminal, h.setOpts() },
	["<c-k>"] = { h.tmuxNavigateAwayFromTerminal, h.setOpts() },
	["<c-j>"] = {
		"<Nop>",
		h.setOpts(),
	},
	["<c-l>"] = {
		"<Nop>",
		h.setOpts(),
	},
}

return M
