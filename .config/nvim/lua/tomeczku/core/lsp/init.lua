local M = {}
local on_attach, capabilities
local lsps = require("tomeczku.core.language_support").mason_required_packages
local h = require("tomeczku.core.keymaps.helpers")
local configs = require("tomeczku.core.lsp.configs")

on_attach = function(client, bufnr)
	-- disable semanticTokens
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	h.setupLspMappings(bufnr)
end

-- expand capabilities with blink
local ok, blink = pcall(require, "blink.cmp")
if ok then
	capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = blink.get_lsp_capabilities(capabilities)
else
	capabilities = vim.lsp.protocol.make_client_capabilities()
end

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.setup = function()
	-- loop over my declared lsps and set them up
	for _, lsp in ipairs(lsps) do
		local lsp_spec = require("mason-registry").get_package(lsp).spec
		if lsp_spec.categories[1] == "LSP" then
			-- bring in customized setup functions conditionally
			if lsp == "lua-language-server" then
				configs.lua_setup(capabilities, on_attach, lsp)
			elseif lsp == "bash-language-server" then
				configs.bash_setup(capabilities, on_attach, lsp)
			elseif lsp == "emmet-language-server" then
				configs.emmet_setup(capabilities, on_attach, lsp)
			elseif lsp == "astro-language-server" then
				configs.astro_setup(capabilities, on_attach, lsp)
			elseif lsp == "phpactor" then
				configs.phpactor_setup(capabilities, on_attach, lsp)
			elseif lsp == "tailwindcss-language-server" then
				configs.tailwind_setup(capabilities, on_attach, lsp)
			elseif lsp == "typescript-language-server" or lsp == "ts_ls" then
				configs.typesctipt_setup(capabilities, on_attach, lsp)
			elseif lsp == "omnisharp" then
				configs.omnisharp_setup(capabilities, on_attach, lsp)
			elseif lsp == "html-lsp" then
				configs.html_setup(capabilities, on_attach, lsp)
			elseif lsp == "gopls" then
				configs.gopls_setup(capabilities, on_attach, lsp)
			elseif lsp == "yaml-language-server" then
				configs.yaml_setup(capabilities, on_attach, lsp)
			elseif lsp == "css-lsp" then
				configs.css_setup(capabilities, on_attach, lsp)
			else
				-- generic setup
				local bin_key, languages_to_ft = nil, {}
				for key, _ in pairs(lsp_spec.bin) do
					bin_key = key
					break
				end
				for _, lang in ipairs(lsp_spec.languages) do
					table.insert(languages_to_ft, string.lower(lang))
				end
				vim.lsp.config(lsp, {
					cmd = { bin_key },
					filetypes = languages_to_ft,
					capabilities = capabilities,
					on_attach = on_attach,
				})
				vim.lsp.enable(lsp)
			end
		end
	end
	require("tomeczku.core.lsp.diagnostics").setup()
end

return M
