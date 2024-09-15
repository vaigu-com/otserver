local stringsDir = DATA_DIRECTORY .. "/locales/"
local function loadStrings(name)
	return dofile(stringsDir .. name)
end

-- keep global for cpp side access
TRANSLATION_TABLES = {
	["PL"] = {
		[LOCALIZER_UNIVERSAL] = loadStrings("universal_pl.lua"),
		[Storage.TrzejSramaciISmok.Questline] = loadStrings("trzej_sramaci_i_smok_pl.lua"),
		[Storage.AssassinsCreedSkurwoala.Questline] = loadStrings("assassins_creed_skurwoala_pl.lua"),
		[Storage.BezpieczenstwoIHigienaPracy.Questline] = loadStrings("bezpieczenstwo_i_higiena_pracy_pl.lua"),
		[Storage.CzeslawKrasnolud.Questline] = loadStrings("czeslaw_krasnolud_pl.lua"),
		[Storage.DesertQuestGhosts.Questline] = loadStrings("desert_quest_ghosts_pl.lua"),
		[Storage.KrolSzczurowHub.Questline] = loadStrings("krol_szczurow_hub_pl.lua"),
		[Storage.PerIustitiaAdAstra.Questline] = loadStrings("per_iustitia_ad_astra_pl.lua"),
		[Storage.SciezkaNieumarlych.Questline] = loadStrings("sciezka_nieumarlych_pl.lua"),
		[Storage.SpoczywajacyTutaj.Questline] = loadStrings("spoczywajacy_tutaj_pl.lua"),
		[Storage.SultanPrime.Questline] = loadStrings("sultan_prime_pl.lua"),
		[Storage.TeatrTaniejSensacji.Questline] = loadStrings("teatr_taniej_sensacji_pl.lua"),
		[Storage.TragedyaWCzterechAktach.Questline] = loadStrings("tragedya_w_czterech_aktach_pl.lua"),
		[Storage.NaPomocBagietom.DietaGrubegoMirka] = loadStrings("dieta_grubego_mirka_pl.lua"),
		[Storage.DesertQuestOne.Questline] = loadStrings("desert_quest_one_pl.lua"),
		[Storage.DesertQuestTwo.Questline] = loadStrings("desert_quest_two_pl.lua"),
		[Storage.SynMarnotrawny.Questline] = loadStrings("syn_marnotrawny_pl.lua"),
		[LOCALIZER_PRIEST] = loadStrings("priest_pl.lua"),
		[Storage.GrubyMirekEncounters] = loadStrings("gruby_mirek_encounters_pl.lua"),
		[LOCALIZER_LUA_RAIDS] = loadStrings("lua_raids_pl.lua"),
		[LOCALIZER_NPC_NAME] = loadStrings("npc_name_pl.lua"),
		[LOCALIZER_TASK_BOSS_LOCATIONS] = loadStrings("task_boss_locations_pl.lua"),
		[LOCALIZER_QUESTLOG] = loadStrings("questlog_pl.lua"),
		[Storage.Tasks.TaskInfo] = loadStrings("task_info_pl.lua"),
		[Storage.DailyTasks.DailyTaskInfo] = loadStrings("daily_tasks_info_pl.lua"),
		[Storage.taskPoints] = loadStrings("task_points_pl.lua"),
		[Storage.GoldenOutfit] = loadStrings("golden_outfit_pl.lua"),
		[Storage.TopChef.Questline] = loadStrings("top_chef_pl.lua"),
		[LOCALIZER_BANK_SYSTEM] = loadStrings("bank_system_pl.lua"),
	},
	["EN"] = {
		[LOCALIZER_UNIVERSAL] = loadStrings("universal_en.lua"),
		[Storage.TrzejSramaciISmok.Questline] = loadStrings("trzej_sramaci_i_smok_en.lua"),
		[Storage.AssassinsCreedSkurwoala.Questline] = loadStrings("assassins_creed_skurwoala_en.lua"),
		[Storage.BezpieczenstwoIHigienaPracy.Questline] = loadStrings("bezpieczenstwo_i_higiena_pracy_en.lua"),
		[Storage.CzeslawKrasnolud.Questline] = loadStrings("czeslaw_krasnolud_en.lua"),
		[Storage.DesertQuestGhosts.Questline] = loadStrings("desert_quest_ghosts_en.lua"),
		[Storage.KrolSzczurowHub.Questline] = loadStrings("krol_szczurow_hub_en.lua"),
		[Storage.PerIustitiaAdAstra.Questline] = loadStrings("per_iustitia_ad_astra_en.lua"),
		[Storage.SciezkaNieumarlych.Questline] = loadStrings("sciezka_nieumarlych_en.lua"),
		[Storage.SpoczywajacyTutaj.Questline] = loadStrings("spoczywajacy_tutaj_en.lua"),
		[Storage.SultanPrime.Questline] = loadStrings("sultan_prime_en.lua"),
		[Storage.TeatrTaniejSensacji.Questline] = loadStrings("teatr_taniej_sensacji_en.lua"),
		[Storage.TragedyaWCzterechAktach.Questline] = loadStrings("tragedya_w_czterech_aktach_en.lua"),
		[Storage.NaPomocBagietom.DietaGrubegoMirka] = loadStrings("dieta_grubego_mirka_en.lua"),
		[Storage.DesertQuestOne.Questline] = loadStrings("desert_quest_one_en.lua"),
		[Storage.DesertQuestTwo.Questline] = loadStrings("desert_quest_two_en.lua"),
		[Storage.SynMarnotrawny.Questline] = loadStrings("syn_marnotrawny_en.lua"),
		[LOCALIZER_PRIEST] = loadStrings("priest_en.lua"),
		[Storage.GrubyMirekEncounters] = loadStrings("gruby_mirek_encounters_en.lua"),
		[LOCALIZER_LUA_RAIDS] = loadStrings("lua_raids_en.lua"),
		[LOCALIZER_NPC_NAME] = loadStrings("npc_name_en.lua"),
		[LOCALIZER_TASK_BOSS_LOCATIONS] = loadStrings("task_boss_locations_en.lua"),
		[LOCALIZER_QUESTLOG] = loadStrings("questlog_en.lua"),
		[Storage.Tasks.TaskInfo] = loadStrings("task_info_en.lua"),
		[Storage.DailyTasks.DailyTaskInfo] = loadStrings("daily_tasks_info_en.lua"),
		[Storage.taskPoints] = loadStrings("task_points_en.lua"),
		[Storage.GoldenOutfit] = loadStrings("golden_outfit_en.lua"),
		[Storage.TopChef.Questline] = loadStrings("top_chef_en.lua"),
		[LOCALIZER_BANK_SYSTEM] = loadStrings("bank_system_en.lua"),
	},
}

Game.initializeTranslationTable() -- cpp side

Localizer = {}
Localizer.__index = Localizer
function Localizer:new(player, questId)
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
		return class:new(...)
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
	local allTranslationsByLanguage = TRANSLATION_TABLES[language]
	if allTranslationsByLanguage[LOCALIZER_UNIVERSAL][string] then
		return TRANSLATION_TABLES[language][LOCALIZER_UNIVERSAL][string]
	end
	for _, questStrings in pairs(allTranslationsByLanguage) do
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
