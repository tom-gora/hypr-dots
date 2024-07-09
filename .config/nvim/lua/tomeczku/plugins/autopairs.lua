-- src https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/autopairs.lua
local M = {}
local conf = require("tomeczku.configs.autopairs_conf")

M = {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = conf.dependencies,
  config = conf.config_function,
}

return M
