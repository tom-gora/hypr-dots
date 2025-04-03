if vim.g.vscode then
	return
end

local M, opts, config_function

opts = {
	lsp_fallback = true,

	formatters = {
		pint = {
			command = "./vendor/bin/pint",
		},
	},

	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		html = { "prettierd" },
		markdown = { "prettierd" },
		zshrc = { "shfmt" },
		css = { "prettierd" },
		cshtml = { "prettierd" },
		json = { "prettierd" },
		sh = { "shfmt" },
		xml = { "xmlformatter" },
		csproj = { "xmlformatter" },
		java = { "google-java-format" },
		astro = { "prettier" },
		php = { "pint" },
		blade = { "blade-formatter" },
		svg = { "xmlformat" },
		go = { "gofumpt" },
		yaml = { "prettierd" },
		["yaml.docker-compose"] = { "prettierd" },
	},

	-- adding same formatter for multiple filetypes can look too much work for some
	-- instead of the above code you could just use a loop! the config is just a table after all!

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 3000,
		lsp_format = "fallback",
	},
	format_after_save = function()
		local t_attached = vim.tbl_contains(
			vim.tbl_map(function(c)
				return c.name
			end, vim.lsp.get_clients()),
			"tailwindcss"
		)
		if not t_attached or not pcall(require, "tailwind-tools") then
			return
		end

		vim.cmd("TailwindSort")
		-- These options will be passed to conform.format()
		return { lsp_format = "fallback" }
	end,
}

config_function = function()
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

M = {
	"stevearc/conform.nvim",
	cond = vim.g.vscode == nil,
	event = "LspAttach",
	config = config_function,
}

return M
