function On_bufnew_clean()
  local buffers = vim.api.nvim_list_bufs()

  -- if more than one buf do checks foreach
  if #buffers > 1 then
    for _, bufnr in ipairs(buffers) do
      -- Check if the buffer number is 1
      if bufnr == 1 then
        -- Check if the buffer is empty
        local lines = vim.api.nvim_buf_get_lines(1, 0, -1, false)
        if lines[1] == "" then
          -- Wipe out the buffer
          vim.api.nvim_buf_delete(bufnr, { force = false })
          Buf_uid_tracker = Buf_uid_tracker - 1
          -- Quietly end the function execution
          return
        end
        -- Break the loop after processing buffer 1
        break
      end
    end
  end
end
