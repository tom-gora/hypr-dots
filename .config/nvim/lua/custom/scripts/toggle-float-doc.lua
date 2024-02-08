ToggleFloatDoc = function()
  local winid_store = -1

  -- -- Create a new buffer
  -- vim.cmd "enew"
  --
  -- -- Get the current tabpage
  -- local current_tabpage = vim.fn.tabpagenr()
  --
  -- -- Get the list of windows in the current tabpage
  -- local windows = vim.api.nvim_tabpage_list_wins(current_tabpage)
  --
  -- -- Iterate over the windows and print their names
  -- for _, winid in ipairs(windows) do
  --   local win_name = vim.fn.winbufnr(winid)
  --   local win_data = vim.api.nvim_win_get_config(winid)
  --   local function tableToString(tbl)
  --     local result = "{"
  --
  --     for key, value in pairs(tbl) do
  --       if type(value) == "table" then
  --         result = result .. tostring(key) .. "=" .. tableToString(value) .. ","
  --       else
  --         result = result .. tostring(key) .. "=" .. tostring(value) .. ","
  --       end
  --     end
  --
  --     result = result .. "}"
  --     return result
  --   end
  --   vim.cmd("put='" .. win_name .. " " .. tableToString(win_data) .. "'")
  -- end

  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if
      vim.api.nvim_win_get_config(winid).zindex
      and vim.api.nvim_win_get_config(winid).focusable
    then
      winid_store = winid
    end
  end
  if winid_store == -1 then
    vim.lsp.buf.hover()
  else
    vim.api.nvim_win_close(winid_store, true)
  end
end
