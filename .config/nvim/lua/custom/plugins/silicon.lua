local M = {}

M = {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  config = function()
    require("silicon").setup {
      -- Configuration here, or leave empty to use defaults
      font = "JetBrainsMono Nerd Font=34;Noto Emoji=34",
      theme = "Sublime Snazzy",
      to_clipboard = true,
      window_title = function()
        return vim.fn.fnamemodify(
          vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
          ":t"
        )
      end,
      background = "#28253B",
      shadow_color = "#110F17",
    }
  end,
}

return M
