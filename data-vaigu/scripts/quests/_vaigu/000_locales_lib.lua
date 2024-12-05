local mainDir = DATA_DIRECTORY .. "/locales"

LOCALIZERS = { --38f add desert quest/king of rats
	--Various quests
	AssassinsCreedSquurvaali = "assassins_creed_squurvaali",
	ChesterTheDwarf = "chester_the_dwarf",
	DemonOak = "demon_oak",
	ImRestingHere = "im_resting_here",
	PathOfTheUndead = "path_of_the_undead",
	ProdigalSon = "prodigal_son",
	--King of Rats main quests
	KingOfRatsHQ = "kings_of_rats_hq",
	TheaterOfCheapThrills = "theater_of_cheap_thrills",
	SafetyAndOccupationalHygiene = "safety_and_occupational_hygiene",
	ThreeSramatiansAndTheDragon = "three_sramatians_and_the_dragon",
	FourActTragedy = "four_act_tragedy",
	PerIustitiaAdAstra = "per_iustitia_ad_astra",
	--Kins of rats side quests
	RubelsteinLegacy = "rubelstein_legacy",
	--Desert quest
	DesertQuestOne = "desert_quest_one",
	DesertQuestTwo = "desert_quest_two",
	CaveExplorerOnShield = "cave_explorer_on_shield",
	SultanPrime = "sultan_prime",
	DesertQuestHub = "desert_quest_hub",
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

function Localizer:Get(str)
	if not str then
		return nil
	end
	local translated = Translated(str, self.player, self.questId)
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

local function translatedFromAnyQuest(string, language)
	local allStrings = TRANSLATION_TABLES[language]
	if allStrings[LOCALIZERS.LOCALIZER_UNIVERSAL][string] then
		return allStrings[LOCALIZERS.LOCALIZER_UNIVERSAL][string]
	end
	for _, questStrings in pairs(allStrings) do
		if questStrings[string] then
			return questStrings[string]
		end
	end

	logger.debug(T('[translatedFromAnyQuest] The string ":string:" is not available in any of the Translation Tables.', { string = string }))
end

function Translated(str, player, questId)
	local targetLanguage = player:getLanguage()
	return translatedFromSpecificQuest(str, questId, targetLanguage) or translatedFromAnyQuest(str, targetLanguage)
end
