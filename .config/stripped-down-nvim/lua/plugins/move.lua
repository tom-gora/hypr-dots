local M = {}
local configs = require("configs.move_conf")
configs.set_binds()

M = {
	"fedepujol/move.nvim",
	event = "BufRead",
	opts = configs.opts,
}

return M
