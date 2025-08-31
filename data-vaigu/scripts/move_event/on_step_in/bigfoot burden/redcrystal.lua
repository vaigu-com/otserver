local destination = {
	[3140] = { position = Position(32997, 31922, 10), cooldownStorage = Storage.BigfootsBurden.Warzone1Cooldown },
	[3141] = { position = Position(33012, 31943, 11), cooldownStorage = Storage.BigfootsBurden.Warzone2Cooldown },
	[3142] = { position = Position(32990, 31909, 12), cooldownStorage = Storage.BigfootsBurden.Warzone3Cooldown },
}

local movement = MoveEvent()
function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleportData = destination[item.actionid]
	if not teleportData then
		return
	end

	if player:getStorageValueByKey(teleportData.cooldownStorage) >= os.time() then
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already killed this boss this week")
	else
		player:teleportTo(teleportData.position)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
end
movement:type("stepin")
movement:aid(3140, 3141, 3142)
movement:register()
