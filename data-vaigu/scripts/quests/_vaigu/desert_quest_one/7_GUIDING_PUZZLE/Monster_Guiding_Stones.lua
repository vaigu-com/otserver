	:Script(function(storageToRequiredState)
local function moveStone(creature, dir, item, pos)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local i = pos.y - DESERT_QUEST_ONE_MONSTER_GUIDING.stonesAnchor.y + 1
	RemoveItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.origin[i] }, DESERT_QUEST_ONE_ANCHOR)
	RemoveItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.destination[i] }, DESERT_QUEST_ONE_ANCHOR)

	if dir == "create" then
		CreateItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.destination[i] }, DESERT_QUEST_ONE_ANCHOR)
		item:transform(430)
	elseif dir == "remove" then
		CreateItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.origin[i] }, DESERT_QUEST_ONE_ANCHOR)
		item:transform(431)
	end
end

local enter = MoveEvent()
function enter.onStepIn(creature, item, toPosition, fromPosition)
	moveStone(creature, "create", item, toPosition)
	return true
end
enter:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone)
enter:type("stepin")
enter:register()

local exit = MoveEvent()
function exit.onStepOut(creature, item, position, fromPosition)
	moveStone(creature, "remove", item, fromPosition)
	return true
end
exit:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone)
exit:type("stepout")
exit:register()
end)
