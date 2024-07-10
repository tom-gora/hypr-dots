local M = {}

M.config_fuction = function()
  -- additionally configure lspinfo win border
  require("lspconfig.ui.windows").default_options.border = "rounded"

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  local lspconfig = require("lspconfig")
  local mason_conf = require("tomeczku.configs.mason_conf")
  local lsps = mason_conf.mason_lspconfig.ensure_installed
  for _, lsp in ipairs(lsps) do
    lspconfig[lsp].setup({ capabilities = capabilities })
    -- lspconfig[lsp].setup()
  end
  -- hide annoying messages about globals from lua_ls
  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })

  -- make bashls attach to additional filetypes
  lspconfig.bashls.setup({
    filetypes = { "sh", "zsh" },
  })
  -- make tsserver attach to additional filetypes
  lspconfig.tsserver.setup({
    filetypes = { "astro" },
  })

  -- setup hyprls
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { "*.hl", "hypr*.conf" },
    callback = function()
      -- print(string.format("starting hyprls for %s", vim.inspect(event)))
      vim.lsp.start {
        name = "hyprlang",
        cmd = { "hyprls" },
        root_dir = vim.fn.getcwd(),
      }
    end
  })
  --pass path to typescript for astro to work
  lspconfig.astro.setup({
    init_options = {
      typescript = {
        tsdk = vim.fs.normalize("/usr/local/lib/node_modules/typescript/lib")
      }
    },
  })
end

return M
