function Go_to_buf(buf_uid)
  local buffer_found = false
  for _, buf_num in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf_num) then
      local success, inspect_uid =
        pcall(vim.api.nvim_buf_get_var, buf_num, "buf_uid")
      if success and inspect_uid == buf_uid then
        vim.api.nvim_set_current_buf(buf_num)
        return true -- Indicate that the buffer was found and switched to
      end
    end
  end
  if not buffer_found then
    print "No such buffer, sorry ;("
  end
  return false -- Indicate that the buffer was not found
end
