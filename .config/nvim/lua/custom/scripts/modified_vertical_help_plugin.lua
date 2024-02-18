-- src: https://github.com/anuvyklack/help-vsplit.nvim

-- brought the code into my config locally
-- because it has a small footprint and I want my own tweaks done to it
-- dynamically recalculate the split width, change the breakpoint
-- and simplify the plugin wrapping layers

local api = vim.api
local bo = vim.bo
local fn = vim.fn
local M = {}

local buftype = { "help" }
local filetype = { "man" }

local function condition()
  for _, btype in ipairs(buftype) do
    if bo.buftype == btype then
      return true
    end
  end
  for _, ftype in ipairs(filetype) do
    if bo.filetype == ftype then
      return true
    end
  end
  return false
end

function NewHelpSplit()
  if condition() then
    ---The ID of the origin window from which help window was opened:
    ---i.e. last accessed window.
    local origin_win = fn.win_getid(fn.winnr "#")
    local origin_buf = api.nvim_win_get_buf(origin_win)

    local origin_textwidth = bo[origin_buf].textwidth
    if origin_textwidth == 0 then
      origin_textwidth = 50
    end

    if api.nvim_win_get_width(origin_win) >= origin_textwidth + 50 then
      local help_buf = fn.bufnr()

      ---Origin 'bufhidden' property or the help buffer.
      local bufhidden = bo.bufhidden
      bo.bufhidden = "hide"

      local old_help_win = api.nvim_get_current_win()
      api.nvim_set_current_win(origin_win)

      api.nvim_win_close(old_help_win, false)

      -- Create new help vertical split window and make it active.
      vim.cmd "vsplit"
      -- set my own dybamic width to the split
      local help_win_width = math.floor(vim.o.columns * 0.4)
      vim.cmd("vert resize " .. help_win_width)
      -- and add wrap
      vim.wo.wrap = true
      -- goto help split
      api.nvim_win_set_buf(api.nvim_get_current_win(), help_buf)
      bo.bufhidden = bufhidden
    end
  end
end

function M.activateFix()
  vim.cmd [[
      augroup HelpSplit
         autocmd!
         autocmd WinNew * autocmd BufEnter * ++once lua NewHelpSplit()
      augroup end
   ]]
end
return M
