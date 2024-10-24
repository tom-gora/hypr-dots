local M = {}
local conf = require("tomeczku.configs.lazydev_conf")

M = {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    dependencies = conf.dependencies,
    opts = conf.opts,
  },
}

return M
