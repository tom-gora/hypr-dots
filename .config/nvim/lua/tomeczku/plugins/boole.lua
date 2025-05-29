if vim.g.vscode then
	return
end

local M, opts

opts = {
	mappings = {
		increment = "<C-a>",
		decrement = "<C-x>",
	},
	allow_caps_additions = {
		{ "enable", "disable" },
		{ "enabled", "disabled" },
		{ "true", "false" },
		{ "off", "on" },
	},
}

M = {
	"nat-418/boole.nvim",
	cond = vim.g.vscode == nil,
	opts = opts,
}

return M
