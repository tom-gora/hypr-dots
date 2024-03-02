local M = {}

M.opts = {
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  window = { border = "rounded" },
  layout = {
    height = { min = 3, max = 25 },
    width = { min = 20, max = 30 },
    spacing = 3,
    align = "center",
  },
  icons = {
    separator = "",
    group = "»  ",
  },
}

M.config_function = function(_, opts)
  dofile(vim.g.base46_cache .. "whichkey")
  require("which-key").setup(opts)
  require("core.utils").load_mappings "whichkey"
  local present, wk = pcall(require, "which-key")
  if not present then
    return
  end
  wk.register {
    -- add groups
    ["<leader>"] = {
      q = { name = " Close" },
      f = { name = " Find" },
      y = { name = " Yanking" },
      r = { name = "󰛔 Search and replace" },
      rb = { name = "󰛔 Multi BUFFER replacements" },
      t = { name = " Terminal" },
      c = { name = " Code" },
      cl = { name = " LSP" },
      h = { name = "󰋖 Help" },
      n = { name = " NeoVim" },
      -- and hack on top of a hack to dasdmake the entry appear in whichkey
      v = { name = "󱒎 Splits", p = "which_key_ignore" },
      g = { name = " Go!" },
      s = { name = " Sourcegraph" },
    },
  }
end

return M
