	:Script(function(storageToRequiredState)
local stairTimer = 15

local config = {
	["stairsAreGonna"] = "Stairs are gonna disappear in ",
	["stairsSeconds"] = " seconds.",
	["missingPeople"] = "You need four professions to activate the mechanism.",
	["missingItems"] = "You need four sacrifices to activate the mechanism.",
}

local lever = Action()

local stairsStorage = Storage.DesertQuestOne.Puzzles.BasinPuzzle.Lever

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if Game.getStorageValue(stairsStorage) > os.time() then
		return false
	end
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_BASIN_OFFERINGS, DESERT_QUEST_ONE_ANCHOR) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["missingItems"])
		return false
	end
	if not PlayersPresentAtAllPositions(DESERT_QUEST_ONE_BASIN_PLAYERS, DESERT_QUEST_ONE_ANCHOR) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["missingPeople"])
		return false
	end

	RemoveItems(DESERT_QUEST_ONE_BASIN_OFFERINGS, DESERT_QUEST_ONE_ANCHOR)

	for _, offset in pairs(DESERT_QUEST_ONE_BASIN_PLAYERS) do
		local beneficiary = Tile(DESERT_QUEST_ONE_ANCHOR:Moved(offset)):getTopCreature()
		if beneficiary then
			TryProgressDesertQuest(beneficiary, Storage.DesertQuestOne.QuestState.q3)
		end
	end

	Game.setStorageValue(stairsStorage, os.time() + stairTimer)
	local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_BASIN_OPENING.pos)
	local stairs = Tile(pos):getItemById(DESERT_QUEST_ONE_BASIN_OPENING.sealedId)
	if not stairs then
		return true
	end
	stairs:transform(DESERT_QUEST_ONE_BASIN_OPENING.stairsId)

	local stairsMessage = player:Localizer(Storage.DesertQuestOne.Questline):Get(config["stairsAreGonna"]) .. stairTimer .. player:Localizer(Storage.DesertQuestOne.Questline):Get(config["stairsSeconds"])
	player:say(player:Localizer(Storage.DesertQuestOne.Questline):Get(stairsMessage), TALKTYPE_MONSTER_SAY)
	addEvent(function()
		stairs = Tile(pos):getItemById(DESERT_QUEST_ONE_BASIN_OPENING.stairsId)
		stairs:transform(DESERT_QUEST_ONE_BASIN_OPENING.sealedId)
	end, 1000 * stairTimer)

	return true
end

lever:aid(Storage.DesertQuestOne.Puzzles.BasinPuzzle.Lever)
lever:register()
end)
