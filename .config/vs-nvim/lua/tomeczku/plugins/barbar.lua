local M = {}
local conf = require("tomeczku.configs.barbar_conf")

M = {
  "romgrk/barbar.nvim",
  event = "VeryLazy",
  dependencies = conf.dependencies,
  init = conf.init_function(),
  opts = conf.opts,
}
return M
