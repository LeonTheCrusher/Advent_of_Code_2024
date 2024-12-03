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

local function parse_line(line)
 local list = {}
  for number in line:gmatch("%S+") do
    table.insert(list, number)
  end
  return list
end

local function solution_one(list)
  local num_safe = 0
  for i = 1, #list do
    local increasing = true
    local decreasing = true

    for j = 1, #list[i] - 1 do
      if tonumber(list[i][j]) == tonumber(list[i][j+1]) then
        decreasing = false
        increasing = false
      elseif tonumber(list[i][j]) <= tonumber(list[i][j+1]) then
        decreasing = false
      elseif tonumber(list[i][j]) >= tonumber(list[i][j+1]) then
        increasing = false
      end
    end

    local safe = true

    if increasing == true then
      for j = 1, #list[i] - 1 do
        if tonumber(list[i][j] + 3) < tonumber(list[i][j+1]) then
          safe = false
          break
        end
      end
    elseif decreasing == true then
      for j = 1, #list[i] - 1 do
        if tonumber(list[i][j] - 3) > tonumber(list[i][j+1]) then
          safe = false
          break
        end
      end
    else
      safe = false
    end
    if safe == true then
      num_safe = num_safe + 1
    else
    end
  end
  return(num_safe)
end

local function solution_two(list)
  for i = 1, #list do
    for j = 1, #list[i] - 1 do
      local new_list = {}
      for k = 1, #list[i] do
        if j-1 ~= k then
          table.insert(new_list, list[i][k])
        end
      end
      -- print(table.concat(new_list), i, j)
      local decreasing = true
      local increasing = true
      for k = 1, #new_list do
        print(new_list[k])
      end

    end
  end
end

local function main(file_name)
  local file = open_file(file_name)
  if not file then
    print("Failed to process file.")
    return
  end

  local list = {}
  for line in file:lines() do
    local short_list = parse_line(line)
    table.insert(list, short_list)
  end

  -- print("Solution One: ", solution_one(list))
  -- print("Solution Two: ", solution_two(list))
  solution_two(list)

  close_file(file)
end

if #arg < 1 then
  print("Usage: lua " .. arg[0] .. " <file_name>")
else
  main(arg[1])
end
