local mainDir = DATA_DIRECTORY .. "/locales"

LOCALIZERS = {
	--#region 2024
	DesertQuestHub = "desert_quest_hub",
	FatMyrrusEncounters = "fat_myrrus_encounters",
	DesertQuestTwo = "desert_quest_two",
	EnterTheDrunkTank = "enter_the_drunk_tank",
	ProdigalSon = "prodigal_son",
	--King of Rats II - V
	SafetyAndOccupationalHygiene = "safety_and_occupational_hygiene",
	ThreeSramatiansAndTheDragon = "three_sramatians_and_the_dragon",
	FourActTragedy = "four_act_tragedy",
	PerIustitiaAdAstra = "per_iustitia_ad_astra",
	--Kings of Rats miscellaneous
	KingOfRatsHQ = "king_of_rats_hq",
	RubelsteinLegacy = "rubelstein_legacy",
	--#endregion

	--#region 2021
	PathOfTheUndead = "path_of_the_undead",
	AssassinsCreedSquurvaali = "assassins_creed_squurvaali",
	ChesterTheDwarf = "chester_the_dwarf",
	ImRestingHere = "im_resting_here",
	TheaterOfCheapThrills = "theater_of_cheap_thrills",
	DesertQuestOne = "desert_quest_one",
	CaveExplorerOnShield = "cave_explorer_on_shield",
	SultanPrime = "sultan_prime",
	--#endregion

	--Task
	Tasks = "tasks",
	DailyTasks = "daily_tasks",

	--Old quests
	Firestarter = "firestarter",
	WayOfTheDruid = "way_of_the_druid",
	ArielsFriend = "ariels_friend",
	LocalSupport = "local_support",
	SilenceOfTheLambs = "silence_of_the_lambs",
	ToCarryThePigs = "to_carry_the_pigs",
	TopChef = "top_chef",

	--Real tibia
	TheInquisitionQuest = "the_inquisition_quest",
	TheDreamCourts = "the_dream_courts",
	BigfootBurden = "bifoot_burden",
	DemonOak = "demon_oak",
	LiquidBlack = "liquid_black",
	TheApeCity = "the_ape_city",

	--Misc
	LOCALIZER_UNIVERSAL = "_universal",
	NONE = "",
}

TRANSLATION_TABLES = {}
for _, language in pairs(LANGUAGES) do
	TRANSLATION_TABLES[language] = {}
	for _, localizer in pairs(LOCALIZERS) do
		if localizer ~= LOCALIZERS.NONE then
			local filePath = T("/:mainDir:/:language:/:localizer:", { mainDir = mainDir, language = language, localizer = localizer }):lower():sub(2)
			local success, fileContent = pcall(require, filePath)
			TRANSLATION_TABLES[language][localizer] = fileContent
			if not success then
				logger.warn(T("File :filePath: does not exist", { filePath = filePath }))
			end
		end
	end
end

--register TRANSLATION_TABLES on cpp side
Game.initializeTranslationTable()

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

	local translated = Translated(translateMe, self.player, self.questId)
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

local function translatedFromSpecificQuest(str, questId, targetLanguage)
	local questConf = TRANSLATION_TABLES[targetLanguage][questId]
	if questConf then
		return questConf[str]
	end
end

MissingStrings = {}
for key, value in pairs(LANGUAGES) do
	MissingStrings[value] = {}
end

function missingStringsToFile()
	for language, questIdToStr in pairs(MissingStrings) do
		for questId, strToPesence in pairs(questIdToStr) do
			for str in pairs(strToPesence) do
				-- Construct the file path
				local dirPath = ".\\missingStrings\\" .. language
				local filePath = dirPath .. "\\" .. questId .. ".lua"

				-- Open the file in append mode
				local file, err = io.open(filePath, "a+")
				if not file then
					print("Error opening file: " .. err)
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

function translatedFromAnyQuest(string, language, questId)
	local allStrings = TRANSLATION_TABLES[language]
	if allStrings[LOCALIZERS.LOCALIZER_UNIVERSAL][string] then
		return allStrings[LOCALIZERS.LOCALIZER_UNIVERSAL][string]
	end
	for _, questStrings in pairs(allStrings) do
		if questStrings[string] then
			return questStrings[string]
		end
	end

	questId = questId or LOCALIZERS.LOCALIZER_UNIVERSAL
	MissingStrings[language][questId] = MissingStrings[language][questId] or {}
	MissingStrings[language][questId][string] = true
end

function Translated(str, player, questId)
	local targetLanguage = player:getLanguage()
	return translatedFromSpecificQuest(str, questId, targetLanguage) or translatedFromAnyQuest(str, targetLanguage)
end
