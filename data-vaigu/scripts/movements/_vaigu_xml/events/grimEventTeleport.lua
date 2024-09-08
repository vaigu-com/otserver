local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if Game.getStorageValue(ge_stateGlobalStorage) == 2 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Grim Event juz wystartowal.")
		player:teleportTo(fromPosition, true)
		return false
	end

	if Game.getStorageValue(ge_stateGlobalStorage) == 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Grim Event jeszcze nie wystartowal.")
		player:teleportTo(fromPosition, true)
		return false
	end

	if Game.getStorageValue(ge_joinCountGlobalStorage) > ge_maxPlayers then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Grim Event jest pelen! [" .. Game.getStorageValue(geJoinedCountGlobalStorage) .. "/" .. geMaxPlayers .. "]")
		return false
	end

	player:teleportTo(ge_WaitingRoomStartPosition)
	ge_WaitingRoomStartPosition:sendMagicEffect(CONST_ME_TELEPORT)
	Game.setStorageValue(ge_joinCountGlobalStorage, Game.getStorageValue(ge_joinCountGlobalStorage) + 1)
	Game.broadcastMessage(string.format("%s dolaczyl do Grim Eventu! [%s/" .. ge_maxPlayers .. "].", player:getName(), Game.getStorageValue(ge_joinCountGlobalStorage)), MESSAGE_STATUS_DEFAULT)
	player:setStorageValue(ge_joinStorage, 1)
	return true
end
movement:type("stepin")
movement:aid(7001)
movement:register()
