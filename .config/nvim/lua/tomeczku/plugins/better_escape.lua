if vim.g.vscode then
	return
end

local M, opts

opts = {
	default_mappings = false,
	timeout = vim.o.timeoutlen,
	mappings = {
		i = { j = { k = "<Esc>" } },
		c = { j = { k = "<Esc>" } },
		t = { j = { k = "<Esc>" } },
		x = { j = { k = "<Esc>" } },
		s = { j = { k = "<Esc>" } },
	},
}

M = {
	"max397574/better-escape.nvim",
	cond = vim.g.vscode == nil,
	event = "InsertEnter",
	opts = opts,
}

return M
