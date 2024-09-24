local config = {
	["youHaveSeconds"] = "You have 60 seconds to walk though the gate",
}

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_MOVED, DESERT_QUEST_ONE_ANCHOR) then
		return
	end

	item:transform(DESERT_QUEST_ONE_LEVER_SWAP_LIST[item.itemid])

	RemoveItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_MOVED, DESERT_QUEST_ONE_ANCHOR)
	RemoveItems(DESERT_QUEST_ONE_IRON_WALL, DESERT_QUEST_ONE_ANCHOR)
	CreateItems(DESERT_QUEST_ONE_KEY_BOW_HORIZONTAL, DESERT_QUEST_ONE_ANCHOR)

	player:say(player:Localizer(Storage.DesertQuestOne.Questline):Get(config["youHaveSeconds"]), TALKTYPE_MONSTER_SAY)

	addEvent(function()
		RemoveItems(DESERT_QUEST_ONE_KEY_BOW_HORIZONTAL, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_SPAWN_KEY_SHAFT, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_UNMOVED, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_IRON_WALL, DESERT_QUEST_ONE_ANCHOR)
		local plaque_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = 15, y = 0, z = 0 })
		local plaque = Game.createItem(2023, 1, plaque_pos)
		plaque:setText("0xB6A")
	end, 1000 * 60)

	return true
end

lever:aid(Storage.DesertQuestOne.Puzzles.KeyshaftPuzzle.LeverTurn)
lever:register()
