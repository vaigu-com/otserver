local movements_library_mazzinor = MoveEvent()

function movements_library_mazzinor.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()

	if not player then
		return true
	end

	if player:getStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.HauntedHouse.Questline) == 1 then
		if creature:getOutfit().lookType == 19 and player:getItemCount(29310) >= 1 then
			player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.HauntedHouse.FacelessBaneAccess, ACCESS_GRANTED)
			player:teleportTo(Position(32727, 32280, 8))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:removeCondition(CONDITION_OUTFIT)
			player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.HauntedHouse.Questline, 2)
		end
	end

	return true
end

movements_library_mazzinor:aid(23102)
movements_library_mazzinor:register()
