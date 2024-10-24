local M = {}
local conf = require("tomeczku.configs.oil_conf")

M = {
	"stevearc/oil.nvim",
	dependencies = conf.dependecies,
	init = conf.init_function,
	opts = conf.opts,
}

return M
