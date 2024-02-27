local M = {}
local conf_function = require("custom.configs.cmp_conf").config

M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "js-everts/cmp-tailwind-colors", opts = {} },
  },
  opts = conf_function,
}

return M
