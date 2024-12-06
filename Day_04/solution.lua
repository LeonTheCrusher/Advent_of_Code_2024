local function open_file(file_name)
  if type(file_name) ~= "string" or file_name == "" then
    print("Invalid file name.")
    return nil
  end

  local file = io.open(file_name, "r")
  if not file then
    print("File not found.")
    return nil
  end

  return file
end

local function close_file(file)
  if file then
    file:close()
  else
    return nil
  end
end

local function parse_text(file)
  local text_array = {}
  for line in file:lines() do
    local line_array ={}
    for c in string.gmatch(line, ".") do
      table.insert(line_array, c)
    end
    table.insert(text_array, line_array)
  end

  return text_array
end

function find_x(text)
  for i = 1, #text do
    for j = 1, #text[i] do
      if text[i][j] == 'X' then
        table.insert(X_Positions, {i, j})
      end
    end
  end
end

local function find_xmas(pos_x, pos_y, grid)
  local directions = {"right","left","down","up"}
  for _, direction in ipairs(directions) do
    local line_string = {}
     if direction == "right" then
      for i = 0, 3 do
        if pos_y + i <= #grid[pos_x] then -- Ensure within bounds
          table.insert(line_string, grid[pos_x][pos_y + i])
        end
      end
    elseif direction == "left" then
      for i = 0, 3 do
        if pos_y - i > 0 then -- Ensure within bounds
          table.insert(line_string, grid[pos_x][pos_y - i])
        end
      end
    elseif direction == "down" then
      for i = 0, 3 do
        if pos_x + i <= #grid then -- Ensure within bounds
          table.insert(line_string, grid[pos_x + i][pos_y])
        end
      end
    elseif direction == "up" then
      for i = 0, 3 do
        if pos_x - i > 0 then -- Ensure within bounds
          table.insert(line_string, grid[pos_x - i][pos_y])
        end
      end
    elseif direction == "UR" then
    elseif direction == "UL" then
    elseif direction == "DR" then
    elseif direction == "DL" then
    end
     if table.concat(line_string) == "XMAS" then
       print(table.concat(line_string))
     end
    end
  end

X_Positions = {}

local function main(file_name)
  local file = open_file(file_name)
  if not file then
    print("Failed to process file.")
    return
  end

  local text_grid = parse_text(file)

  find_x(text_grid)

  -- for i = 1, #X_Positions do
  --   for j = 1, #X_Positions[i] do
  --     print(X_Positions[i][j])
  --   end
  -- end

  

  for _, pos in ipairs(X_Positions) do
      find_xmas(pos[1], pos[2], text_grid)
  end

  close_file(file)
end

if #arg < 1 then
  print("Usage: lua " .. arg[0] .. " <file_name>")
else
  main(arg[1])
end

