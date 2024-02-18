local my_augroup = vim.api.nvim_create_augroup("MyAugroup", { clear = true })

vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = "lua On_bufnew_clean()", group = my_augroup, once = true }
)

-- autocmd to handle global buffer uid trakcer when buffer is being unloaded
vim.api.nvim_create_autocmd({ "BufUnload" }, {
  group = my_augroup,
  callback = function()
    local wipedout_buf = tonumber(vim.fn.expand "<abuf>")
    local success = pcall(vim.api.nvim_buf_get_var, wipedout_buf, "buf_uid")
    if success then
      Buf_uid_tracker = Buf_uid_tracker - 1
    end
  end,
})

-- make sure native term used by code runner does not display numberline
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

-- open help window in a vertical split
-- vim.api.nvim_create_autocmd({ "FileType", "WinEnter" }, {
--   pattern = "help",
--   group = my_augroup,
--   callback = function()
--   end,
-- })

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
