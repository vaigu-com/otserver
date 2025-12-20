local ladderPosition = Position(6156, 1886, 11)
local ladderStepIn = MoveEvent()

function ladderStepIn.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local ladderItem = Tile(ladderPosition):getItemById(5542)
	if not ladderItem then
		Game.createItem(5542, 1, ladderPosition)
		player:say("You hear a rumbling from far away.", TALKTYPE_MONSTER_SAY, false, player)
	end
	return item:transform(item.itemid - 1)
end

ladderStepIn:type("stepin")
ladderStepIn:uid(2002)
ladderStepIn:register()

local ladderStepOut = MoveEvent()

function ladderStepOut.onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local ladder = Tile(ladderPosition):getItemById(5542)
	if ladder then
		ladder:remove()
		player:say("You hear a rumbling from far away.", TALKTYPE_MONSTER_SAY, false, player)
	end
	return item:transform(item.itemid + 1)
end

ladderStepOut:type("stepout")
ladderStepOut:uid(2002)
ladderStepOut:register()
