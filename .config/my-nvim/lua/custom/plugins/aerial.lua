local M = {}

M = {
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    event = "LspAttach",
    opts = require "custom.configs.aerial_conf",
  },
}

return M
