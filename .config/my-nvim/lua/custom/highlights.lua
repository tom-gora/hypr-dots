local M = {}
-- distinc color for AI suggestions
vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "#EA9D34" })

-- add my highlights for incline:
vim.api.nvim_set_hl(
  0,
  "InclineCenter",
  { bg = "#102a34", fg = "#bcbac9", bold = true }
)
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
vim.api.nvim_set_hl(0, "InclinePosition", {
  fg = "#191724",
  bg = "#907AA9",
  bold = true,
})
vim.api.nvim_set_hl(0, "InclineSlant", {
  fg = "#102a34",
  bg = "#907AA9",
})

-- left root separator highlights
vim.api.nvim_set_hl(
  0,
  "St_NormalMode_Root_Sep",
  { bg = "#121019", fg = "#d7827e", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_VisualMode_Root_Sep",
  { bg = "#121019", fg = "#a3d6df", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_InsertMode_Root_Sep",
  { bg = "#121019", fg = "#bb9ede", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_TerminalMode_Root_Sep",
  { bg = "#121019", fg = "#abe9b3", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_NTerminalMode_Root_Sep",
  { bg = "#121019", fg = "#d7827e", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_ReplaceMode_Root_Sep",
  { bg = "#121019", fg = "#f6c177", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_SelectMode_Root_Sep",
  { bg = "#121019", fg = "#8bbec7", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_CommandMode_Root_Sep",
  { bg = "#121019", fg = "#abe9b3", bold = false }
)
vim.api.nvim_set_hl(
  0,
  "St_ConfirmMode_Root_Sep",
  { bg = "#121019", fg = "#6aadc8", bold = false }
)
--root directory center
vim.api.nvim_set_hl(
  0,
  "St_Root",
  { bg = "#121019", fg = "#bcbac9", bold = false }
)
-- and right root separator
vim.api.nvim_set_hl(
  0,
  "St_Root_Sep_Right",
  { bg = "#262431", fg = "#121019", bold = false }
)

-- amended inverted text HL for my simplified mode indicator
vim.api.nvim_set_hl(
  0,
  "St_NormalModeCustomTxt",
  { bg = "#d7827e", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_VisualModeCustomTxt",
  { bg = "#a3d6df", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_InsertModeCustomTxt",
  { bg = "#bb9ede", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_TerminalModeCustomTxt",
  { bg = "#abe9b3", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_NTerminalModeCustomTxt",
  { bg = "#abe9b3", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_ReplaceModeCustomTxt",
  { bg = "#f6c177", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_SelectModeCustomTxt",
  { bg = "#8bbec7", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_CommandModeCustomTxt",
  { bg = "#abe9b3", fg = "#191724", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "St_ConfirmModeCustomTxt",
  { bg = "#6aadc8", fg = "#191724", bold = true }
)

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
    bg = "#2b181d",
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
  NormalFloat = {
    bg = "#191724",
  },
  CmpBorder = {
    fg = "#9CCFD8",
  },
  WinSeparator = {
    fg = "#9CCFD8",
  },
  St_NormalMode = {
    bg = "#191724",
    fg = "#d7827e",
  },
  St_NTerminalMode = { bg = "#191724", fg = "#d7827e" },
  St_VisualMode = { bg = "#191724", fg = "#a3d6df" },
  St_InsertMode = { bg = "#191724", fg = "#bb9ede" },
  St_TerminalMode = {
    bg = "#191724",
    fg = "#abe9b3",
  },
  St_ReplaceMode = {
    bg = "#191724",
    fg = "#f6c177",
  },
  St_SelectMode = { fg = "#8bbec7", bg = "#191724" },
  St_CommandMode = { fg = "#abe9b3", bg = "#191724" },
  St_NormalmodeText = {
    fg = "#d7827e",
    bold = false,
  },
  St_ConfirmMode = { fg = "#6aadc8", bg = "#191724" },
  St_gitIcons = { fg = "#8986a1" },
}

return M
