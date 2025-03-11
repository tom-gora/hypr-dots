vim.b.blade = false

-- register local keymaps on blade file buffers
local wk = require("which-key")
wk.add({
	-- laraver plugin keymaps
	{ "<leader>L", group = "󰫐 Laravel", buffer = true },
	{ "<leader>LA", "<cmd>Laravel artisan<cr>", buffer = true, desc = "Laravel Artisan" },
	{ "<leader>LR", "<cmd>Laravel routes<cr>", buffer = true, desc = "Laravel Routes" },
	{ "<leader>LM", "<cmd>Laravel related<cr>", buffer = true, desc = "Laravel Related" },
})
-- load laravel snippets
local vsc = require("luasnip.loaders.from_vscode")
vsc.load_standalone({ path = "~/.config/nvim/snippets/vscode/blade.code-snippets" })
