local M = {}
local conf = require("tomeczku.configs.text_case_conf")

M = {
  "johmsalas/text-case.nvim",
  lazy = true,
  dependencies = conf.dependencies,
  config = conf.config_function,
  keys = conf.key_list,
  cmd = conf.cmd_list,
}

return M
