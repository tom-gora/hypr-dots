local M = {}

M.config_function = function()
  local center_hl = vim.api.nvim_get_hl(0, { name = "InclineCenter" })
  local outer_hl = vim.api.nvim_get_hl(0, { name = "InclineOuter" })
  local center_hl_inactive =
    vim.api.nvim_get_hl(0, { name = "InclineCenterInactive" })
  local outer_hl_inactive =
    vim.api.nvim_get_hl(0, { name = "InclineOuterInactive" })
  local pos_slant_hl = vim.api.nvim_get_hl(0, { name = "InclineSlant" })
  local pos_hl = vim.api.nvim_get_hl(0, { name = "InclinePosition" })
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

      local active_pill_end_hl_hex = {
        guifg = "#" .. string.format("%06x", outer_hl.fg),
        guibg = "#" .. string.format("%06x", outer_hl.bg),
      }
      local active_pill_center_hl_hex = {
        guifg = "#" .. string.format("%06x", center_hl.fg),
        guibg = "#" .. string.format("%06x", center_hl.bg),
      }
      local inactive_pill_end_hl_hex = {
        guifg = "#" .. string.format("%06x", outer_hl_inactive.fg),
        guibg = "#" .. string.format("%06x", outer_hl_inactive.bg),
      }
      local inactive_pill_center_hl_hex = {
        guifg = "#" .. string.format("%06x", center_hl_inactive.fg),
        guibg = "#" .. string.format("%06x", center_hl_inactive.bg),
      }
      local pos_hl_hex = {
        guifg = "#" .. string.format("%06x", pos_hl.fg),
        guibg = "#" .. string.format("%06x", pos_hl.bg),
      }
      local pos_slant_hl_hex = {
        guifg = "#" .. string.format("%06x", pos_slant_hl.fg),
        guibg = "#" .. string.format("%06x", pos_slant_hl.bg),
      }

      local end_pill_data = {
        "",
        guifg = active_pill_end_hl_hex.guifg,
        guibg = active_pill_end_hl_hex.guibg,
      }

      local position = function()
        local coordinates = vim.api.nvim_win_get_cursor(0)
        end_pill_data = {
          " ",
          guifg = pos_slant_hl_hex.guibg,
          guibg = active_pill_end_hl_hex.guibg,
        }
        return {
          {
            " ",
            guibg = active_pill_center_hl_hex.guibg,
          },
          {
            "",
            guifg = pos_slant_hl_hex.guifg,
            guibg = pos_slant_hl_hex.guibg,
          },
          {
            " " .. coordinates[1] .. "/" .. coordinates[2],
            guibg = pos_hl_hex.guibg,
            guifg = pos_hl_hex.guifg,
            gui = "bold",
          },
        }
      end
      if props.focused then
        return {
          {
            "",
            guifg = active_pill_end_hl_hex.guifg,
            guibg = active_pill_end_hl_hex.guibg,
          },
          {
            filename,
            guibg = active_pill_center_hl_hex.guibg,
            guifg = active_pill_center_hl_hex.guifg,
            gui = "bold",
          },
          position(),
          end_pill_data,
        }
      end
      return {
        {
          "",
          guifg = inactive_pill_end_hl_hex.guifg,
          guibg = inactive_pill_end_hl_hex.guibg,
        },
        {
          filename,
          guibg = inactive_pill_center_hl_hex.guibg,
          guifg = inactive_pill_center_hl_hex.guifg,
          gui = "bold",
        },
        {
          " ",
          guifg = inactive_pill_end_hl_hex.guifg,
          guibg = inactive_pill_end_hl_hex.guibg,
        },
      }
    end,
  }
end

return M
