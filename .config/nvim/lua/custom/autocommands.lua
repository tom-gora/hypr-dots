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

-- fix my damn C# semicolons XD;
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = my_augroup,
--   pattern = { "*.cs", "*.vb" },
--   callback = function()
--     local diagnostics_data = vim.diagnostic.get()
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     for _, diagnostic in pairs(diagnostics_data) do
--       if diagnostic.message == "; expected" then
--         vim.cmd(tostring(diagnostic.lnum + 1))
--         vim.cmd "normal! A;"
--         vim.api.nvim_win_set_cursor(0, cursor_pos)
--       elseif diagnostic.message == "} expected" then
--         vim.cmd(tostring(diagnostic.lnum + 1))
--         vim.cmd "normal! A}"
--         vim.api.nvim_win_set_cursor(0, cursor_pos)
--       end
--     end
--   end,
-- })

-- below were used to manually run tailwind build process on save
-- when I was building plain php + tailwind project and it had zero integration
-- to do this automatically. Also a very crude callback to refresh the browser
--
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = my_augroup,
--   pattern = { "*.php" },
--   callback = function()
--     local tailwind_attached =
--       vim.lsp.get_active_clients { name = "tailwindcss" }
--     if tailwind_attached then
--       local file = vim.fn.expand "%:."
--       vim.cmd ":!npm run build-css"
--       vim.cmd "call feedkeys('\\<cr>')"
--       vim.cmd ":!echo key ctrl+f5 | dotool"
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = my_augroup,
--   pattern = { "*.html", "*.css", "*.scss", "*.js", "*.jsx", "*.ts", "*.tsx" },
--   callback = function()
--     local tailwind_attached =
--       vim.lsp.get_active_clients { name = "tailwindcss" }
--     if tailwind_attached then
--       local file = vim.fn.expand "%:."
--       vim.cmd ":!npm run build-css"
--       vim.cmd "call feedkeys('\\<cr>')"
--       vim.cmd(
--         ":!prettier ./"
--           .. file
--           .. " --write --plugin=prettier-plugin-tailwindcss"
--       )
--     end
--   end,
-- })
------------------------------------------------------------------------------

-- "HACK: Semantic Tokens Error Fix"
--
-- local mod_mode = require "custom.configs.statusline_conf"
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- })
