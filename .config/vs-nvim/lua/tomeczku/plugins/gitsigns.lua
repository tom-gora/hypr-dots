local M = {}
local conf = require("tomeczku.configs.gitsigns_conf")

M = {
	"lewis6991/gitsigns.nvim",
	event = conf.events,
  config = conf.config_function
}
return M
