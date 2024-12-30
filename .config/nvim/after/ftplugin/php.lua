vim.b.php = true

-- register local keymaps on php file buffers IF it is a laravel project
-- meaning it has a composer.json file with the laravel/laravel package declared

if vim.fn.findfile("composer.json", ".;") ~= "" then
	local composer_conf = vim.fn.readfile(vim.fn.findfile("composer.json", ".;"))
	for _, line in ipairs(composer_conf) do
		if line:match('"name"%s*:%s*"laravel/laravel"') then
			local wk = require("which-key")
			wk.add({
				-- laraver plugin keymaps
				{ "<leader>L", group = "󰫐 Laravel", buffer = true },
				{ "<leader>LA", "<cmd>Laravel artisan<cr>", buffer = true, desc = "Artisan" },
				{ "<leader>LR", "<cmd>Laravel routes<cr>", buffer = true, desc = "Routes" },
				{ "<leader>LM", "<cmd>Laravel related<cr>", buffer = true, desc = "Related" },
			})
			-- load laravel snippets
			require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/vscode/laravel/" })
		end
	end
end
