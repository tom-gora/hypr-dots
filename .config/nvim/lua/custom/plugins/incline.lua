local M = {}

M = {
  "b0o/incline.nvim",
  event = "VeryLazy",
  config = function()
    local center_hl = vim.api.nvim_get_hl(0, { name = "InclineCenter" })
    local outer_hl = vim.api.nvim_get_hl(0, { name = "InclineOuter" })
    local center_hl_inactive =
      vim.api.nvim_get_hl(0, { name = "InclineCenterInactive" })
    local outer_hl_inactive =
      vim.api.nvim_get_hl(0, { name = "InclineOuterInactive" })
    Buf_uid_tracker = 1

    require("incline").setup {
      window = {
        margin = { vertical = 0, horizontal = 0 },
        padding = 0,
      },
      hide = {
        cursorline = false,
      },
      render = function(props)
        local success, current_buf_uid =
          pcall(vim.api.nvim_buf_get_var, props.buf, "buf_uid")
        if not success or current_buf_uid == nil then
          vim.api.nvim_buf_set_var(props.buf, "buf_uid", Buf_uid_tracker)
          Buf_uid_tracker = Buf_uid_tracker + 1
        end

        local filename = vim.api.nvim_buf_get_var(props.buf, "buf_uid")
          .. " "
          .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if vim.bo[props.buf].modified then
          filename = filename .. "  "
        end

        local active_pill_end_hl = {
          guifg = "#" .. string.format("%06x", outer_hl.fg),
          guibg = "#" .. string.format("%06x", outer_hl.bg),
        }
        local active_pill_center_hl = {
          guifg = "#" .. string.format("%06x", center_hl.fg),
          guibg = "#" .. string.format("%06x", center_hl.bg),
        }
        local inactive_pill_end_hl = {
          guifg = "#" .. string.format("%06x", outer_hl_inactive.fg),
          guibg = "#" .. string.format("%06x", outer_hl_inactive.bg),
        }
        local inactive_pill_center_hl = {
          guifg = "#" .. string.format("%06x", center_hl_inactive.fg),
          guibg = "#" .. string.format("%06x", center_hl_inactive.bg),
        }

        local icon, color =
          require("nvim-web-devicons").get_icon_color(filename)
        if props.focused then
          return {
            {
              "",
              guifg = active_pill_end_hl.guifg,
              guibg = active_pill_end_hl.guibg,
            },
            {
              icon,
              guifg = color,
              guibg = active_pill_center_hl.guibg,
            },
            {
              " ",
              guibg = active_pill_center_hl.guibg,
            },
            {
              filename,
              guibg = active_pill_center_hl.guibg,
              guifg = active_pill_center_hl.guifg,
            },
            {
              "",
              guifg = active_pill_end_hl.guifg,
              guibg = active_pill_end_hl.guibg,
            },
          }
        end
        return {
          {
            "",
            guifg = inactive_pill_end_hl.guifg,
            guibg = inactive_pill_end_hl.guibg,
          },
          {
            icon,
            guifg = color,
            guibg = inactive_pill_center_hl.guibg,
          },
          {
            " ",
            guibg = inactive_pill_center_hl.guibg,
          },
          {
            filename,
            guibg = inactive_pill_center_hl.guibg,
            guifg = inactive_pill_center_hl.guifg,
          },
          {
            "",
            guifg = inactive_pill_end_hl.guifg,
            guibg = inactive_pill_end_hl.guibg,
          },
        }
      end,
    }
  end,
}

return M
