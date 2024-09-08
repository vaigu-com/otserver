local corymPoison = MoveEvent()

function corymPoison.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -50, -250, CONST_ME_HITBYPOISON)
	return true
end

corymPoison:type("stepin")
corymPoison:aid(11051)
corymPoison:register()
