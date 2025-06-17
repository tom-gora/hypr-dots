local M = {}

local uv = vim.uv
local api = vim.api

-- Internal state
local current_count_str = ""
local capture_timer = nil
local capture_callback = nil -- Function to call when count is captured/timed out

-- Function called by the temporary keymaps for digits
-- This function is exposed globally for keymap `expr` evaluation
function M._handle_digit_keypress(digit_char)
  -- Append the digit
  current_count_str = current_count_str .. digit_char

  -- Reset the timer
  if capture_timer then
    capture_timer:stop()
    capture_timer:start(M.timeout_ms, 0, function()
      M.finish_capture("timeout")
    end)
  end

  -- Return empty string to "eat" the keypress
  return ""
end

-- Internal handler for backspace
-- This function is exposed globally for keymap `expr` evaluation
function M._handle_backspace()
  current_count_str = string.sub(current_count_str, 1, -2) -- Remove last char
  -- Reset timer as well
  if capture_timer then
    capture_timer:stop()
    capture_timer:start(M.timeout_ms, 0, function()
      M.finish_capture("timeout")
    end)
  end
  return "" -- Eat the backspace
end

-- Function to set up temporary keymaps for digits
local function setup_digit_keymaps()
  -- Map '0' through '9'
  for i = 0, 9 do
    local digit = tostring(i)
    api.nvim_set_keymap("n", digit,
      string.format("v:lua.require('tomeczku.utils.count_capture')._handle_digit_keypress('%s')", digit),
      { noremap = true, silent = true, expr = true, buffer = 0, nowait = true, desc = "Capture count digit" }
    )
  end
  -- Map <BS> to allow backspace correction
  api.nvim_set_keymap("n", "<BS>",
    "v:lua.require('tomeczku.utils.count_capture')._handle_backspace()",
    { noremap = true, silent = true, expr = true, buffer = 0, nowait = true, desc = "Backspace count digit" }
  )
  -- Map <Esc> and <CR> to explicitly finish the count
  api.nvim_set_keymap("n", "<Esc>",
    "v:lua.require('tomeczku.utils.count_capture')._finish_capture_explicit('escape')",
    { noremap = true, silent = true, expr = true, buffer = 0, nowait = true, desc = "Finish count capture (Esc)" }
  )
  api.nvim_set_keymap("n", "<CR>",
    "v:lua.require('tomeczku.utils.count_capture')._finish_capture_explicit('enter')",
    { noremap = true, silent = true, expr = true, buffer = 0, nowait = true, desc = "Finish count capture (Enter)" }
  )
end

-- Function to clear temporary keymaps
local function clear_digit_keymaps()
  for i = 0, 9 do
    api.nvim_del_keymap("n", tostring(i), { buffer = 0 })
  end
  api.nvim_del_keymap("n", "<BS>", { buffer = 0 })
  api.nvim_del_keymap("n", "<Esc>", { buffer = 0 })
  api.nvim_del_keymap("n", "<CR>", { buffer = 0 })
end

-- Public function to start capturing a count
-- `callback` will be called with (count_number, reason)
M.start_capture = function(callback)
  if capture_timer then
    -- Already capturing, or timer not properly cleaned up from a previous run
    M.finish_capture("interrupted_by_new_capture")
  end

  current_count_str = ""
  capture_callback = callback

  -- Set up the timer
  capture_timer = uv.new_timer()
  capture_timer:start(M.timeout_ms, 0, function()
    M.finish_capture("timeout")
  end)

  -- Set up the temporary keymaps
  setup_digit_keymaps()

  vim.notify("Capturing count... (Timeout in " .. M.timeout_ms .. "ms)", vim.log.levels.INFO, { title = "Count Capture" })
end

-- Public function to finish capturing (called internally or externally)
M.finish_capture = function(reason)
  local count = tonumber(current_count_str) or 1 -- Default to 1 if no digits or invalid
  local cb = capture_callback

  -- Cleanup
  clear_digit_keymaps()
  if capture_timer then
    capture_timer:stop()
    uv.close(capture_timer, function()
      capture_timer = nil
    end)
  end
  current_count_str = ""
  capture_callback = nil

  -- Execute the callback
  if cb then
    cb(count, reason)
  end
end

-- Internal helper for explicit finish via keymap (e.g., <Esc>, <CR>)
-- This is needed because `expr = true` keymaps expect a return value.
function M._finish_capture_explicit(reason)
  M.finish_capture(reason)
  return "" -- Eat the keypress
end

-- Configuration
M.timeout_ms = 1000 -- Default timeout: 1 second

return M
