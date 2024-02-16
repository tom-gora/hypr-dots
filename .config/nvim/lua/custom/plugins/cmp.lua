local M = {}

M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "js-everts/cmp-tailwind-colors", opts = {} },
  },
  opts = function(_, opts)
    table.insert(opts.sources, 1, { name = "cody" })
    opts.formatting.fields = { "kind", "abbr", "menu" }
    local format_kinds = opts.formatting.format
    local icons = require "nvchad.icons.lspkind"
    icons["Cody"] = ""
    opts.formatting.format = function(entry, item)
      if item.kind == "Color" then
        item = require("cmp-tailwind-colors").format(entry, item)
        if item.kind == "Color" then
          return format_kinds(entry, item)
        end
        return item
      end
      return format_kinds(entry, item)
    end
  end,
}

return M
