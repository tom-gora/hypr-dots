-- code lifted and modified per my needs from nvchad's "minimal" implementation. Skips all other themes and fluff
-- I don't like NnChad's BDFL and community and stealing with pride 󱚞 󱚞 󱚞 󱚞 󱚞
--
local function compose_statusline(modules)
  -- import component functions
  local comps = require("tomeczku.core.statusline.components")
  -- assign the components
  modules[1] = comps.mode_plus_path()
  modules[2] = comps.macro_indicator()
  modules[3] = comps.git()
  modules[4] = "%="
  modules[5] = comps.lsp_progress()
  modules[6] = "%="
  modules[7] = comps.lsp_diags()
  modules[8] = comps.lsp_stat()
  modules[9] = comps.cursor_pos()
end

-- make sure lsp status updates itself
-- (investigate? not sure if this works in my config at all and if I even need this indicator at all)
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(args)
    if string.find(args.match, "end") then
      vim.cmd "redrawstatus"
    end
    vim.cmd "redrawstatus"
  end,
})

-- return by calling a function explicitely mainly to ensure vim.g.statusline_winid gets set
-- because this was a bitch of troubleshooting to fix -_-
return {
  ["compose_statusline"] = function()
    local modules = {}
    compose_statusline(modules)
    return table.concat(modules)
  end
}
