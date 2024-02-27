local M = {}

M.opts = {
  windows = {
    max_number = 2,
    preview = true,
  },
  mappings = {
    close = "q",
    go_in = "l",
    go_in_plus = "L",
    go_out = "h",
    go_out_plus = "H",
    reset = "<Esc>",
    reveal_cwd = "",
    show_help = "g?",
    synchronize = "<Cr>",
    trim_left = "",
    trim_right = "",
  },
  options = {
    use_as_default_explorer = false,
  },
}

M.config_function = function(_, opts)
  require("mini.files").setup(opts)
  -- Add rounded corners.
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
      local win_id = args.data.win_id
      vim.api.nvim_win_set_config(win_id, { border = "rounded" })
    end,
  })

  -- src = https://github.com/Allaman/nvim
  local filter_show = function()
    return true
  end
  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
  end
  ---@diagnostic disable-next-line: lowercase-global
  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh { content = { filter = new_filter } }
  end
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak left-hand side of mapping to your liking
      vim.keymap.set("n", "H", toggle_dotfiles, {
        desc = "Toggle hidden files",
        buffer = buf_id,
      })
    end,
  })

  vim.keymap.set(
    "n",
    "<leader>e",
    "<Cmd>lua MiniFiles.open()<CR>",
    { nowait = true, silent = true, desc = " File explorer" }
  )
end

return M
