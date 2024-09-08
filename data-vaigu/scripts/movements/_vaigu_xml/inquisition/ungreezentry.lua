local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local destination = Position(6729, 1111, 11)
	if player:getStorageValue(Storage.TheInquisition.Questline) >= 18 then
		if player:removeItem(6499, 1) then
			player:teleportTo(destination) --{x = 7107, y = 1657, z = 13}
			destination:sendMagicEffect(CONST_ME_PURPLEENERGY)
		else
			player:teleportTo(fromPosition) --{x = 6730, y = 1281, z = 8}
			doTargetCombatHealth(0, player, COMBAT_ENERGYDAMAGE, -60, -80, CONST_ME_PURPLEENERGY)
			player:say("ODEJDZ!!", TALKTYPE_MONSTER_SAY)
		end
	else
		player:teleportTo(fromPosition) --{x = 6730, y = 1281, z = 8}
		doTargetCombatHealth(0, player, COMBAT_ENERGYDAMAGE, -60, -80, CONST_ME_PURPLEENERGY)
		player:say("ODEJDZ!!", TALKTYPE_MONSTER_SAY)
	end
	return true
end
movement:type("stepin")
movement:aid(45793)
movement:register()
