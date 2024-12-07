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

local function find_x(text)
  for i = 1, #text do
    for j = 1, #text[i] do
      if text[i][j] == 'X' then
        table.insert(X_Positions, {i, j})
      end
    end
  end
end

local function solution_one(pos_x, pos_y, grid)
  local count = 0
  local directions = {"right","left","down","up","ur","ul","dr","dl"}
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
    elseif direction == "dr" then
      for i = 0, 3 do
        if pos_x + i <= #grid and pos_y + i <= #grid[pos_x] then
          table.insert(line_string, grid[pos_x + i][pos_y + i])
        end
      end
    elseif direction == "ur" then
      for i = 0, 3 do
        if pos_x - i > 0 and pos_y + i <= #grid[pos_x] then
          table.insert(line_string, grid[pos_x - i][pos_y + i])
        end
      end
    elseif direction == "ul" then
      for i = 0, 3 do
        if pos_x - i > 0 and pos_y - i > 0 then
          table.insert(line_string, grid[pos_x - i][pos_y - i])
        end
      end
    elseif direction == "dl" then
      for i = 0, 3 do
        if pos_x + i <= #grid and pos_y - i > 0 then
          table.insert(line_string, grid[pos_x + i][pos_y - i])
        end
      end
    end
    if table.concat(line_string) == "XMAS" then
      count = count + 1
    end
  end
  return count
end


local function solution_two(grid)
  local count = 0
  for x = 2, #grid - 1 do
    for y = 2, #grid[x] - 1 do
      if grid[x] and grid[x][y] == 'A' and
         grid[x-1] and grid[x-1][y-1] and
         grid[x+1] and grid[x+1][y+1] and
         grid[x+1] and grid[x+1][y-1] and
         grid[x-1] and grid[x-1][y+1] then
        local diag_one = (grid[x-1][y-1] .. grid[x][y] .. grid[x+1][y+1])
        local diag_two = (grid[x+1][y-1] .. grid[x][y] .. grid[x-1][y+1])
        if (diag_one == "MAS" or diag_one == "SAM") and (diag_two == "MAS" or diag_two == "SAM") then
          count = count + 1
        end
      end
    end
  end
  return count
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
  local sol_one_final_tally = 0
  for _, pos in ipairs(X_Positions) do
      sol_one_final_tally = sol_one_final_tally + solution_one(pos[1], pos[2], text_grid)
  end

  print("Solution One: ", sol_one_final_tally)
  print("Solution Two", solution_two(text_grid))

  close_file(file)
end

if #arg < 1 then
  print("Usage: lua " .. arg[0] .. " <file_name>")
else
  main(arg[1])
end

