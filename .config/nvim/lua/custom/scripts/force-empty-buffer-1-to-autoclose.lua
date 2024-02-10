function On_bufnew_clean()
  local buffers = vim.api.nvim_list_bufs()

  -- if more than one buf do checks foreach
  if #buffers > 1 then
    for _, bufnr in ipairs(buffers) do
      -- Check if the bufnr is 1
      if bufnr == 1 then
        -- Check if no lines
        local lines = vim.api.nvim_buf_get_lines(1, 0, -1, false)
        if lines[1] == "" then
          -- Wipe out the buffer and fix the global buffer uid tracker
          vim.api.nvim_buf_delete(bufnr, { force = true })
          Buf_uid_tracker = Buf_uid_tracker - 1
          return
        end
        -- Break after sorting buffer 1
        break
      end
    end
  end
end
