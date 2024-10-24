local M = {}
local conf = require("tomeczku.configs.rainbow_delimiters_conf")

M = {
	"HiPhish/rainbow-delimiters.nvim",
	lazy = false,
	config = conf.config_function,
}

return M
