local file = io.open("example.txt", "r")

for line in file:lines() do
    for item in string.gmatch(line, "%S+") do
        print(item)
    end
end
