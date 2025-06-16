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
	-- better escape does not work for the term mode so I set it myself
	["jn"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), h.setOpts({ desc = "ignore" }) },
}

return M
