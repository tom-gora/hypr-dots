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

local my_augroup = vim.api.nvim_create_augroup("MyAugroup", { clear = true })
vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = "lua On_bufnew_clean()", group = my_augroup, once = true }
)

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
local highlights = require "custom.highlights"

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

  hl_override = highlights.override,

  -- in case semantic error shows up try disabling and uncommenting
  -- the autocmd above this table
  lsp_semantic_tokens = true,
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
M.lazy_nvim = require "custom.configs.lazy"
return M
