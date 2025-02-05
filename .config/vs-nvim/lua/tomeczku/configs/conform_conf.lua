local M = {}

local opts = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		html = { "prettier" },
		markdown = { "prettier" },
		zshrc = { "shfmt" },
		css = { "prettier" },
		cshtml = { "prettier" },
		json = { "prettier" },
		sh = { "shfmt" },
		xml = { "xmlformatter" },
		csproj = { "xmlformatter" },
		java = { "google-java-format" },
		astro = { "prettier" },
		php = { "prettier" },
		svg = { "xmlformat" },
		go = { "gofumpt" },
	},

	-- adding same formatter for multiple filetypes can look too much work for some
	-- instead of the above code you could just use a loop! the config is just a table after all!

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 1000,
		lsp_fallback = true,
	},
}

M.config_function = function()
	vim.api.nvim_create_user_command("ConformFormat", function(args)
		local range = nil
		if args.count ~= -1 then
			local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
			range = {
				start = { args.line1, 0 },
				["end"] = { args.line2, end_line:len() },
			}
		end
		require("conform").format({ async = true, lsp_fallback = true, range = range })
	end, { range = true })

	require("conform").setup(opts)
end

return M
