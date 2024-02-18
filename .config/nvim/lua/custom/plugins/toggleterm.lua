local M = {}

M = {
  "akinsho/toggleterm.nvim",
  lazy = false,
  version = "*",
  opts = {
    open_mapping = [[<S-CR>]],
    direction = "horizontal",
    persist_mode = false,
    auto_scroll = true,
    start_in_insert = true,
    size = function(term)
      if term.direction == "horizontal" then
        return 12
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.25
      end
    end,
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * 0.45)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.86)
      end,
      col = function()
        local w = math.floor(vim.o.columns * 0.45)
        return vim.o.columns - (w + math.floor(vim.o.columns / 15))
      end,
      row = function()
        return 1
      end,
      zindex = 10,
      title_pos = "center",
    },
    winbar = {
      enabled = true,
      name_formatter = function(term)
        local t_name = term.name
        local shell = string.upper(t_name:match "/bin/(.-);")
        local t_number = t_name:match "#toggleterm#(%d+)"
        local formatted_name =
          string.format(" %s 󰶻 term#%s", shell, t_number)
        return formatted_name
      end,
    },
    shade_terminals = false,
    highlights = {
      Normal = {
        guibg = "#121019",
      },
      NormalFloat = {
        guibg = "#121019",
      },
      FloatBorder = {
        guifg = "#8bbec7",
      },
    },
  },
  config = function(_, opts)
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

    -- functions to call them
    function _NODE_toggle()
      node_term:toggle()
    end

    function _LG_toggle()
      lazygit_term:toggle()
    end

    function _BTOP_toggle()
      btop_term:toggle()
    end

    function _DOTNET_RUNNER_toggle()
      dotnet_run_term:toggle()
    end

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

    vim.api.nvim_set_keymap(
      "n",
      "<leader>td",
      "<cmd>lua _DOTNET_RUNNER_toggle()<CR>",
      {
        noremap = true,
        silent = true,
        desc = "Toggle basic DOTNET runner terminal",
      }
    )
  end,
}

return M
