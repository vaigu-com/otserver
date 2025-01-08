local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if Game.getStorageValueByKey(ge_stateStorage) == 2 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Grim Event juz wystartowal.")
		player:teleportTo(fromPosition, true)
		return false
	end

	if Game.getStorageValueByKey(ge_stateStorage) == 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Grim Event jeszcze nie wystartowal.")
		player:teleportTo(fromPosition, true)
		return false
	end

	if Game.getStorageValueByKey(ge_joinCountStorage) > ge_maxPlayers then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Grim Event jest pelen! [" .. Game.getStorageValueByKey(geJoinedCountStorage) .. "/" .. geMaxPlayers .. "]")
		return false
	end

	player:teleportTo(ge_WaitingRoomStartPosition)
	ge_WaitingRoomStartPosition:sendMagicEffect(CONST_ME_TELEPORT)
	Game.setStorageValueByKey(ge_joinCountStorage, Game.getStorageValueByKey(ge_joinCountStorage) + 1)
	Game.broadcastMessage(string.format("%s dolaczyl do Grim Eventu! [%s/" .. ge_maxPlayers .. "].", player:getName(), Game.getStorageValueByKey(ge_joinCountStorage)), MESSAGE_STATUS_DEFAULT)
	player:setStorageValueByKey(ge_joinStorage, 1)
	return true
end
movement:type("stepin")
movement:aid(7001)
movement:register()
