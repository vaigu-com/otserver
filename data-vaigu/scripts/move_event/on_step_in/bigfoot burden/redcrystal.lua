local destination = {
	[3140] = { position = Position(6383, 2536, 10), cooldownStorage = Storage.BigfootsBurden.Warzone1Cooldown }, --WARZONE 1 7409, 1422, 9
	[3141] = { position = Position(6398, 2557, 11), cooldownStorage = Storage.BigfootsBurden.Warzone2Cooldown }, --WARZONE 2 7424, 1443, 10
	[3142] = { position = Position(6376, 2523, 12), cooldownStorage = Storage.BigfootsBurden.Warzone3Cooldown }, --WARZONE 3 7402, 1409, 11
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already killed this boss today")
	else
		player:teleportTo(teleportData.position)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
end
movement:type("stepin")
movement:aid(3140, 3141, 3142)
movement:register()
