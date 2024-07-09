local M = {}

M.config_fuction = function()
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
  lspconfig.bashls.setup({
    filetypes = { "sh", "zsh" },
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
end

return M
