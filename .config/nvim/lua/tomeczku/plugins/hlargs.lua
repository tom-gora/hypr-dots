local M = {}
-- local opts = require("tomeczku.configs.hlargs_conf").opts

M = {
  "m-demare/hlargs.nvim",
  -- opts = opts
  opts = {
    -- color = "#ea9d34",
    highlight = { fg = "#ea9d34", italic = true, force = true },
    hl_priority = 500,
  },
}

return M