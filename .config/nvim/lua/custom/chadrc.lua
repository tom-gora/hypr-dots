-- bring in my custom configs

-- vim opts definitions
require "custom.my-vim-opts"
-- script to allow quick cleanup of swap backups
require "custom.scripts.clear-swap-files"
-- quick toggle lsp doc hover window off/on with <a-cr>
require "custom.scripts.toggle-float-doc"
-- fix the fact that without default filebrowser an empty  bufnr 1
-- with name being "." or root directory path remains and clutters
-- the bufferlist. This only happens when no default filebrowser
-- and "nvim ." used to run neovim
require "custom.scripts.force-empty-buffer-1-to-autoclose"
-- Jumping to buffer by uid displayed in incline
require "custom.scripts.go-to-buf-by-uid"
-- QOL wrappers for some plugin commands
require "custom.scripts.wrappers"
-- my autocommands
require "custom.autocommands"
-- in windows at least half the screen width open help splits vertical with wrap
require("custom.scripts.modified_vertical_help_plugin").activateFix()

---@diagnostic disable: inject-field
---@type ChadrcConfig
local M = {}
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
    selected_item_bg = "colored",
  },
  -- disabling default fluff. welcome dashboard is gone and
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
  -- custom highlights
  hl_override = require("custom.highlights").override,
  -- in case semantic error shows up try disabling and uncommenting
  -- the autocmd "Semantic Tokens Fix" in the autocommands.lua file
  lsp_semantic_tokens = true,
}
M.cmp = {
  -- insert cody completions into cmp sources list
  sources = { name = "nvim_lsp" },
  { name = "cody" },
  { name = "path" },
  { name = "buffer" },
}
-- bring in plugins from plugin folder
M.plugins = "custom.plugins"
-- mappings customization
M.mappings = require "custom.mappings"
-- lazy config redone just to enable bordered theme
M.lazy_nvim = require "custom.configs.lazy"

return M
