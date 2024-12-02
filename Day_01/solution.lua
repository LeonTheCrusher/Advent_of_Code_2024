local file = io.open("input.txt", "r")
local list_a = {} -- Global variable in lowercase init
local list_b = {} -- Global variable in lowercase init

for line in file:lines() do
  local j = 1
    for i in string.gmatch(line, "%S+") do
      if j == 1 then
        table.insert(list_a, tonumber(i))
    else
        table.insert(list_b, tonumber(i))
    end
      j = j + 1
    end
end
file:close()

table.sort(list_a)
table.sort(list_b)

distance = 0

for i = 1, math.min(#list_a, #list_b) do
  -- print(list_a[i],list_b[i],distance)
    distance = math.abs(list_b[i] - list_a[i]) + distance
end

print(distance)
