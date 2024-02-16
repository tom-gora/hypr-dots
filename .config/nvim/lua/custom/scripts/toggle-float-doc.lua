-- ToggleFloatDoc = function()
--   local winid_store = -1
--
--   for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
--     if
--       vim.api.nvim_win_get_config(winid).zindex
--       and vim.api.nvim_win_get_config(winid).focusable
--     then
--       winid_store = winid
--     end
--   end
--   if winid_store == -1 then
--     vim.lsp.buf.hover()
--   else
--     vim.api.nvim_win_close(winid_store, true)
--   end
-- end
--

-- This Lua file defines a ToggleFloatDoc function to toggle the display of
-- floating documentation windows in Neovim.

-- Declare the ToggleFloatDoc function
ToggleFloatDoc = function()
  -- Initialize a variable to store the float window ID
  local winid_store = -1

  -- Loop through all windows in the current tabpage
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    -- Check if the window is a floating window
    if
      vim.api.nvim_win_get_config(winid).zindex
      and vim.api.nvim_win_get_config(winid).focusable
    then
      -- Store the ID of the floating window
      winid_store = winid
    end
  end

  -- If no floating window found, open hover documentation
  if winid_store == -1 then
    vim.lsp.buf.hover()

  -- Otherwise, close the floating window
  else
    vim.api.nvim_win_close(winid_store, true)
  end
end
