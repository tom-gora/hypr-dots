if vim.g.vscode then
	return
end

local M, opts
local required = require("tomeczku.core.language_support").mason_required_packages

opts = {
	ui = {
		border = "solid",
		height = 0.8,
		width = 0.7,
	},
	automatic_installation = true,
	ensure_installed = required,
}

M = {
	"williamboman/mason.nvim",
	lazy = false,
	cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll" },
	config = function()
		require("mason").setup(opts)
	end,
}

return M
