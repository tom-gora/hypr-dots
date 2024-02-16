---@diagnostic disable: inject-field
---@type ChadrcConfig
local M = {}

require "custom.my-vim-opts"
require "custom.scripts.clear-swap-files"
require "custom.scripts.toggle-float-doc"
-- fix the fact that without default filebrowser an empty  bufnr 1
-- with name being "." or root directory path remains and clutters
-- the bufferlist. This only happens when no default filebrowser
-- and "nvim ." used to run neovim
require "custom.scripts.force-empty-buffer-1-to-autoclose"

-- Jumping to buffer by uid displayed in incline
require "custom.scripts.go-to-buf-by-uid"
require "custom.scripts.sourcegraph-wrappers"

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

-- make sure native term user bny code runner does not display numberline
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

-- local mod_mode = require "custom.configs.statusline"
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- })

M.ui = {
  theme = "rosepine",
  statusline = {
    theme = "minimal",
    separator_style = "round",
    overriden_modules = require "custom.configs.statusline",
  },
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default",
    selected_item_bg = "simple",
  },
  -- disabling default fluff. welcome dashboard and tab bar
  -- tab bar gets replaced with simple incline indicator
  nvdash = {
    enabled = false,
  },

  tabufline = {
    enabled = false,
  },
  -- set the Telescope style
  telescope = {
    style = "bordered",
  },

  hl_override = require("custom.highlights").override,

  -- in case semantic error shows up try disabling and uncommenting
  -- the autocmd above this table
  lsp_semantic_tokens = true,
}
M.cmp = {
  sources = { name = "nvim_lsp" },
  { name = "cody" },
  { name = "path" },
  { name = "buffer" },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
M.lazy_nvim = require "custom.configs.lazy"
return M
