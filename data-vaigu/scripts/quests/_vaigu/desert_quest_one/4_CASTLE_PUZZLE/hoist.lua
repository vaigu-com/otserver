	:Script(function(storageToRequiredState)
local elevatorToUp = Action()

function elevatorToUp.onUse(creature, item, fromPosition, itemEx, toPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end

	local up = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_HOIST["up"])

	player:teleportTo(up)

	player:getPosition():sendMagicEffect(CONST_ME_POFF)

	return true
end

elevatorToUp:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.ElevatorToUp)
elevatorToUp:register()

local elevatorToDown = Action()

function elevatorToDown.onUse(creature, item, fromPosition, itemEx, toPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end

	local down = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_HOIST["down"])
	player:teleportTo(down)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)

	return true
end

elevatorToDown:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.ElevatorToDown)
elevatorToDown:register()
end)
