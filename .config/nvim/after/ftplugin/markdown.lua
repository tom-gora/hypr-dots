local maps = require("tomeczku.core.keymaps.filetype_specific")

vim.b.markdown = true
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.list = true

maps.markdown()
