local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if math.random(24) == 1 then
		doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -270, -310, CONST_ME_BIGPLANTS)
	end
	return true
end

movement:type("stepin")
movement:id(8292)
movement:register()
