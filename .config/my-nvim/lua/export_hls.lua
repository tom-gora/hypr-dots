local function get_highlight_groups()
  -- Get all highlight groups starting with "St_"
  local hl_groups = vim.fn.getcompletion("St_", "highlight")
  return hl_groups
end

local function save_highlight_groups_to_file()
  local hl_groups = get_highlight_groups()
  local results = {}

  for _, hl_group in ipairs(hl_groups) do
    local is_ok, hl_def =
      pcall(vim.api.nvim_get_hl, 0, { name = hl_group, link = false })
    if is_ok and hl_def then
      table.insert(results, hl_group .. " = " .. vim.inspect(hl_def))
    else
      table.insert(results, hl_group .. " = [Error retrieving highlight group]")
    end
  end

  -- Open file for writing
  local file_path = "./highlights.txt"
  local file = io.open(file_path, "w")
  for _, line in ipairs(results) do
    file:write(line .. "\n")
  end
  file:close()

  print("Highlight groups saved to " .. file_path)
end

-- To run the function immediately when loading the script
save_highlight_groups_to_file()
