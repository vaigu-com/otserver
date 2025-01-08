local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if Game.getStorageValueByKey(ze_stateStorage) == 2 then --jak event trwa
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Zombie Event juz wystartowal.")
		player:teleportTo(fromPosition, true) --nie mozna wejsc
		return false
	end

	if Game.getStorageValueByKey(ze_stateStorage) == 0 then --jak eventu nie ma
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Zombie Event jeszcze nie wystartowal.")
		player:teleportTo(fromPosition, true) --nie mozna wejsc
		return false
	end

	if Game.getStorageValueByKey(ze_joinCountStorage) > ze_maxPlayers then --jak dolaczylo wiecej ludzi niz limit
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Zombie Event jest pelen! [" .. Game.getStorageValueByKey(zeJoinedCountStorage) .. "/" .. zeMaxPlayers .. "]")
		player:teleportTo(fromPosition, true) --nie mozna wejsc
		return false
	end

	player:teleportTo(ze_WaitingRoomStartPosition) -- teleport do poczekalni
	ze_WaitingRoomStartPosition:sendMagicEffect(CONST_ME_TELEPORT) -- efekt teleportu
	Game.setStorageValueByKey(ze_joinCountStorage, Game.getStorageValueByKey(ze_joinCountStorage) + 1) -- licznik graczy +1
	Game.broadcastMessage(string.format("%s dolaczyl do eventu Zombie! [%s/" .. ze_maxPlayers .. "].", player:getName(), Game.getStorageValueByKey(ze_joinCountStorage)), MESSAGE_STATUS_DEFAULT) --tekst w grze
	player:setStorageValueByKey(ze_joinStorage, 1) -- nadanie graczowi ze bierze udzial
	return true
end
movement:type("stepin")
movement:aid(7000)
movement:register()
