local file = io.open("input.txt", "r")

local total = 0
for line in file:lines() do
for i,j in string.gmatch(line, "mul%((%d+),(%d+)%)") do
  total = (i*j) + total
end
end

print(total)
