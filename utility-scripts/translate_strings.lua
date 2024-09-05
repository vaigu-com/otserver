local map = dofile("C:/developer/servek-canary/data-geroni/strings/lua_raids_strings_pl.lua")
local file = io.open("C:/developer/servek-canary/data-geroni/luaraids.lua", "r")
local content = file:read("*a")
file:close()
for english, polish in pairs(map) do
    content = string.gsub(content, polish, english)
end
file = io.open("C:/developer/servek-canary/data-geroni/luaraids.lua", "w")
file:write(content)
file:close()