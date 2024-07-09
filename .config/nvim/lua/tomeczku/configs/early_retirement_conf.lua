local M = {}

M.opts = {
  -- If a buffer has been inactive for this many minutes, close it.
  retirementAgeMins = 5,

  -- Filetypes to ignore.
  -- ignoredFiletypes = {},

  -- Ignore files matching this lua pattern; empty string disables this setting.
  -- ignoreFilenamePattern = "",

  -- Ignore visible buffers. Buffers that are open in a window or in a tab
  -- are considered visible by vim. ("a" in `:buffers`)
  ignoreVisibleBufs = false,

  -- ignore unloaded buffers. Session-management plugin often add buffers
  -- to the buffer list without loading them.
  ignoreUnloadedBufs = true,

  -- Show notification on closing. Works with plugins like nvim-notify.
  notificationOnAutoClose = true,

  -- When a file is deleted, for example via an external program, delete the
  -- associated buffer as well. Requires Neovim >= 0.10.
  -- (This feature is independent from the automatic closing)
  deleteBufferWhenFileDeleted = true,
}

return M
