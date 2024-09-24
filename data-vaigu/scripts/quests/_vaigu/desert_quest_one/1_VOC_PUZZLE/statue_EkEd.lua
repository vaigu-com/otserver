	:Script(function(storageToRequiredState)
local config = {
	["disappeared"] = "The magic walls disappeared for one minute",
}

local statue = Action()

function statue.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_EK_ED_STATUES, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_EK_ED_MWALLS, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end
	if fromPosition.y <= player:getPosition().y then
		return false
	end

	RemoveItems(DESERT_QUEST_ONE_EK_ED_STATUES, DESERT_QUEST_ONE_ANCHOR)
	RemoveItems(DESERT_QUEST_ONE_EK_ED_MWALLS, DESERT_QUEST_ONE_ANCHOR)
	RemoveItems(DESERT_QUEST_ONE_EK_ED_SPAWN_STATUES, DESERT_QUEST_ONE_ANCHOR)

	player:say(config["disappeared"], TALKTYPE_MONSTER_SAY)

	addEvent(function()
		CreateItems(DESERT_QUEST_ONE_EK_ED_MWALLS, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_EK_ED_SPAWN_STATUES, DESERT_QUEST_ONE_ANCHOR)
		ChangeItemsActionId(DESERT_QUEST_ONE_EK_ED_SPAWN_STATUES, 1000, DESERT_QUEST_ONE_ANCHOR)
	end, 60 * 1000)
	return true
end

statue:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.EkEdStatue)
statue:register()
end)
