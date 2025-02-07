--3af refactor
local langToMarksConfigOld = {
	["PL"] = {
		{ mark = "fishing", position = Position(5843, 1588, 7), markId = MAPMARK_TICK, description = "Stary Anona" },
		{ mark = "gate", position = Position(5900, 1475, 7), markId = MAPMARK_TICK, description = "North Gate" },
		{ mark = "gate", position = Position(5892, 1613, 7), markId = MAPMARK_TICK, description = "Shouth Gate" },
		{ mark = "gate", position = Position(5997, 1559, 7), markId = MAPMARK_TICK, description = "East Gate" },
		{ mark = "gate", position = Position(5806, 1556, 7), markId = MAPMARK_TICK, description = "West Gate" },
		{ mark = "ship", position = Position(5973, 1503, 7), markId = MAPMARK_TICK, description = "Statek" },
		{
			mark = "tools",
			position = Position(5862, 1559, 7),
			markId = MAPMARK_SHOVEL,
			description = "Sklep z narzedziami",
		},
		{
			mark = "tools",
			position = Position(6692, 1340, 7),
			markId = MAPMARK_SHOVEL,
			description = "Sklep z narzedziami",
		},
		{
			mark = "fluids",
			position = Position(5872, 1557, 7),
			markId = MAPMARK_STAR,
			description = "Zaopatrzenie magiczne",
		},
		{
			mark = "fluids",
			position = Position(6712, 1319, 7),
			markId = MAPMARK_STAR,
			description = "Zaopatrzenie magiczne",
		},
		{
			mark = "fluids",
			position = Position(7053, 768, 5),
			markId = MAPMARK_STAR,
			description = "Zaopatrzenie magiczne",
		},
		{ mark = "depo", position = Position(5890, 1557, 7), markId = MAPMARK_LOCK, description = "Depo" },
		{ mark = "depo", position = Position(6707, 1326, 7), markId = MAPMARK_LOCK, description = "Depo" },
		{ mark = "depo", position = Position(7049, 772, 6), markId = MAPMARK_LOCK, description = "Depo" },
		{ mark = "post", position = Position(5891, 1563, 7), markId = MAPMARK_FLAG, description = "Poczta" },
		{ mark = "post", position = Position(6713, 1325, 7), markId = MAPMARK_FLAG, description = "Poczta" },
		{ mark = "arm", position = Position(5854, 1560, 7), markId = MAPMARK_SWORD, description = "Skup uzbrojenia" },
		{ mark = "arm", position = Position(6700, 1318, 7), markId = MAPMARK_SWORD, description = "Skup uzbrojenia" },
		{ mark = "arm", position = Position(7053, 776, 5), markId = MAPMARK_SWORD, description = "Skup uzbrojenia" },
		{ mark = "jewelry", position = Position(5850, 1574, 7), markId = MAPMARK_KISS, description = "Jubiler" },
		{
			mark = "creatureproducts",
			position = Position(5840, 1575, 7),
			markId = MAPMARK_BAG,
			description = "Sprzedaz creatureproducts",
		},
		{
			mark = "creatureproducts",
			position = Position(7039, 788, 6),
			markId = MAPMARK_BAG,
			description = "Sprzedaz creatureproducts",
		},
		{
			mark = "paladinshop",
			position = Position(5864, 1575, 7),
			markId = MAPMARK_BAG,
			description = "Zaopatrzenie dla lucznikow",
		},
		{
			mark = "paladinshop",
			position = Position(6727, 1344, 6),
			markId = MAPMARK_BAG,
			description = "Zaopatrzenie dla lucznikow",
		},
		{
			mark = "paladinshop",
			position = Position(6996, 767, 6),
			markId = MAPMARK_BAG,
			description = "Zaopatrzenie dla lucznikow",
		},
		{ mark = "bank", position = Position(5893, 1558, 9), markId = MAPMARK_DOLLAR, description = "Bank" },
		{
			mark = "shophouse",
			position = Position(5840, 1560, 7),
			markId = MAPMARK_TICK,
			description = "Wyposazenie domu",
		},
		{ mark = "food", position = Position(5874, 1574, 7), markId = MAPMARK_TICK, description = "Sklep z jedzeniem" },
		{ mark = "food", position = Position(6726, 1345, 7), markId = MAPMARK_TICK, description = "Prince kebab" },
		{ mark = "food", position = Position(7006, 765, 6), markId = MAPMARK_TICK, description = "Sklep z jedzeniem" },
		{ mark = "komisarz", position = Position(5849, 1609, 7), markId = MAPMARK_TICK, description = "Komisarz Ryba" },
		{
			mark = "statue",
			position = Position(5824, 1514, 7),
			markId = MAPMARK_SWORD,
			description = "Trening offline",
		},
		{ mark = "temple", position = Position(5836, 1502, 7), markId = MAPMARK_TICK, description = "Swiatynia" },
		{ mark = "temple", position = Position(6726, 1248, 4), markId = MAPMARK_TICK, description = "Swiatynia" },
		{ mark = "temple", position = Position(7034, 734, 3), markId = MAPMARK_TICK, description = "Swiatynia" },
		{ mark = "taski", position = Position(5892, 1590, 7), markId = MAPMARK_TICK, description = "Tropiciel Wielki" },
		{ mark = "burmistrz", position = Position(5842, 1548, 7), markId = MAPMARK_TICK, description = "Burmistrz" },
	},
	["EN"] = {
		{ mark = "gate", position = Position(5900, 1475, 7), markId = MAPMARK_TICK, description = "North Gate" },
		{ mark = "gate", position = Position(5892, 1613, 7), markId = MAPMARK_TICK, description = "Shouth Gate" },
		{ mark = "gate", position = Position(5997, 1559, 7), markId = MAPMARK_TICK, description = "East Gate" },
		{ mark = "gate", position = Position(5806, 1556, 7), markId = MAPMARK_TICK, description = "West Gate" },
		{ mark = "ship", position = Position(5973, 1503, 7), markId = MAPMARK_TICK, description = "Ship" },
		{
			mark = "tools",
			position = Position(5862, 1559, 7),
			markId = MAPMARK_SHOVEL,
			description = "Sklep z narzedziami",
		},
		{
			mark = "tools",
			position = Position(6692, 1340, 7),
			markId = MAPMARK_SHOVEL,
			description = "Sklep z narzedziami",
		},
		{ mark = "fluids", position = Position(5872, 1557, 7), markId = MAPMARK_STAR, description = "Mage Shop" },
		{ mark = "fluids", position = Position(6712, 1319, 7), markId = MAPMARK_STAR, description = "Mage Shop" },
		{ mark = "fluids", position = Position(7053, 768, 5), markId = MAPMARK_STAR, description = "Mage Shop" },
		{ mark = "depo", position = Position(5890, 1557, 7), markId = MAPMARK_LOCK, description = "Depot" },
		{ mark = "depo", position = Position(6707, 1326, 7), markId = MAPMARK_LOCK, description = "Depot" },
		{ mark = "depo", position = Position(7049, 772, 6), markId = MAPMARK_LOCK, description = "Depot" },
		{ mark = "post", position = Position(5891, 1563, 7), markId = MAPMARK_FLAG, description = "Post" },
		{ mark = "post", position = Position(6713, 1325, 7), markId = MAPMARK_FLAG, description = "Post" },
		{ mark = "arm", position = Position(5854, 1560, 7), markId = MAPMARK_SWORD, description = "Equipment" },
		{ mark = "arm", position = Position(6700, 1318, 7), markId = MAPMARK_SWORD, description = "Equipment" },
		{ mark = "arm", position = Position(7053, 776, 5), markId = MAPMARK_SWORD, description = "Equipment" },
		{
			mark = "jewelry",
			position = Position(5850, 1574, 7),
			markId = MAPMARK_KISS,
			description = "Rings & Amulets",
		},
		{
			mark = "creatureproducts",
			position = Position(5840, 1575, 7),
			markId = MAPMARK_BAG,
			description = "Creature Products",
		},
		{
			mark = "creatureproducts",
			position = Position(7039, 788, 6),
			markId = MAPMARK_BAG,
			description = "Creature Products",
		},
		{
			mark = "paladinshop",
			position = Position(5864, 1575, 7),
			markId = MAPMARK_BAG,
			description = "Distance Shop",
		},
		{
			mark = "paladinshop",
			position = Position(6727, 1344, 6),
			markId = MAPMARK_BAG,
			description = "Distance Shop",
		},
		{
			mark = "paladinshop",
			position = Position(6996, 767, 6),
			markId = MAPMARK_BAG,
			description = "Distance Shop",
		},
		{ mark = "bank", position = Position(5893, 1558, 9), markId = MAPMARK_DOLLAR, description = "Bank" },
		{
			mark = "shophouse",
			position = Position(5840, 1560, 7),
			markId = MAPMARK_TICK,
			description = "House Decorations",
		},
		{ mark = "food", position = Position(5874, 1574, 7), markId = MAPMARK_TICK, description = "Food shop" },
		{ mark = "food", position = Position(6726, 1345, 7), markId = MAPMARK_TICK, description = "Prince kebab" },
		{ mark = "food", position = Position(7006, 765, 6), markId = MAPMARK_TICK, description = "Food shop" },
		{
			mark = "komisarz",
			position = Position(5849, 1609, 7),
			markId = MAPMARK_TICK,
			description = "Commissioner Fisher",
		},
		{
			mark = "statue",
			position = Position(5824, 1514, 7),
			markId = MAPMARK_SWORD,
			description = "Offline Training",
		},
		{ mark = "temple", position = Position(5836, 1502, 7), markId = MAPMARK_TICK, description = "Temple" },
		{ mark = "temple", position = Position(6726, 1248, 4), markId = MAPMARK_TICK, description = "Temple" },
		{ mark = "temple", position = Position(7034, 734, 3), markId = MAPMARK_TICK, description = "Temple" },
		{ mark = "taski", position = Position(5892, 1590, 7), markId = MAPMARK_TICK, description = "Tasks" },
		{ mark = "burmistrz", position = Position(5842, 1548, 7), markId = MAPMARK_TICK, description = "Mrs Mayor" },
	},
}

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
	[JOB_NONE] = nil,
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

do
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
	assert(file)
	local content = file:read("*a")
	file:close()
	local npcXml = parseNpcXML(content)
	for _, npc in pairs(npcXml) do
		local pos = Position(npc.x, npc.y, npc.z)

		local markIcon = npcToMarkIcon[npc.name]
		local markDescription = npcToMarkDescription[npc.name]
		positionToMarkData[pos] = { markIcon = markIcon, markDescription = markDescription }
	end
end

local function trySetMarks(player)
	local playerLocalizer = player:Localizer(LOCALIZERS.MapMark)
	for _, mark in pairs(positionToMarkData) do
		local translatedDescription = playerLocalizer:Get(mark.description)
		player:addMapMark(mark.position, mark.markIcon, translatedDescription)
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
