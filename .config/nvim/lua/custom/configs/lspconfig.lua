-- src: !!!   https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- local on_attach = require("plugins.configs.lspconfig").on_attach
local utils = require "core.utils"
local capabilities = require("plugins.configs.lspconfig").capabilities

-- slightly alter my own on_attach()
local on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  -- set my own keybinds
  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap
  opts.desc = "Show LSP references"
  keymap.set("n", "<leader>clr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

  opts.desc = "Go to declaration"
  keymap.set("n", "gd", vim.lsp.buf.declaration, opts) -- go to declaration

  opts.desc = "Show LSP definitions"
  keymap.set("n", "<leader>cld", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

  opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

  opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts) -- show diagnostics for line

  opts.desc = "Go to previous diagnostic"
  keymap.set("n", "<leader>cj", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "<leader>ck", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

  opts.desc = "Restart LSP"
  keymap.set("n", "<leader>clR", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if
    not utils.load_config().ui.lsp_semantic_tokens
    and client.supports_method "textDocument/semanticTokens"
  then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "bashls",
  "clangd",
  -- "csharp_ls",
  "cssls",
  "intelephense",
  "jdtls",
  -- "omnisharp",
  "stimulus_ls",
  "tsserver",
  "tailwindcss",
}

-- modify signs icons
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- loop over default server configs
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

------------------------------------------------------------[ custom configs ]

-- -- configure lua server (with special settings)
lspconfig["lua_ls"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}

-- configure html server
lspconfig["html"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    configurationSection = { "html", "css", "javascript", "php" },
    embeddedLanguages = {
      css = true,
      javascript = true,
      php = true,
    },
    provideFormatter = true,
  },
}

-- configure emmet language server
lspconfig["emmet_ls"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "css",
    "sass",
    "scss",
    "less",
    "svelte",
  },
}

-- omnisharp
lspconfig["omnisharp"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "dotnet",
    "/home/tomeczku/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll",
  },
  enable_editorconfig_support = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  filetypes = { "cs", "vb" },
}

-- -- local cmp_nvim_lsp = require "cmp_nvim_lsp"
-- -- used to enable autocompletion (assign to every lsp server config)
-- -- local capabilities = cmp_nvim_lsp.default_capabilities()

--set hover border to rounded and max width to 80
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", max_width = 80 })
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--   vim.lsp.handlers.signature_help,
--   { border = "rounded", max_width = 80 }
-- )
--
-- -- if you just want default config for the servers then put them in a table
-- -- local servers = { "html", "cssls", "tsserver", "clangd" }
-- --
-- -- for _, lsp in ipairs(servers) do
-- --   lspconfig[lsp].setup {
-- --     on_attach = on_attach,
-- --     capabilities = capabilities,
-- --   }
-- -- end
--
-- -- lspconfig.pyright.setup { blabla}
--
