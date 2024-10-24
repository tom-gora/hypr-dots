-- tailwind configs that work found here:
-- https://github.com/Wansmer/nvim-config/blob/4d7fa6c02474f38755202e679cb7e398b5e96e44/lua/config/plugins/cmp.lua#L121
--
local M = {}
local conf = require("tomeczku.configs.cmp_conf")

M = {
  "hrsh7th/nvim-cmp",
  lazy = true,
  event = "InsertEnter",
  dependencies = conf.dependencies,
  config = conf.config_function,
}

return M
