vim.b.php = true
local maps = require("tomeczku.core.keymaps.filetype_specific")

-- register local keymaps on php file buffers IF it is a laravel project
-- meaning it has a composer.json file with the laravel/laravel package declared

if vim.fn.findfile("composer.json", ".;") ~= "" then
	local composer_conf = vim.fn.readfile(vim.fn.findfile("composer.json", ".;"))
	for _, line in ipairs(composer_conf) do
		if line:match('"name"%s*:%s*"laravel/laravel"') then
			maps.laravel()
			-- load laravel snippets
			local vsc = require("luasnip.loaders.from_vscode")
			vsc.load_standalone({ path = "~/.config/nvim/snippets/vscode/laravel.code-snippets" })
		end
	end
end
