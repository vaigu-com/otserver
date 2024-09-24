	:Script(function(storageToRequiredState)
local config = {
	["youHearStones"] = "You hear stones rumbling nearby",
}

local gravestone = Action()

function gravestone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_CASTLE_TORCHES_UNLIT, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end

	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_CASTLE_WALLS, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end

	RemoveItems(DESERT_QUEST_ONE_CASTLE_TORCHES_UNLIT, DESERT_QUEST_ONE_ANCHOR)
	RemoveItems(DESERT_QUEST_ONE_CASTLE_TORCHES_LIT, DESERT_QUEST_ONE_ANCHOR)
	CreateItems(DESERT_QUEST_ONE_CASTLE_TORCHES_LIT, DESERT_QUEST_ONE_ANCHOR)

	player:say(config["youHearStones"], TALKTYPE_MONSTER_SAY)

	local portal
	addEvent(function()
		RemoveItems(DESERT_QUEST_ONE_CASTLE_WALLS, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_CASTLE_NEW_WALLS, DESERT_QUEST_ONE_ANCHOR)
		portal = Game.createItem(1949, 1, DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_CASTLE_WALLS[2].offPos))
		portal:setActionId(Storage.DesertQuestOne.QuestState.q5)
	end, 1000 * 5)
	addEvent(function()
		portal:remove()
		RemoveItems(DESERT_QUEST_ONE_CASTLE_NEW_WALLS, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_CASTLE_WALLS, DESERT_QUEST_ONE_ANCHOR)
	end, 1000 * 65)

	return true
end

gravestone:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Gravestone)
gravestone:register()
end)
