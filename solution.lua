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

local function main(file_name)
  local file = open_file(file_name)
  if not file then
    print("Failed to process the file.")
    return
  end



  close_file(file)
end

if #arg < 1 then
  print("Usage: lua " .. arg[0] .. " <file_name>")
else
  main(arg[1])
end
