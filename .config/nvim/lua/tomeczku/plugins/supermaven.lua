local M = {}
local conf = require("tomeczku.configs.supermaven_conf")

M = {
  "supermaven-inc/supermaven-nvim",
  event = { "InsertEnter" },
  config = conf.config_function,
}

return M
