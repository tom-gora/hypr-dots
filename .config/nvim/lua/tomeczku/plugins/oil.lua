local M = {}
local conf = require("tomeczku.configs.oil_conf")

M = {
	"stevearc/oil.nvim",
	dependencies = conf.dependecies,
	opts = conf.opts,
}

return M
