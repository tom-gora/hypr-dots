local M = {}

M.opts = {
  cut_key = "X",
  override_del = true,
  exclude = {},
  registers = {
    select = "_",
    delete = "_",
    change = "_",
  },
}

return M
