local mainDir = DATA_DIRECTORY .. "/locales"

LOCALIZERS = {
	Universal = "_universal",
	Arena = "arena",
	ArielsFriend = "ariels_friend",
	AssassinsCreedSquurvaali = "assassins_creed_squurvaali",
	AvastYe = "avast_ye",
	BahledaPharellTroubles = "bahleda_pharell_troubles",
	BankSystem = "bank_system",
	BigfootBurden = "bigfoot_burden",
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
				logger.warn(T("File :filePath: does not exist", { filePath = filePath }))
			end
			TRANSLATION_TABLES[language][localizer] = fileContent
		end
	end
end

MISSING_STRINGS = {}
EXCESS_STRINGS = {}
function LoadMissingExcessStrings()
	for language in pairs(LANGUAGES) do
		MISSING_STRINGS[language] = {}
		EXCESS_STRINGS[language] = {}
		for key, fileName in pairs(LOCALIZERS) do
			MISSING_STRINGS[language][fileName] = {}
			EXCESS_STRINGS[language][fileName] = {}
		end
	end
	for localizer, translationTable in pairs(TRANSLATION_TABLES[LANGUAGES.EN]) do
		for key, translatedString in pairs(translationTable) do
			for language in pairs(LANGUAGES) do
				if not TRANSLATION_TABLES[language][localizer][key] then
					MISSING_STRINGS[language][localizer][key] = true
				end
			end
		end
	end
	for language, localizerToTranslationTable in pairs(TRANSLATION_TABLES) do
		if language == LANGUAGES.EN then
			goto continue
		end

		for localizer, translationTable in pairs(localizerToTranslationTable) do
			for key, translatedString in pairs(translationTable) do
				if not TRANSLATION_TABLES[LANGUAGES.EN][localizer][key] then
					EXCESS_STRINGS[language][localizer][key] = true
				end
			end
		end
		::continue::
	end
end

-- this registers TRANSLATION_TABLES on cpp side
Game.initializeTranslationTable()

local function translatedFromSpecificQuest(str, localizer, langauge)
	local questConf = TRANSLATION_TABLES[langauge][localizer]
	if questConf then
		return questConf[str]
	end
end

local missingStrings = {}
local stringsWithWrongLocalizer = {}
for _, language in pairs(LANGUAGES) do
	missingStrings[language] = {}
	stringsWithWrongLocalizer[language] = {}
	for _, localizer in pairs(LOCALIZERS) do
		missingStrings[language][localizer] = {}
		stringsWithWrongLocalizer[language][localizer] = {}
	end
end
function RegisterString(str, localizer)
	if not localizer then
		logger.warn(T("Localizer not found for str :str:", { str = str }))
		localizer = LOCALIZERS.NONE
	end
	for _, language in pairs(LANGUAGES) do
		missingStrings[language][localizer][str] = true
		stringsWithWrongLocalizer[language][localizer][str] = true
	end
end

local function translationExistsForLocalizer(str, localizer, langauge)
	local questConf = TRANSLATION_TABLES[langauge][localizer]
	if questConf then
		return questConf[str]
	end
	return false
end

local function translationExists(str, language)
	local allStrings = TRANSLATION_TABLES[language]
	if allStrings[LOCALIZERS.Universal][str] then
		return true
	end
	for localizer, questStrings in pairs(allStrings) do
		if questStrings[str] then
			return true
		end
	end

	return false
end

function PrintMissingStrings()
	for language, localizerToStr in pairs(missingStrings) do
		for localizer, strToMissing in pairs(localizerToStr) do
			for str in pairs(strToMissing) do
				if translationExists(str, language) then
					strToMissing[str] = nil
				else
					strToMissing[str] = true
				end
			end
		end
	end
	PrintAnything(missingStrings)
end

function PrintWrongLocalizerStrings()
	for language, localizerToStr in pairs(stringsWithWrongLocalizer) do
		for localizer, strToWrong in pairs(localizerToStr) do
			for str in pairs(strToWrong) do
				if translationExists(str, language) and not translationExistsForLocalizer(str, language, localizer) then
					strToWrong[str] = true
				else
					strToWrong[str] = nil
				end
			end
		end
	end
	PrintAnything(stringsWithWrongLocalizer)
end

local notFoundSuffix = " //Translation unavailable"
local function translationNotFound(str, language)
	logger.warn(T("[Localizer] translation not found for language :language:, for string: :str:", { language = language, str = str }))
	return str .. notFoundSuffix
end
function TranslatedFromAnyQuest(string, language, localizer)
	local allStrings = TRANSLATION_TABLES[language]
	if allStrings[LOCALIZERS.Universal][string] then
		return allStrings[LOCALIZERS.Universal][string]
	end
	for _, questStrings in pairs(allStrings) do
		if questStrings[string] then
			return questStrings[string]
		end
	end

	localizer = localizer or LOCALIZERS.Universal
	--MissingStrings[language][localizer] = MissingStrings[language][localizer] or {}
	--MissingStrings[language][localizer][string] = true
	return translationNotFound(string, language)
end

---@class Localizer
---@field player Player
---@field questId integer
---@field context table?
Localizer = {}
Localizer.__index = Localizer
function Localizer:New(player, questId)
	local newObj = {}
	newObj.player = player
	newObj.questId = questId
	newObj.translated = nil
	newObj.context = { player = player, questId = questId }
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
	local translated = translatedFromSpecificQuest(translateMe, self.questId, targetLanguage) or TranslatedFromAnyQuest(translateMe, targetLanguage)
	self.translated = Evaluate(translated, self.context)
	return self.translated
end

function Localizer:Context(context)
	context = context or {}
	context.player = self.player
	context.questId = self.questId
	self.context = context
	return self
end

function Player:Localizer(questId)
	return Localizer(self, questId)
end

MissingStrings = {}
for key, value in pairs(LANGUAGES) do
	MissingStrings[value] = {}
end

-- usage in-game: /lua missingStringsToFile()
function missingStringsToFile()
	for language, questIdToStr in pairs(MissingStrings) do
		for questId, strToPresence in pairs(questIdToStr) do
			for str in pairs(strToPresence) do
				-- Construct the file path
				local dirPath = ".\\missingStrings\\" .. language
				local filePath = dirPath .. "\\" .. questId .. ".lua"

				-- Open the file in append mode
				local file, err = io.open(filePath, "a+")
				if not file then
					logger.warn("[missingStringsToFile] Error opening file: " .. err)
					return false
				end

				str = string.gsub(str, "\n", "\\n")
				-- Write the content to the file
				file:write(str .. "\n")

				-- Close the file
				file:close()
			end
		end
	end
end
