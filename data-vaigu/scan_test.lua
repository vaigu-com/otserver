function readAll(file)
	local f = assert(io.open(file, "rb"))
	local content = f:read("*all")
	f:close()
	return content
end
function writeAll(file, content)
	local f = assert(io.open(file, "w+"))
	f:write(content)
	f:close()
end

--- Create a flat list of all files in a directory
-- @param directory - The directory to scan (default value = './')
-- @param recursive - Whether or not to scan subdirectories recursively (default value = true)
-- @param extensions - List of extensions to collect, if blank all will be collected
function scandir(directory, recursive, extensions)
	directory = directory or ""
	recursive = recursive or false
	-- if string.sub(directory, -1) ~= '/' then directory = directory .. '/' end
	local currentDirectory = directory
	local fileList = {}
	local command = "ls " .. currentDirectory .. " -p"
	if recursive then
		command = command .. "R"
	end

	for fileName in io.popen(command):lines() do
		if string.sub(fileName, -1) == "/" then
			-- Directory, don't do anything
		elseif string.sub(fileName, -1) == ":" then
			currentDirectory = string.sub(fileName, 1, -2) .. ""
			-- if currentDirectory ~= directory then
			currentDirectory = currentDirectory .. "/"
			-- end
		elseif string.len(fileName) == 0 then
			-- Blank line
			currentDirectory = directory
			-- elseif string.find(fileName,"%.lua$") then
			-- File is a .lua file
		else
			if type(extensions) == "table" then
				for _, extension in ipairs(extensions) do
					if string.find(fileName, "%." .. extension .. "$") then
						table.insert(fileList, currentDirectory .. fileName)
					end
				end
			else
				table.insert(fileList, currentDirectory .. fileName)
			end
		end
	end

	return fileList
end

local questNames = {
	"assassins_creed_skurwoala",
"Bezpieczenstwo_i_higiena_pracy",
"Big_klamoty",
"Czeslaw_krasnolud",
"Desert_ghosts",
"desert_quest_one",
"Desert_quest_two",
"fnaf_",
"krol_szczurow_hub",
"one_time_escorts",
"Per_iustitia_ad_astra",
"sciezka_nieumarlych",
"spoczywajacy_tutaj",
"Sprawiedliwy_wobec_narodow",
"stepIn_",
"Syn_marnotrawny",
"teatr_taniej_sensacji",
"Tragedya_w_czterech_aktach",
"Trzej_sramaci_i_smok",
"windy_",
}
for _, questName in pairs(questNames) do
	local basedir = "/home/karol/vaigu/repo/wykopots/data-vaigu/scripts/quests/_vaigu/".. questName
--wykopots/data-vaigu/scripts/quests/_vaigu/desert_quest_one/1_VOC_PUZZLE/statue_EkEd.lua
local fileNames = scandir(basedir, true)
local combinedContent = ""
for key, name in pairs(fileNames) do
	local fileContent = readAll(name)
	local match = fileContent:gmatch("BANJO_KROLA_SZCZUROW:")()
	if match ~= "" and match ~= nil then
		goto continue
	end
	print(name)
	combinedContent = combinedContent .. fileContent
	::continue::
end
writeAll("./combined" .. questName ..".lua", combinedContent)

end