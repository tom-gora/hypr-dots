local M = {}
local conf = require("tomeczku.configs.supermaven_conf")

M = {
	"supermaven-inc/supermaven-nvim",
	cmd = { "SupermavenStart", "SupermavenToggle" },
	config = conf.config_function,
}

return M
