local M = {}
local conf = require("tomeczku.configs.telescope_conf")

M = {
	"nvim-telescope/telescope.nvim",
	dependencies =  {
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter",
	"debugloop/telescope-undo.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
},
	config = conf.config_function,
}

return M
