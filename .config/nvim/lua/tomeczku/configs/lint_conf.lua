local M = {}

M.event = { "BufReadPre", "BufNewFile" }

M.config_function = function()
	local lint = require("lint")

	lint.linters.luacheck.args = {
		"--globals",
		"love",
		"vim",
		"--formatter",
		"plain",
		"--codes",
		"--ranges",
		"-",
	}
	lint.linters_by_ft = {
		lua = { "luacheck" },
		go = { "revive" },
		html = { "markuplint" },
		bash = { "shellcheck" },
		zsh = { "shellcheck" },
		-- css = { "stylelint" },
		-- scss = { "stylelint" },

		-- javascript = { "eslint_d" },
		-- typescript = { "eslint_d" },
		-- javascriptreact = { "eslint_d" },
		-- typescriptreact = { "eslint_d" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		pattern = { "*.go", "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.html", "*.sh", "*.zsh", ".zshrc" },
		callback = function()
			lint.try_lint()
			-- vim.print("File linted by: " .. table.concat(lint.get_running(), ", "))
		end,
	})
end

return M
