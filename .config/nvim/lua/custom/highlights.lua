local M = {}

-- add my highlights for incline:
vim.api.nvim_set_hl(0, "InclineCenter", { bg = "#102a34", fg = "#E0DEF4" })
vim.api.nvim_set_hl(0, "InclineOuter", {
  fg = "#102a34",
  bg = "#191724",
})

vim.api.nvim_set_hl(
  0,
  "InclineCenterInactive",
  { bg = "#393552", fg = "#9893A5" }
)
vim.api.nvim_set_hl(0, "InclineOuterInactive", {
  fg = "#393552",
  bg = "#191724",
})

vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "#EA9D34" })

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
    fg = "#555267",
  },
  Visual = {
    bg = "#302e3f",
  },
  RainbowDelimiterYellow = {
    fg = "#D7827E",
  },
  RainbowDelimiterRed = {
    fg = "#E96F92",
  },
  RainbowDelimiterOrange = {
    fg = "#EA9D34",
  },
  RainbowDelimiterBlue = {
    fg = "#286983",
  },
  RainbowDelimiterGreen = {
    fg = "#56949F",
  },
  RainbowDelimiterViolet = {
    fg = "#C4A7E7",
  },
  RainbowDelimiterCyan = {
    fg = "#9CCFD8",
  },
  ColorColumn = {
    bg = "#482831",
  },
  CursorLine = {
    bg = "#201e31",
  },
  TelescopeBorder = {
    fg = "#9CCFD8",
  },
  TelescopePromptBorder = {
    fg = "#C4A7E7",
  },
  TelescopePromptTitle = {
    bg = "#C4A7E7",
  },
  TelescopePromptPrefix = {
    fg = "#C4A7E7",
  },
  TelescopeSelection = {
    bg = "#302e3f",
  },
  TelescopeResultsTitle = {
    bg = "#9CCFD8",
  },
  St_NormalMode = {
    bg = "#D7827E",
  },
  St_NormalModeSep = {
    fg = "#D7827E",
  },
  St_NormalmodeText = {
    fg = "#D7827E",
  },
  NormalFloat = {
    bg = "#191724",
  },
  CmpBorder = {
    fg = "#9CCFD8",
  },
  WinSeparator = {
    fg = "#9CCFD8",
  },
}

return M
