local function open_file(file_name)
  if type(file_name) ~= "string" or file_name == "" then
    print("Error: Invalid file name.")
    return nil
  end

  local file, err = io.open(file_name, "r")
  if not file then
    print("Error: File not found. " .. (err or ""))
    return nil
  end

  return file
end

local function close_file(file)
  if file then
    file:close()
  end
end

local function make_grid(file)
  local grid = {}
  for line in file:lines() do
    local line_array = {}
    for c in string.gmatch(line, ".") do
      table.insert(line_array, c)
    end
    table.insert(grid, line_array)
  end
  return grid
end

local function solution_one(grid)
  local exit_loop = false
  while not exit_loop do
    for i = 1, #grid do
      for j = 1, #grid[i] do
        if string.match(grid[i][j], "[<>^v]") then
          if grid[i][j] == "^" then
            if i - 1 >= 1 and grid[i - 1][j] ~= "#" then
              grid[i][j] = "X"
              grid[i - 1][j] = "^"
            elseif i - 1 < 1 then
              grid[i][j] = "X"
              exit_loop = true
            else
              grid[i][j] = ">"
            end
          elseif grid[i][j] == ">" then
            if j + 1 <= #grid[i] and grid[i][j + 1] ~= "#" then
              grid[i][j] = "X"
              grid[i][j + 1] = ">"
            elseif j + 1 > #grid[i] then
              grid[i][j] = "X"
              exit_loop = true
            else
              grid[i][j] = "v"
            end
          elseif grid[i][j] == "v" then
            if i + 1 <= #grid and grid[i + 1][j] ~= "#" then
              grid[i][j] = "X"
              grid[i + 1][j] = "v"
            elseif i + 1 > #grid then
              grid[i][j] = "X"
              exit_loop = true
            else
              grid[i][j] = "<"
            end
          elseif grid[i][j] == "<" then
            if j - 1 >= 1 and grid[i][j - 1] ~= "#" then
              grid[i][j] = "X"
              grid[i][j - 1] = "<"
            elseif j - 1 < 1 then
              grid[i][j] = "X"
              exit_loop = true
            else
              grid[i][j] = "^"
            end
          end
        end
      end
    end
  end

  local count = 0
  for i = 1, #grid do
    for j = 1, #grid[i] do
      if grid[i][j] == "X" then
        count = count + 1
      end
    end
  end
  return count
end

local function main(file_name)
  local file = open_file(file_name)
  if not file then
    print("Failed to process the file.")
    return
  end

  local grid = make_grid(file)
  close_file(file)

  print("Solution One: ", solution_one(grid))
end

if #arg < 1 then
  print("Usage: lua " .. arg[0] .. " <file_name>")
else
  main(arg[1])
end

