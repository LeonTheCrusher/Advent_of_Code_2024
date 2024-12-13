local function pprint(tbl, indent)
    indent = indent or 0
    local formatting = string.rep("  ", indent)

    if type(tbl) ~= "table" then
        print(formatting .. tostring(tbl))
        return
    end

    print(formatting .. "{")
    for key, value in pairs(tbl) do
        local keyStr = type(key) == "string" and ('"' .. key .. '"') or tostring(key)
        local valueType = type(value)

        if valueType == "table" then
            io.write(formatting .. "  " .. keyStr .. " = ")
            pprint(value, indent + 1)
        elseif valueType == "string" then
            print(formatting .. "  " .. keyStr .. " = " .. '"' .. value .. '"')
        else
            print(formatting .. "  " .. keyStr .. " = " .. tostring(value))
        end
    end
    print(formatting .. "}")
end

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

local function map_keys(file)
  local x = 1
  for line in file:lines() do
    for key, value in string.gmatch(line, "(%d+)%|(%d+)") do
      KEYS[x] = { tonumber(key), tonumber(value) }
      x = x + 1
    end


    for item in string.gmatch(line, "%d+,[%d,]*") do
      local page_list = {}
      for num in string.gmatch(item, "%d+") do
        table.insert(page_list, tonumber(num))
      end
      table.insert(PAGES, page_list)
    end

  end
end

local function check_validity()
  for _, page_list in ipairs(PAGES) do
    local list_is_valid = true
    for page_index, page in ipairs(page_list) do
      if list_is_valid then
        if page_index ~= 1 then
          for i = 1, #KEYS do
            if page == KEYS[i][1] then
              for j = 1, page_index - 1 do
                if page_list[j] == KEYS[i][2] then
                  table.insert(INVALID_LIST, page_list)
                  list_is_valid = false
                  break
                end
              end
            end
          end
        end
      end
    end

    if list_is_valid then
      table.insert(VALID_LIST, page_list)
    end
  end
end

local function solution(list)
  local total = 0
  for _, page_list in ipairs(list) do
    local middle = math.ceil(#page_list / 2)
    total = total + page_list[middle]
  end
  return total
end


local function sort_invalid()
  for list_number = 1, #INVALID_LIST do
  local list_to_check = INVALID_LIST[list_number]
  -- pprint(list_to_check)
  for _ = 1, #list_to_check, 1 do
  for page_index, page in ipairs(list_to_check) do
    if page_index ~= 1 then
      for i = 1, #KEYS do
        if page == KEYS[i][1] then
          for j = 1, page_index - 1 do
            if list_to_check[j] == KEYS[i][2] then
              list_to_check[j], list_to_check[page_index] = list_to_check[page_index], list_to_check[j]
              break
            end
          end
        end
      end
    end
  end
end
  -- pprint(list_to_check)
  end
end


KEYS = {}
PAGES = {}
VALID_LIST = {}
INVALID_LIST = {}

local function main(file_name)
  local file = open_file(file_name)
  if not file then
    print("Failed to process file.")
    return
  end

  map_keys(file)

  check_validity()
  sort_invalid()

  print("Solution One: ", solution(VALID_LIST))
  print("Solution Two: ", solution(INVALID_LIST))
  close_file(file)
end

if #arg < 1 then
  print("Usage: lua " .. arg[0] .. " <file_name>")
else
  main(arg[1])
end
