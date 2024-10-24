local M = {}
local calc_width = function()
  return math.floor(vim.o.columns * 0.5)
end
local width = calc_width()

M.opts = {
  show_register_types = false,
  hide_only_whitespace = true,
  trim_whitespace = true,
  system_clipboard = true,
  show_empty = false,
  window = {
    max_width = width,
    highlight_cursorline = true,
    border = "rounded",
    transparency = 0,
  },
}

M.keys = {
  { "\"",    mode = { "n", "v" } },
  { "<C-R>", mode = "i" }
}

return M
