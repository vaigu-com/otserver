	:Script(function(storageToRequiredState)
local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_KEY_SHAFT_COMBINATION, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end

	item:transform(DESERT_QUEST_ONE_LEVER_SWAP_LIST[item.itemid])

	RemoveItems(DESERT_QUEST_ONE_KEY_SHAFT_COMBINATION, DESERT_QUEST_ONE_ANCHOR)
	RemoveItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_UNMOVED, DESERT_QUEST_ONE_ANCHOR)
	CreateItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_MOVED, DESERT_QUEST_ONE_ANCHOR)

	local plaque_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = 15, y = 0, z = 0 })
	Tile(plaque_pos):getItemById(2023):remove()
	return true
end

lever:aid(Storage.DesertQuestOne.Puzzles.KeyshaftPuzzle.LeverPutIn)
lever:register()
end)
