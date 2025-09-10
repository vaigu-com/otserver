--FUTURE_PATCH_TODO
--add markers for training statue

local jobToMarkId = {
	[JOB_DISTANCE_SOULORB] = MAPMARK_BAG,
	[JOB_SOULORB] = MAPMARK_BAG,
	[JOB_DISTANCE] = MAPMARK_BAG,
	[JOB_ARMOR_WEAPON] = MAPMARK_SWORD,
	[JOB_MAGIC_WILDCARD] = MAPMARK_STAR,
	[JOB_MAGIC] = MAPMARK_STAR,
	[JOB_WILDCARD] = MAPMARK_STAR,
	[JOB_EXERCISE] = MAPMARK_STAR,
	[JOB_CREATURE_PRODUCT] = MAPMARK_BAG,
	[JOB_FURNITURE] = MAPMARK_TICK,
	[JOB_TASKS_IMBUING] = MAPMARK_EXCLAMATION,
	[JOB_TASKS] = MAPMARK_EXCLAMATION,
	[JOB_IMBUING] = MAPMARK_EXCLAMATION,
	[JOB_JEWELLER] = MAPMARK_KISS,
	[JOB_UTILITY] = MAPMARK_SHOVEL,
	[JOB_POST] = MAPMARK_FLAG,
	[JOB_FOOD] = MAPMARK_TICK,
	[JOB_SOFT_BOOTS_RECHARGE] = MAPMARK_TICK,
	[JOB_DAILYTASKS_GOLDENOUTFIT] = MAPMARK_TICK,
	[JOB_DAILYTASK] = MAPMARK_TICK,
	[JOB_GOLDENOUTFIT] = MAPMARK_TICK,
	[JOB_FISHER] = MAPMARK_TICK,
	[JOB_AOL] = MAPMARK_TICK,
	[JOB_BANK] = MAPMARK_DOLLAR,
	[JOB_MARRIAGE_BLESS] = MAPMARK_TEMPLE,
	[JOB_MARRIAGE] = MAPMARK_TEMPLE,
	[JOB_BLESS] = MAPMARK_TEMPLE,
}

local jobToDescription = {
	--[JOB_NONE] = nil,
	[JOB_DISTANCE_SOULORB] = "Distance shop",
	[JOB_SOULORB] = "Distance shop",
	[JOB_DISTANCE] = "Distance shop",
	[JOB_ARMOR_WEAPON] = "Smith shop",
	[JOB_MAGIC_WILDCARD] = "Magic shop",
	[JOB_MAGIC] = "Magic shop",
	[JOB_WILDCARD] = "Magic shop",
	[JOB_EXERCISE] = "Magic shop",
	[JOB_CREATURE_PRODUCT] = "Creature product vendor",
	[JOB_FURNITURE] = "Furniture",
	[JOB_TASKS_IMBUING] = "Tasks",
	[JOB_TASKS] = "Tasks",
	[JOB_IMBUING] = "Tasks",
	[JOB_JEWELLER] = "Jeweller",
	[JOB_UTILITY] = "Utility shop",
	[JOB_POST] = "Post Office",
	[JOB_FOOD] = "Food shop",
	[JOB_SOFT_BOOTS_RECHARGE] = "Soft Boots Recharge",
	[JOB_DAILYTASKS_GOLDENOUTFIT] = "Ruler",
	[JOB_DAILYTASK] = "Ruler",
	[JOB_GOLDENOUTFIT] = "Ruler",
	[JOB_FISHER] = "Fisher",
	[JOB_AOL] = "Aol",
	[JOB_BANK] = "Bank",
	[JOB_MARRIAGE_BLESS] = "Temple",
	[JOB_MARRIAGE] = "Temple",
	[JOB_BLESS] = "Temple",
}

local npcToMarkIcon = {}
local npcToMarkDescription = {}

local function findJob(npcDefinition)
	local _, job = next(npcDefinition.jobs or {}, nil)
	job = job or npcDefinition.greetJob
	return job
end

local function parseMapMarkIcon(npcDefinition)
	if npcDefinition.mapMark then
		return npcDefinition.mapMark
	end

	local job = findJob(npcDefinition)
	if jobToMarkId[job] then
		return jobToMarkId[job]
	end

	return MAPMARK_EXCLAMATION
end

local function parseMapMarkDescription(npcDefinition)
	if npcDefinition.mapMarkDescription then
		return npcDefinition.mapMarkDescription
	end

	local job = findJob(npcDefinition)
	if jobToDescription[job] then
		return jobToDescription[job]
	end

	return npcDefinition.name
end

function InitializeNpcMarkers()
	local npcDefinitions = NpcRegistry:GetAll()
	for _, npcDefinition in pairs(npcDefinitions) do
		npcToMarkIcon[npcDefinition.name] = parseMapMarkIcon(npcDefinition)
		npcToMarkDescription[npcDefinition.name] = parseMapMarkDescription(npcDefinition)
	end
end

local choseSameLanguage = {
	["PL"] = "Polski jest juz twoim jezykiem.",
	["EN"] = "English is already your chosen language.",
}

local choseNewLanguage = {
	["PL"] = "Zmieniles jezyk na polski",
	["EN"] = "You have changed your language to english.",
}

local positionToMarkData = {}

local loadMarks = GlobalEvent("LoadPositionToMarkData")
function loadMarks.onStartup()
	local function parseNpcXML(xml)
		local npcs = {}
		for npcBlock in xml:gmatch("<npc(.-)</npc>") do
			local centerx, centery, centerz = npcBlock:match('centerx="(.-)"%s+centery="(.-)"%s+centerz="(.-)"')
			centerx, centery, centerz = tonumber(centerx), tonumber(centery), tonumber(centerz)

			for name, x, y, z in npcBlock:gmatch('name="(.-)".-x="(.-)"%s+y="(.-)"%s+z="(.-)"') do
				x, y, z = tonumber(x) + centerx, tonumber(y) + centery, tonumber(z) + 0
				table.insert(npcs, { name = name, x = x, y = y, z = z })
			end
		end
		return npcs
	end
	local file = io.open(DATA_DIRECTORY .. "/world/vaigu-npc.xml", "r")
	if not file then
		logger.error("[LoadPositionToMarkData] error reading npc file. Marks were not loaded.")
		return
	end
	local content = file:read("*a")
	file:close()
	local npcsOnMap = parseNpcXML(content)
	for _, npc in pairs(npcsOnMap) do
		local pos = Position(npc.x, npc.y, npc.z)

		local markIcon = npcToMarkIcon[npc.name]
		local markDescription = npcToMarkDescription[npc.name]

		if not markIcon then
			logger.debug(T("[LoadPositionToMarkData] Npc :name: is not registered or is in old system.", { name = npc.name }))
		else
			positionToMarkData[pos] = { markIcon = markIcon, markDescription = markDescription }
		end
	end
end
loadMarks:register()

local function trySetMarks(player)
	local playerLocalizer = player:Localizer(LOCALIZERS.MapMark)
	for pos, mark in pairs(positionToMarkData) do
		local translatedDescription = playerLocalizer:Get(mark.markDescription)
		player:addMapMark(pos, mark.markIcon, translatedDescription)
	end
end

local function onAcceptLanguage(player, button, choice)
	player = Player(player)
	if not player then
		return
	end

	player:setStorageValueByKey(Storage.marksSet, 1)
	trySetMarks(player)

	local nextLang = choice.text
	local currentLanguage = player:getLanguage()
	if nextLang == currentLanguage then
		player:sendTextMessage(MESSAGE_TRADE, choseSameLanguage[nextLang])
		return true
	end

	player:sendTextMessage(MESSAGE_TRADE, choseNewLanguage[nextLang])

	player:setLanguage(nextLang)
	player:sendTrackedMissions()
	player:reloadKnownNpcs()
	return true
end

function CreateChooseLanguageWindow(player)
	local window = ModalWindow({ title = "Language", message = "Set your default language: " })
	local localizer = player:Localizer(LOCALIZERS.Universal)
	window:addButton(localizer:Get("Select"), onAcceptLanguage)
	window:addButton(localizer:Get("Cancel"))

	for languageAbbreviation in pairs(LANG_ABBREVIATION_TO_FULL_NAME) do
		window:addChoice(languageAbbreviation)
	end
	window:sendToPlayer(player)
	return false
end

local changeLanguage = TalkAction("!language", "/language", "!lang", "/lang", "!jezyk", "/jezyk")
function changeLanguage.onSay(player, words, param)
	CreateChooseLanguageWindow(player)
end
changeLanguage:separator(" ")
changeLanguage:groupType("normal")
changeLanguage:register()

for abbreviation, full in pairs(LANG_ABBREVIATION_TO_FULL_NAME) do
	local setLanguage = TalkAction("!" .. full, "!" .. abbreviation, "!", "!" .. full:lower(), "!" .. abbreviation:lower(), "!" .. full:upper(), "!" .. abbreviation:upper())
	function setLanguage.onSay(player, words, param)
		onAcceptLanguage(player, nil, { text = abbreviation })
	end
	setLanguage:separator(" ")
	setLanguage:groupType("normal")
	setLanguage:register()
end
