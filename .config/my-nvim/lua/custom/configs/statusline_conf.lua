local function statusline(modules)
  local root_sep = ""
  local this_is_the_paths_end = ""

  local function is_activewin()
    return vim.api.nvim_get_current_win() == vim.g.statusline_winid
  end

  local lsp_status = function()
    if rawget(vim, "lsp") then
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        if
          client.attached_buffers[vim.fn.winbufnr(vim.g.statusline_winid)]
          and client.name ~= "null-ls"
        then
          return (
            vim.o.columns > 86
            and "%#St_ConfirmMode#"
              .. "%#St_ConfirmModeCustomTxt#"
              .. " "
              .. client.name
              .. "%#St_ConfirmMode# "
          ) or "%#St_ConfirmMode# "
        end
      end
    end

    return ""
  end
  local minimal = require "nvchad.statusline.minimal"

  local modes = minimal.modes
  local function mypath_formatter()
    local project_root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    local relative_path =
      vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
    local file_name = vim.fn.fnamemodify(relative_path, ":t")
    if vim.o.columns < 86 then
      relative_path = "󰇘/" .. file_name
    end
    if vim.api.nvim_get_mode().mode == "t" then
      root_sep = ""
      this_is_the_paths_end = ""
      return { root = "", path = "" }
    end
    return {
      root = "  " .. project_root .. " %#St_Root_Sep_Right#",
      path = relative_path,
    }
  end
  local path_components = mypath_formatter()
  -- tweak normal mode ( nvim logo is a fallback so no need to declare all)
  modes["n"][3] = "N"
  -- tweak visual modes
  modes["v"][3] = "V"
  modes["V"][3] = "V"
  modes["Vs"][3] = "V"
  modes[""][3] = "V"
  -- tweak insert modes
  modes["i"][3] = "I"
  modes["ic"][3] = "I"
  modes["ix"][3] = "I"
  -- tweak terminal mode
  modes["t"][3] = "   Term mode baby!"
  modules[1] = (function()
    if not is_activewin() then
      return ""
    end

    local m = vim.api.nvim_get_mode().mode
    local current_mode = "%#"
      .. modes[m][2]
      .. "#"
      .. " "
      .. "%#"
      .. modes[m][2]
      .. "CustomTxt"
      .. "#"
      .. (modes[m][3] or "")
      .. " "
      .. "%#"
      .. modes[m][2]
      .. "_Root_Sep#"
      .. root_sep
      .. "%#St_Root#"
      .. path_components["root"]
      .. "%#"
      .. modes[m][2]
      .. "Text#"
      .. path_components["path"]
      .. "%#St_sep_r#"
      .. this_is_the_paths_end
      .. "%#St_EmptySpace#  "
    return current_mode
  end)()
  modules[2] = ""
  modules[9] = lsp_status()
  modules[7] = ""
  modules[10] = ""
  modules[11] = ""
end

return statusline
