local M = {}

M = {
	"gbprod/cutlass.nvim",
	event = "BufReadPost",
	opts = require("configs.cutlass_conf"),
}

return M
