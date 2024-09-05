local langToMarksConfig = {
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
		{ mark = "statue", position = Position(5824, 1514, 7), markId = MAPMARK_SWORD, description = "Trening offline" },
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
		{ mark = "jewelry", position = Position(5850, 1574, 7), markId = MAPMARK_KISS, description = "Rings & Amulets" },
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
		{ mark = "paladinshop", position = Position(5864, 1575, 7), markId = MAPMARK_BAG, description = "Distance Shop" },
		{ mark = "paladinshop", position = Position(6727, 1344, 6), markId = MAPMARK_BAG, description = "Distance Shop" },
		{ mark = "paladinshop", position = Position(6996, 767, 6), markId = MAPMARK_BAG, description = "Distance Shop" },
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
		{ mark = "komisarz", position = Position(5849, 1609, 7), markId = MAPMARK_TICK, description = "Commissioner Fisher" },
		{ mark = "statue", position = Position(5824, 1514, 7), markId = MAPMARK_SWORD, description = "Offline Training" },
		{ mark = "temple", position = Position(5836, 1502, 7), markId = MAPMARK_TICK, description = "Temple" },
		{ mark = "temple", position = Position(6726, 1248, 4), markId = MAPMARK_TICK, description = "Temple" },
		{ mark = "temple", position = Position(7034, 734, 3), markId = MAPMARK_TICK, description = "Temple" },
		{ mark = "taski", position = Position(5892, 1590, 7), markId = MAPMARK_TICK, description = "Tasks" },
		{ mark = "burmistrz", position = Position(5842, 1548, 7), markId = MAPMARK_TICK, description = "Mrs Mayor" },
	},
}

local choseSameLanguage = {
	["PL"] = "Polski jest twoim aktualnym jezykiem.",
	["EN"] = "Your language is english already.",
}

local choseNewLanguage = {
	["PL"] = "Zmieniles jezyk na polski",
	["EN"] = "Your new language has been set to english.",
}

local function trySetMarks(player)
	local lang = player:getLanguage()
	if player:getStorageValue(Storage.marksSet) <= 0 then
		player:setStorageValue(Storage.marksSet, 1)
		local marksConfig = langToMarksConfig[lang]
		for _, mark in pairs(marksConfig) do
			player:addMapMark(mark.position, mark.markId, mark.description)
		end
	end
end

local function onAcceptLanguage(player, button, choice)
	player = GetPlayerByCidOrObject(player)
	if not player then
		return
	end
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

local changeLanguage = TalkAction("!language", "/language")

function changeLanguage.onSay(player, words, param)
	local window = ModalWindow({ title = "Language", message = "Set your default language: " })
	local localizer = player:Localizer(LOCALIZER_UNIVERSAL)
	window:addButton(localizer:Get("Select"), onAcceptLanguage)
	window:addButton(localizer:Get("Cancel"))

	for languageAbbreviation in pairs(LANG_ABBREVIATION_TO_FULL_NAME) do
		window:addChoice(languageAbbreviation)
	end
	window:sendToPlayer(player)
	return false
end

changeLanguage:separator(" ")
changeLanguage:groupType("normal")
changeLanguage:register()
