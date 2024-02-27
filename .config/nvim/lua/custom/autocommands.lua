local my_augroup = vim.api.nvim_create_augroup("MyAugroup", { clear = true })

vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = "lua _G.OnBufnewClean()", group = my_augroup, once = true }
)

--[[ autocmd to handle global buffer uid tracker when buffer is being unloaded
 and reassign ordinal uid values to still opened bufs
 (assigning the uid to a file buffer handled by incline while rendering a new
 incline hover for a newly opened buf) ]]

vim.api.nvim_create_autocmd({ "BufUnload" }, {
  group = my_augroup,
  callback = function()
    local wipedout_buf = tonumber(vim.fn.expand "<abuf>")
    local wipedout_buf_uid
    -- if buf being unlisted has uid (meaning is an opened file) store its uid
    local success = pcall(vim.api.nvim_buf_get_var, wipedout_buf, "buf_uid")
    if success then
      wipedout_buf_uid = vim.api.nvim_buf_get_var(wipedout_buf, "buf_uid")
      -- check if the unloaded buffer is the top one
      -- because if so the entire loop and decrementing below is redundant
      if wipedout_buf_uid == Buf_uid_tracker - 1 then
        -- so just decrement global tracker and end callback
        Buf_uid_tracker = Buf_uid_tracker - 1
        return
      end

      --[[but if in-order "earlier" buffer is being unlisted
       loop over buffers to decrement buf_uid where buf_uid > wipedout_buf_uid
       effectively removing a number from a list ]]
      local buffers = vim.api.nvim_list_bufs()
      for _, buf in ipairs(buffers) do
        ---@diagnostic disable-next-line: redefined-local
        local success, buf_uid = pcall(vim.api.nvim_buf_get_var, buf, "buf_uid")
        if success and buf_uid and buf_uid > wipedout_buf_uid then
          vim.api.nvim_buf_set_var(buf, "buf_uid", buf_uid - 1)
        end
      end
      -- finally after adjusting buffers buf_uids decrement global tracker
      Buf_uid_tracker = Buf_uid_tracker - 1
    end
  end,
})

--[[ make sure native term used by code runner does not display numberline
  (for some reason inbuilt config option did not work for me?) ]]
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = my_augroup,
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "terminal" then
        vim.api.nvim_win_set_option(win, "number", false)
        vim.api.nvim_win_set_option(win, "relativenumber", false)
      end
    end
  end,
})

-- in windows at least half the screen width open help splits vertical with wrap
vim.api.nvim_create_autocmd({ "WinNew" }, {
  group = my_augroup,
  callback = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = my_augroup,
      once = true,
      callback = function()
        _G.VerticalSplitHelper()
      end,
    })
  end,
})

------------------------------------------------------------------------------

-- "HACK: Semantic Tokens Error Fix"
--
-- local mod_mode = require "custom.configs.statusline"
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- })
