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

local function solution_one(contents)
  local total = 0
  for line in contents:gmatch("[^\r\n]+") do
    for i, j in string.gmatch(line, "mul%((%d+),(%d+)%)") do
      total = total + (i * j)
    end
  end
  return total
end

local function solution_two(modified_contents)
  local total = 0
  for match in modified_contents:gmatch("do%(%)(.-)don't%(%)") do
    for i, j in string.gmatch(match, "mul%((%d+),(%d+)%)") do
      total = total + (i * j)
    end
  end
  return total
end

local function main(file_name)
  local file = open_file(file_name)
  if not file then
    print("Failed to process file.")
    return
  end

  local contents = file:read("*all")
  close_file(file)

  print("Solution One: ", solution_one(contents))

  local modified_contents = "do()" .. contents .. "don't()"
  print("Solution Two: ", solution_two(modified_contents))
end

if #arg < 1 then
  print("Usage: lua " .. arg[0] .. " <file_name>")
else
  main(arg[1])
end
