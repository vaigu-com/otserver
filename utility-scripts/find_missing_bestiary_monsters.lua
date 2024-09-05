local baseDirectory = "data-geroni"
local uptodateDirectory = "data-otservbr-global"
local folder = "/monster/"


local function copyAfterLastBackslash(s)
	local index = s:find("[\\/]([^\\/]*)$")
	if index then
		return s:sub(index + 1)
	else
		return nil
	end
end

local function traverse_directory(directory)
    directory = directory .. folder
    local files = {}
    local pipe = io.popen('dir /b /s /a:-D "' .. directory .. '"')
    for file in pipe:lines() do
        if not file:match("%.lua$") then
            goto continue   
        end
        
        local file_handle = io.open(file,"r")
        local file_content = file_handle:read("*a")
        file_handle:close()
        if not file_content:find("Bestiary") then
            goto continue
        end
        
        file = copyAfterLastBackslash(file)
        file = string.gsub(file, "_", " ")

        files[file] =file
        ::continue::
    end
    pipe:close()
    return files
end


local baseFileNames = traverse_directory(baseDirectory)
local uptodateNames = traverse_directory(uptodateDirectory)

for key, value in ipairs(uptodateNames) do
    if not baseFileNames[key] then
        print(key)
    end
end


