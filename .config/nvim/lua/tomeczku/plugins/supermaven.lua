local M = {}
local conf = require("tomeczku.configs.supermaven_conf")

M = {
	"supermaven-inc/supermaven-nvim",
	cmd = { "SupermavenStart", "SupermavenToggle" },
	lazy = false,
	opts = conf.opts,
	config = conf.config_function,
}

return M
