local mainDir = DATA_DIRECTORY .. "/locales"

LOCALIZERS = {
	Universal = "_universal",
	Sign = "_sign",

	Arena = "arena",
	ArielsFriend = "ariels_friend",
	AssassinsCreedSquurvaali = "assassins_creed_squurvaali",
	AvastYe = "avast_ye",
	BahledaPharellTroubles = "bahleda_pharell_troubles",
	BankSystem = "bank_system",
	BigfootsBurden = "bigfoot_burden",
	CaveExplorerOnShield = "cave_explorer_on_shield",
	ChesterTheDwarf = "chester_the_dwarf",
	FashionistaOnanista = "fashionista_onanista",
	DailyTasks = "daily_tasks",
	DemonOak = "demon_oak",
	DesertQuestHub = "desert_quest_hub",
	DesertQuestOne = "desert_quest_one",
	DesertQuestTwo = "desert_quest_two",
	EnterTheDrunkTank = "enter_the_drunk_tank",
	FatMyrrusEncounters = "fat_myrrus_encounters",
	Firestarter = "firestarter",
	FourActTragedy = "four_act_tragedy",
	GoldenOutfit = "golden_outfit",
	ImRestingHere = "im_resting_here",
	KingOfRatsHQ = "king_of_rats_hq",
	LiquidBlack = "liquid_black",
	LocalSupport = "local_support",
	LuaRaids = "lua_raids",
	MapMark = "map_mark",
	OneTimeEscorts = "one_time_escorts",
	Minigames = "minigames",
	NpcName = "npc_name",
	PathOfTheUndead = "path_of_the_undead",
	PerIustitiaAdAstra = "per_iustitia_ad_astra",
	Priest = "priest",
	ProdigalSon = "prodigal_son",
	RubelsteinLegacy = "rubelstein_legacy",
	SafetyAndOccupationalHygiene = "safety_and_occupational_hygiene",
	SilenceOfTheLambs = "silence_of_the_lambs",
	SultanPrime = "sultan_prime",
	Tasks = "tasks",
	TheApeCity = "the_ape_city",
	TheaterOfCheapThrills = "theater_of_cheap_thrills",
	TheDreamCourts = "the_dream_courts",
	TheInquisitionQuest = "the_inquisition_quest",
	ThreeSramatiansAndTheDragon = "three_sramatians_and_the_dragon",
	ToCarryThePigs = "to_carry_the_pigs",
	TopChef = "top_chef",
	TravelName = "travel_name",
	WayOfTheDruid = "way_of_the_druid",

	NONE = "",
}

TRANSLATION_TABLES = {}
for _, language in pairs(LANGUAGES) do
	TRANSLATION_TABLES[language] = {}
	for _, localizer in pairs(LOCALIZERS) do
		if localizer ~= LOCALIZERS.NONE then
			local filePath = T("/:mainDir:/:language:/:localizer:", { mainDir = mainDir, language = language, localizer = localizer }):lower():sub(2)
			local success, fileContent = pcall(require, filePath)
			if not success then
				logger.warn(T("[TRANSLATION_TABLES init] File :filePath: does not exist\n:trace:", { filePath = filePath, trace = debug.traceback() }))
			end
			TRANSLATION_TABLES[language][localizer] = fileContent
		end
	end
end

-- this registers TRANSLATION_TABLES on cpp side
Game.initializeTranslationTable()

local function translatedFromSpecificQuest(str, localizer, language)
	local questConf = TRANSLATION_TABLES[language][localizer]
	if questConf then
		return questConf[str]
	end
end

local notFoundSuffix = " //Translation unavailable"
local function translationNotFound(language, localizer, str)
	local loggerCompatibleString = str
	loggerCompatibleString = loggerCompatibleString:gsub("{", "#")
	loggerCompatibleString = loggerCompatibleString:gsub("}", "#")
	logger.warn(T("[Localizer] translation not found for language :language:, for string: :loggerCompatibleString:", { language = language or LOCALIZERS.NONE, loggerCompatibleString = loggerCompatibleString or "EMPTY_STRING" }))
	MissingStrings:Add(language, localizer, str)
	return str .. notFoundSuffix
end

function TranslatedFromAnyQuest(str, language, localizer)
	local allStrings = TRANSLATION_TABLES[language]
	if allStrings[LOCALIZERS.Universal][str] then
		return allStrings[LOCALIZERS.Universal][str]
	end
	for _, questStrings in pairs(allStrings) do
		if questStrings[str] then
			return questStrings[str]
		end
	end

	localizer = localizer or LOCALIZERS.Universal
	return translationNotFound(language, localizer, str)
end

local localizerToId = SwappedKeyValue(LOCALIZERS)

---@class Localizer
---@field player Player
---@field localizer integer
---@field context table?
Localizer = {}
Localizer.__index = Localizer
function Localizer:New(player, localizer)
	local newObj = {}
	newObj.player = player
	newObj.localizer = localizer
	if not localizerToId[newObj.localizer] then
		logger.warn(T("[Localizer::New] incorrect localizer :localizer: was used.", { localizer = localizer }))
	end
	newObj.translated = nil
	newObj.context = { player = player, localizer = localizer }
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(Localizer, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

---@param translateMe string|table
function Localizer:Get(translateMe)
	if not translateMe then
		logger.warn(debug.traceback("[Localizer::Get] Trying to translate nil"))
		return nil
	end
	if type(translateMe) == "table" then
		translateMe = translateMe[math.random(1, #translateMe)]
	end

	local targetLanguage = self.player:getLanguage()
	local translated = translatedFromSpecificQuest(translateMe, self.localizer, targetLanguage) or TranslatedFromAnyQuest(translateMe, targetLanguage)
	self.translated = Evaluate(translated, self.context)
	return self.translated
end

function Localizer:Context(context)
	context = context or {}
	context.player = self.player
	context.localizer = self.localizer
	self.context = context
	return self
end

function Player:Localizer(localizer)
	return Localizer(self, localizer)
end

MissingStrings = {}
MissingStrings.__index = MissingStrings
MissingStrings.registry = {}
function MissingStrings:Add(language, localizer, str)
	self.registry[language] = self.registry[language] or {}
	self.registry[language][localizer] = self.registry[language][localizer] or {}
	self.registry[language][localizer][str] = true
end

for key, value in pairs(LANGUAGES) do
	MissingStrings.registry[value] = {}
end

function MissingStrings:TestAllLanaguages(str, localizer)
	for _, language in pairs(LANGUAGES) do
		local allStrings = TRANSLATION_TABLES[language]
		if allStrings[LOCALIZERS.Universal][str] then
			return allStrings[LOCALIZERS.Universal][str]
		end
		for _, questStrings in pairs(allStrings) do
			if questStrings[str] then
				return questStrings[str]
			end
		end

		localizer = localizer or LOCALIZERS.Universal
		MissingStrings:Add(language, localizer, str)
	end
end

-- usage in-game: /lua MissingStrings:Serialize()
function MissingStrings:Serialize()
	local missingStringsPath = "utility_scripts" .. "\\missing_strings"
	os.execute("rmdir /S /Q " ..missingStringsPath)
	os.execute("mkdir " .. missingStringsPath)
	for language, questIdToStr in pairs(self.registry) do
		local missingStringsLanguagePath = missingStringsPath .. "\\" .. language
		os.execute("mkdir " .. missingStringsLanguagePath)
		for localizer, strToPresence in pairs(questIdToStr) do
			local missingStringsLanguageLocalizerPath = missingStringsLanguagePath .. "\\" .. localizer .. ".lua"
			local file, err = io.open(missingStringsLanguageLocalizerPath, "a+")
			if not file then
				logger.warn("[MissingStrings::Serialize] Error opening file: " .. err)
				return false
			end
			local formattedStrToSerialize = ""
			for str in pairs(strToPresence) do
				formattedStrToSerialize = formattedStrToSerialize .. string.gsub(str, "\n", "\\n") .. "\n"
			end
			file:write(formattedStrToSerialize)
			file:flush()
			file:close()
		end
	end
end
