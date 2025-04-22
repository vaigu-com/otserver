local movements_crackedTile = MoveEvent()

function movements_crackedTile.onStepIn(creature, item, position, fromPosition)
	local player = Player(creature:getId())

	if not player then
		return true
	end

	local min = player:getMaxHealth() * 0.2
	local max = player:getMaxHealth() * 0.5

<<<<<<< HEAD
	doTargetCombat(0, player, COMBAT_DEATHDAMAGE, -min, -max, CONST_ME_MORTAREA, ORIGIN_NONE)
=======
	doTargetCombatHealth(0, player, COMBAT_DEATHDAMAGE, -min, -max, CONST_ME_MORTAREA, ORIGIN_NONE)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a

	return true
end

movements_crackedTile:aid(23106)
movements_crackedTile:register()
