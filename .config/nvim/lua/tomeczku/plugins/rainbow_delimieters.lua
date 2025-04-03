if vim.g.vscode then
	return
end

local M, config_function

config_function = function()
	local rainbow_delimiters = require("rainbow-delimiters")
	vim.g.rainbow_delimiters = {
		strategy = {
			[""] = rainbow_delimiters.strategy["global"],
			vim = rainbow_delimiters.strategy["local"],
		},
		query = {
			[""] = "rainbow-delimiters",
			lua = "rainbow-blocks",
		},
		highlight = {
			"RainbowDelimiterYellow",
			"RainbowDelimiterRed",
			"RainbowDelimiterOrange",
			"RainbowDelimiterBlue",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
	}
end

M = {
	"HiPhish/rainbow-delimiters.nvim",
	cond = vim.g.vscode == nil,
	lazy = false,
	config = config_function,
}

return M
