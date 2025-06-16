if vim.g.vscode then
	return
end

local M, opts

opts = {
	default_mappings = false,
	timeout = vim.o.timeoutlen,
	mappings = {
		i = { j = { n = "<Esc>" } },
		c = { j = { n = "<C-c>" } },
		t = {
			j = {
				n = function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true), "t", false)
				end,
			},
		},
		x = { j = { n = "<Esc>" } },
		s = { j = { n = "<Esc>" } },
	},
}

M = {
	"max397574/better-escape.nvim",
	cond = vim.g.vscode == nil,
	event = "InsertEnter",
	opts = opts,
}

return M
