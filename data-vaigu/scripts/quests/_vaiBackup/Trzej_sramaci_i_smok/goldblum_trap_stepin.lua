local goldBlumTrap = MoveEvent()

function goldBlumTrap.onStepIn(player, item, position, fromPosition)
	if not player:isPlayer() then
		return true
	end

	if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline) < 1 then
		return false
	end
	player:teleportTo(player:getPosition():Moved(0, 0, 1))
	player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
	return true
end

goldBlumTrap:type("stepin")
goldBlumTrap:aid(Storage.ThreeSramatiansAndTheDragon.GoldblumTrap)
goldBlumTrap:register()
