local function open_file(file_name)
  local file = io.open(file_name, "r")
  if file ~= nil then
    return file
  else
    print("File not found.")
    return nil
  end
end

local function close_file(file)
  if file then
    file:close()
  else
    print("No file to close")
  end
end

local function parse_line(line)
  local list = {}
  for number in line:gmatch("%S+") do
    table.insert(list, number)
  end
  return list
end

local function solution_one(left_list, right_list)
  table.sort(left_list)
  table.sort(right_list)
  distance = 0

  for i = 1, math.min(#left_list, #right_list) do
    distance = math.abs(right_list[i] - left_list[i]) + distance
  end
  print(distance)
end

local function solution_two(left_list, right_list)
  local distance = 0
  for i = 1, #left_list do
    local line_distance = 0
    local count = 0
    for j = 1, #right_list do
      if left_list[i] == right_list[j] then
        count = count + 1
      end
    end
    line_distance = count * left_list[i]
    distance = line_distance + distance
  end
  print(distance)
end

local function main(file_name)
  local file = open_file(file_name)
  local left_list = {}
  local right_list = {}
  if file ~= nil then
    for line in file:lines() do
      local list = parse_line(line)
      table.insert(left_list, list[1])
      table.insert(right_list, list[2])
    end
  else
    print("Error opening file")
  end

  solution_one(left_list, right_list)
  solution_two(left_list, right_list)
  close_file(file)
end

if #arg == 1 then
  main(arg[1])
else
  print("Not enough arguments")
end
