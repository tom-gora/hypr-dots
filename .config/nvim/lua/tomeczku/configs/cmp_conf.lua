-- tailwind configs that work found here:
-- https://github.com/Wansmer/nvim-config/blob/4d7fa6c02474f38755202e679cb7e398b5e96e44/lua/config/plugins/cmp.lua#L121
--
local M = {}

M.dependencies = {
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  "saadparwaiz1/cmp_luasnip",     -- for autocompletion
  "rafamadriz/friendly-snippets", -- useful snippets
  "onsails/lspkind.nvim",         -- vs-code like pictograms
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("tailwind-tools").setup({
        document_color = {
          enabled = true, -- can be toggled by commands
          kind = "inline", -- "inline" | "foreground" | "background"
          inline_symbol = " ", -- only used in inline mode
          debounce = 200, -- in milliseconds, only applied in insert mode
        },
        conceal = {
          enabled = true, -- can be toggled by commands
          min_length = nil, -- only conceal classes exceeding the provided length
          symbol = "󱏿", -- only a single character is allowed
          highlight = { -- extmark highlight options, see :h 'highlight'
            fg = "#239acb",
          },
        },
      })
    end,
  },
}

M.config_function = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  local icons = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Color = " ",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
    Supermaven = "",
  }

  local opts = {
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    completion = {
      completeopt = "menu,menuone,preview,noselect",
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-h>"] = cmp.mapping.abort(),        -- close completion window
      ["<C-l>"] = cmp.mapping.confirm({ select = false }),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "supermaven" },
      { name = "lua_ls" },
      { name = "luasnip" }, -- snippets
      { name = "buffer" },  -- text within current buffer
      { name = "path" },    -- file system paths
      { name = "nvim_lua" },
    }),

    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local tt_ok, tt = pcall(require, "tailwind-tools.cmp")
        if tt_ok then
          -- colorize tailwind classes
          vim_item = tt.lspkind_format(entry, vim_item)
        end
        vim_item.kind = string.format("%s", icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "│lsp ",
          supermaven = "│ai",
          luasnip = "│snip",
          buffer = "│buff",
          path = "│path",
          cmdline = "│cmd ",
          cmdline_history = "│hist ",
          nvim_lsp_document_symbol = "│sym ",
          rg = "│rg  ",
          ["html-css"] = "│css ",
        })[entry.source.name]
        return vim_item
      end,
    },
  }

  lspkind.init({
    symbol_map = {
      Supermaven = "",
    }
  })
  require("luasnip.loaders.from_vscode").lazy_load()
  cmp.setup(opts)
end

return M
