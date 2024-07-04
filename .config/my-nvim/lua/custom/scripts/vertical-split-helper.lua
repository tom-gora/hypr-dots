-- src: https://github.com/anuvyklack/help-vsplit.nvim

-- brought the code into my config locally
-- because it has a small footprint and I want my own tweaks done to it
-- dynamically recalculate the split width, change the breakpoint
-- and simplify the plugin wrapping layers

---@diagnostic disable-next-line: duplicate-set-field -> calm your tits luacheck
function _G.VerticalSplitHelper()
  if vim.bo.buftype == "help" or vim.bo.filetype == "man" then
    ---The ID of the origin window from which help window was opened:
    ---i.e. last accessed window.
    local origin_win = vim.fn.win_getid(vim.fn.winnr "#")
    local origin_buf = vim.api.nvim_win_get_buf(origin_win)

    -- this is because I still want it to split vertically when I have window
    -- taking half the screen in a tiler and don't need to adhere to 80 columns
    -- of traditional terminal width
    local origin_textwidth = vim.bo[origin_buf].textwidth
    if origin_textwidth == 0 then
      origin_textwidth = 50
    end
    if vim.api.nvim_win_get_width(origin_win) >= origin_textwidth + 50 then
      local help_buf = vim.fn.bufnr()

      ---Origin 'bufhidden' property or the help buffer.
      local bufhidden = vim.bo.bufhidden
      vim.bo.bufhidden = "hide"

      local old_help_win = vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win(origin_win)
      vim.api.nvim_win_close(old_help_win, false)

      -- Create new help vertical split window and make it active.
      vim.cmd "vsplit"
      -- set my own dybamic width to the split
      local help_win_width = math.floor(vim.o.columns * 0.4)
      vim.cmd("vert resize " .. help_win_width)
      -- and add wrap
      vim.wo.wrap = true
      -- goto help split
      vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf)
      vim.bo.bufhidden = bufhidden
    end
  end
end
