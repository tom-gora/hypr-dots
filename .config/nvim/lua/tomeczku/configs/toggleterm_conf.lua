local M = {}

M.opts = {
  open_mapping = [[<S-CR>]],
  direction = "horizontal",
  persist_mode = false,
  auto_scroll = true,
  start_in_insert = true,
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return math.floor(vim.o.columns * 0.3)
    end
  end,
  float_opts = {
    border = "curved",
    width = function()
      return math.floor(vim.o.columns * 0.45)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.92)
    end,
    col = function()
      local w = math.floor(vim.o.columns * 0.45)
      return vim.o.columns - (w + 3)
    end,
    row = function()
      return 1
    end,
    zindex = 10,
    title_pos = "center",
  },
  winbar = { enabled = false },
  shade_terminals = false,
  highlights = {
    Normal = {
      guibg = "#191724",
    },
    NormalFloat = {
      guibg = "#191724",
    },
    FloatBorder = {
      guifg = "#8bbec7",
    },
  },
}

M.config_function = function(_, opts)
  require("toggleterm").setup(opts)
  -- REGISTER MY CUSTOM TERMINALS:
  local Terminal = require("toggleterm.terminal").Terminal
  -- node terminal
  local node_term = Terminal:new { cmd = "node", direction = "float" }
  -- btop terminal
  local btop_term = Terminal:new { cmd = "btop", direction = "float" }
  --  lazygit terminal
  local lazygit_term = Terminal:new {
    cmd = "lazygit",
    direction = "float",
    float_opts = {
      -- dynamic size of specifically lazygit float term
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.86)
      end,
      col = function()
        local w = math.floor(vim.o.columns * 0.9)
        return vim.o.columns - (w + math.floor(vim.o.columns / 15))
      end,
    },
  }
  -- dotnet runner terminal
  local dotnet_run_term = Terminal:new {
    cmd = "dotnet run",
    direction = "float",
    dir = "./",
    close_on_exit = false,
  }

  local set_term_title = function(title)
    if vim.bo.filetype == "toggleterm" then
      vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(),
        {
          title = title,
          title_pos = "left",
        })
    end
  end

  -- functions to call them
  function _NODE_toggle()
    node_term:toggle()
    set_term_title("  Node ")
  end

  function _LG_toggle()
    lazygit_term:toggle()
    set_term_title(" 󰊢 LazyGit ")
  end

  function _BTOP_toggle()
    btop_term:toggle()
    set_term_title("  BTOP ")
  end

  -- function _DOTNET_RUNNER_toggle()
  --   dotnet_run_term:toggle()
  -- end

  -- navigation set as per toggleterm docs
  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  -- set keymaps for terms
  vim.api.nvim_set_keymap(
    "n",
    "<leader>tn",
    "<cmd>lua _NODE_toggle()<CR>",
    { noremap = true, silent = true, desc = "Toggle NODE terminal" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>tg",
    "<cmd>lua _LG_toggle()<CR>",
    { noremap = true, silent = true, desc = "Toggle LazyGIT terminal" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>tb",
    "<cmd>lua _BTOP_toggle()<CR>",
    { noremap = true, silent = true, desc = "Toggle BTOP terminal" }
  )

  -- vim.api.nvim_set_keymap(
  --   "n",
  --   "<leader>td",
  --   "<cmd>lua _DOTNET_RUNNER_toggle()<CR>",
  --   {
  --     noremap = true,
  --     silent = true,
  --     desc = "Toggle basic DOTNET runner terminal",
  --   }
  -- )
end

return M
