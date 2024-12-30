vim.b.gomod = true

vim.api.nvim_set_keymap(
	"n",
	"<leader>x",
	"<cmd>RunGoProject<CR>",
	{ noremap = true, silent = true, desc = " Execute in Terminal" }
)

-- load go snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/vscode/go/go.json" })
require("luasnip.loaders.from_snipmate").lazy_load({ path = "~/.config/nvim/snippets/snipmate/go/go.snippets" })
