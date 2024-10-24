local M = {}
local opts = require("tomeczku.configs.colorizer_conf")

M = {
	"NvChad/nvim-colorizer.lua",
  event = "VeryLazy",
	config = true,
	opts = opts,
}

return M
