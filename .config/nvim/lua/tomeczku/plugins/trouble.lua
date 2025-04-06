if vim.g.vscode then
	return
end

local M, opts

opts = {
	focus = true,
	auto_jump = true,
	auto_close = true,
}

M = {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = opts,
}

return M
