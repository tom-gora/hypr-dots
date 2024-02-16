-- my wrappers for commands:

-- flow enhancement for cody task
function CodyTaskFlow()
  -- get input before the task
  local input = vim.fn.input " Task Cody > "
  vim.cmd("CodyTask " .. input)
end

-- flow enhancement for cody ask
function CodyAskFlow()
  -- set up state to track if user cancels or accepts
  local canceled = false
  local accepted = false

  -- prompt for selection
  print "Adjust selection and press ESC to cancel or Return to accept"

  -- enter visual lines
  vim.cmd "normal! V"
  vim.cmd "redraw"

  while not canceled and not accepted do
    -- loop to do the selection allowing enter, esc or v-block up and down
    local char = vim.fn.getchar()
    if char == 27 then -- escape
      canceled = true
    elseif char == 13 then -- return
      accepted = true
    elseif char == 106 then -- j
      vim.cmd "normal! j"
      vim.cmd "redraw"
    elseif char == 107 then -- k
      vim.cmd "normal! k"
      vim.cmd "redraw"
    end
  end

  -- return from func, exit visual and say bye if canceled
  if canceled then
    local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    vim.notify("Cody out!", vim.log.levels.INFO, nil)
    return

    -- else go on
  else
    -- HACK: exit visual first to get selection to marks
    local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    -- prompt for question
    local question = vim.fn.input " Ask Cody > "
    --call Cody
    vim.cmd("'<,'>CodyAsk " .. question)
  end
end

function SnipRunFlowSnippet()
  -- set up state to track if user cancels or accepts
  local canceled = false
  local accepted = false

  -- prompt for selection
  print "Select code to run and press ESC to cancel or Return to execute"

  -- enter visual lines
  vim.cmd "normal! V"
  vim.cmd "redraw"

  while not canceled and not accepted do
    -- loop to do the selection allowing enter, esc or v-block up and down
    local char = vim.fn.getchar()
    if char == 27 then -- escape
      canceled = true
    elseif char == 13 then -- return
      accepted = true
    elseif char == 106 then -- j
      vim.cmd "normal! j"
      vim.cmd "redraw"
    elseif char == 107 then -- k
      vim.cmd "normal! k"
      vim.cmd "redraw"
    end
  end

  if accepted then
    -- HACK: exit visual first to get selection to marks
    local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    -- run the snippet
    vim.cmd ":'<,'>SnipRun"
  end

  -- exit visual and confirm cancellation
  if canceled then
    local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "x", false)
    vim.notify("Operation canceled", vim.log.levels.INFO, nil)
    return
  end
end

function SnipRunFlowFile()
  vim.cmd "normal! ggVG$"
  local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  vim.cmd ":'<,'>SnipRun"
end
