local M = {}
local opts = require("tomeczku.configs.boole_conf").opts

M = {
	"nat-418/boole.nvim",
	lazy = false,
	keys = { "<C-a", "<C-x>" },
	opts = opts,
}

return M