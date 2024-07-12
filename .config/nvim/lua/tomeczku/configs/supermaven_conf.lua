local M = {}

M.config_function = function()
  require("supermaven-nvim").setup(
    {
      log_level = "off",
      -- disable inline ai as I prefer using cmp suggestions
      disable_inline_completion = true,
      disable_keymaps = true
    })
end

return M
