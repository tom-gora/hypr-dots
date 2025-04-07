vim.b.blade = true
local maps = require("tomeczku.core.keymaps.filetype_specific")

-- register local keymaps on blade file buffers
maps.laravel()
-- load laravel snippets
local vsc = require("luasnip.loaders.from_vscode")
vsc.load_standalone({ path = "~/.config/nvim/snippets/vscode/blade.code-snippets" })
