local destination = {
	[3140] = { position = Position(7409, 1422, 9), storageValue = 1, needCrystal = true, access = Storage.BigfootBurden.Warzone1Access }, --WARZONE 1 7409, 1422, 9
	[3141] = { position = Position(7424, 1443, 10), storageValue = 2, needCrystal = true, access = Storage.BigfootBurden.Warzone2Access }, --WARZONE 2 7424, 1443, 10
	[3142] = { position = Position(7402, 1409, 11), storageValue = 3, needCrystal = true, access = Storage.BigfootBurden.Warzone3Access }, --WARZONE 3 7402, 1409, 11
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleportCrystal = destination[item.actionid]
	if not teleportCrystal then
		return
	end

	if player:getStorageValue(Storage.BigfootBurden.WarzoneStatus) >= teleportCrystal.storageValue then
		if player:getStorageValue(teleportCrystal.access) == 1 then
			player:teleportTo(teleportCrystal.position)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			if not teleportCrystal.needCrystal or player:removeItem(16242, 1) then
				player:teleportTo(teleportCrystal.position)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			else
				player:teleportTo(fromPosition)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Aby uzyc potrzebujesz krysztalu teleportacyjnego.")
			end
			return true
		end
	else
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie posiadasz uprawnien!")
		return true
	end
end
movement:type("stepin")
movement:aid(3140, 3141, 3142)
movement:register()
