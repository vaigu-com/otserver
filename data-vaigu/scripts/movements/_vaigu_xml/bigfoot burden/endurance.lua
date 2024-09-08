local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 2000)
condition:setFormula(-0.9, 0, -0.9, 0)

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item.actionid == 7816 then
		local chance = math.random(5)
		if chance == 1 then
			player:teleportTo(fromPosition)
		elseif chance == 2 then
			player:teleportTo(fromPosition:Moved(0, 1, 0), true)
			player:setDirection(DIRECTION_SOUTH)
		elseif chance == 3 then
			player:addCondition(condition)
		end
	elseif item.actionid == 7817 then
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 11)
		player:teleportTo(Position(7287, 1350, 9)) --{x = 7287, y = 1350, z = 9}
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You passed endurance test.")
	elseif item.actionid == 7818 then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 10 then
			player:teleportTo(Position(7286, 1350, 10)) --{x = 7286, y = 1350, z = 10}
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:teleportTo(fromPosition)
		end
	end
	return true
end

movement:type("stepin")
movement:aid(7816, 7817, 7818)
movement:register()
