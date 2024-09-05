local function copyAfterLastBackslash(s)
	local index = s:find("[\\/]([^\\/]*)$")
	if index then
		return s:sub(index + 1)
	else
		return nil
	end
end

local function traverse_directory(directory, findMe)
	local popen = io.popen('dir /b /s /a:-D "' .. directory .. '"')
	for filepath in popen:lines() do
		local name = copyAfterLastBackslash(filepath)
		if name == findMe then
			local dest = string.gsub(filepath, "otservbr%-global", "geroni")
			os.execute("xcopy /s /Y " .. filepath .. " " .. dest)
			return
		end
	end
end
local baseDataDirectory = "data-otservbr-global"

local missingFiles = {
	"bane_of_light.lua",
}
for _, monsterName in pairs(missingFiles) do
	traverse_directory(baseDataDirectory, monsterName)
end
