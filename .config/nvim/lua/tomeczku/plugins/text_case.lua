local M = {}
local conf = require("tomeczku.configs.text_case_conf")

M = {
  "johmsalas/text-case.nvim",
  lazy = true,
  dependencies = conf.dependencies,
  config = conf.config_function,
  keys = conf.key_list,
  cmd = conf.cmd_list,
  -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
  -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
  -- available after the first executing of it or after a keymap of text-case.nvim has been used.
}

return M
