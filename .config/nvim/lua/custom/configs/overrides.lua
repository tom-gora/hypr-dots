local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "vimdoc",
    "query",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "bash",
    "c_sharp",
    "json",
    "java",
    "php",
    "sql",
    "toml",
    "xml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = true,
  },
  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-CR>",
      node_incremental = "<C-CR>",
      -- scope_incremental = "<S-Space>",
      node_decrementl = "<C-bs>",
    },
  },
}

M.mason = {
  ui = {
    border = "rounded",
    height = 0.8,
    width = 0.7,
  },
  automatic_installation = true,
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "luacheck",

    -- web dev stuff
    "emmet-ls",
    "css-lsp",
    "html-lsp",
    "jsonls",
    "typescript-language-server",
    "prettierd",
    "htmlhint",
    "stylelint",
    "tailwindcss-language-server",
    "intelephense",
    "stimulus-language-server",

    --shell
    "bash-language-server",
    "shfmt",

    -- OTHER
    -- poor mans java ls
    "jdtls",
    -- c#
    -- "csharp-language-server", -- damn wont do, schoo requires older .net
    "omnisharp",
    "csharpier",
  },
}

return M
