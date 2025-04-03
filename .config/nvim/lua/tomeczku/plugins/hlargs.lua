if vim.g.vscode then
	return
end

local M, opts

opts = {
	highlight = { fg = "#ea9d34", italic = true, force = true },
	hl_priority = 500,
}

M = {
	"m-demare/hlargs.nvim",
	cond = vim.g.vscode == nil,
	event = "VeryLazy",
	opts = opts,
}

return M
