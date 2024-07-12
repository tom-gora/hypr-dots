-- theme variation lifted from NvChad's base46 selection as I like their colors better
-- than what official soho vibes provide
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞
--
local M = {}
local theme = require("tomeczku.core.custom_theme.theme")

M.setup = function()
  vim.cmd("hi clear")

  vim.o.background = "dark"
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "rosepine"

  theme.set_highlights()
end

return M
