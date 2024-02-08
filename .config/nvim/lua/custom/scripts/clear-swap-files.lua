function Clear_swap()
  local swap_dir = vim.fn.expand "$HOME" .. "/.local/state/nvim/swap"
  local function clear_both_cmd_lines()
    vim.fn.timer_start(2000, function()
      vim.cmd "echo"
      print "\n"
      vim.cmd "echo"
    end)
  end
  local is_empty = vim.fn.empty(vim.fn.glob(swap_dir .. "/*")) == 1

  if vim.fn.isdirectory(swap_dir) == 0 then
    print "Failed to clear the directory! 󰇸"
  else
    if is_empty then
      print "Swap directory is already empty! 󰇵"
      vim.fn.timer_start(2000, function()
        clear_both_cmd_lines()
      end)
    else
      local target = swap_dir .. "/*"
      local attempt_deletion = "bash -c 'rm -f " .. target .. "'"
      local long_q =
        "Are you sure you want to clear the content of the swap dir? (y/n) "

      local confirmed = false

      while not confirmed do
        local user_input = vim.fn.input(long_q)
        print " "

        if user_input:lower() == "y" then
          confirmed = true
          vim.fn.system(attempt_deletion)
          print "Cleared the content of the swap directory! 󰇵"
          clear_both_cmd_lines()
          break
        elseif user_input:lower() == "n" then
          confirmed = true
          print "Operation aborted"
          clear_both_cmd_lines()
          break
        else
          print "Invalid input. Please enter 'y' or 'n'."
          clear_both_cmd_lines()
        end
      end
    end
  end
end
