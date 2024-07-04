local M = {}
local configs = require "custom.configs.sniprun_conf"

M = {
  "michaelb/sniprun",
  build = "sh install.sh 1",
  cmd = configs.commands,
  config = configs.config_function,
}

return M
