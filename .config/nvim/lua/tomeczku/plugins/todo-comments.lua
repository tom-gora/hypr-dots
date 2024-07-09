-- src: https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/todo-comments.lua
local M = {}
local conf = require("tomeczku.configs.todo_comments_conf")

M = {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = conf.dependencies,
  config = conf.config_function,
}

return M
