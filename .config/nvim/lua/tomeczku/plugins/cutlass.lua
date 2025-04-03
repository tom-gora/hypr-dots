if vim.g.vscode then
	return
end

local M, opts

opts = {
	cut_key = "X",
	override_del = true,
	exclude = {},
	registers = {
		select = "_",
		delete = "_",
		change = "_",
	},
}

M = {
	"gbprod/cutlass.nvim",
	cond = vim.g.vscode == nil,
	event = "BufReadPost",
	opts = opts,
}

return M
