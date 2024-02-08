local function statusline(modules)
  local config = require("core.utils").load_config().ui.statusline
  local sep_style = config.separator_style

  sep_style = (sep_style ~= "round" and sep_style ~= "block") and "block"
    or sep_style

  local default_sep_icons = {
    round = { left = "", right = "" },
    block = { left = "█", right = "█" },
  }

  local separators = (type(sep_style) == "table" and sep_style)
    or default_sep_icons[sep_style]

  local sep_l = separators["left"]
  local sep_r = "%#St_sep_r#" .. separators["right"] .. " %#ST_EmptySpace#"

  local function is_activewin()
    return vim.api.nvim_get_current_win() == vim.g.statusline_winid
  end

  local function gen_block(icon, txt, sep_l_hlgroup, iconHl_group, txt_hl_group)
    return sep_l_hlgroup
      .. sep_l
      .. iconHl_group
      .. icon
      .. " "
      .. txt_hl_group
      .. " "
      .. txt
      .. sep_r
  end
  local minimal = require "nvchad.statusline.minimal"
  local modes = minimal.modes
  -- tweak normal mode ( nvim logo is a fallback so no need to declare all)
  modes["n"][3] = ""
  modes["n"][1] = "NORM"
  -- tweak visual modes
  modes["v"][3] = ""
  modes["V"][3] = ""
  modes["Vs"][3] = ""
  modes[""][3] = ""
  -- tweak insert modes
  modes["i"][3] = ""
  modes["ic"][3] = ""
  modes["ix"][3] = ""
  modes["i"][1] = "INS "
  -- tweak terminal mode
  modes["t"][3] = ""
  modes["t"][1] = "TERM"
  modules[1] = (function()
    if not is_activewin() then
      return ""
    end

    local m = vim.api.nvim_get_mode().mode
    local current_mode = "%#" .. modes[m][2] .. "#" .. (modes[m][3] or "  ")
    return gen_block(
      current_mode,
      modes[m][1],
      "%#" .. modes[m][2] .. "sep#",
      "%#" .. modes[m][2] .. "#",
      "%#" .. modes[m][2] .. "text#"
    )
  end)()
end

return statusline
