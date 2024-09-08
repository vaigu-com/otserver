local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if Game.getStorageValue(ze_stateGlobalStorage) == 2 then --jak event trwa
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Zombie Event juz wystartowal.")
		player:teleportTo(fromPosition, true) --nie mozna wejsc
		return false
	end

	if Game.getStorageValue(ze_stateGlobalStorage) == 0 then --jak eventu nie ma
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Zombie Event jeszcze nie wystartowal.")
		player:teleportTo(fromPosition, true) --nie mozna wejsc
		return false
	end

	if Game.getStorageValue(ze_joinCountGlobalStorage) > ze_maxPlayers then --jak dolaczylo wiecej ludzi niz limit
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Zombie Event jest pelen! [" .. Game.getStorageValue(zeJoinedCountGlobalStorage) .. "/" .. zeMaxPlayers .. "]")
		player:teleportTo(fromPosition, true) --nie mozna wejsc
		return false
	end

	player:teleportTo(ze_WaitingRoomStartPosition) -- teleport do poczekalni
	ze_WaitingRoomStartPosition:sendMagicEffect(CONST_ME_TELEPORT) -- efekt teleportu
	Game.setStorageValue(ze_joinCountGlobalStorage, Game.getStorageValue(ze_joinCountGlobalStorage) + 1) -- licznik graczy +1
	Game.broadcastMessage(string.format("%s dolaczyl do eventu Zombie! [%s/" .. ze_maxPlayers .. "].", player:getName(), Game.getStorageValue(ze_joinCountGlobalStorage)), MESSAGE_STATUS_DEFAULT) --tekst w grze
	player:setStorageValue(ze_joinStorage, 1) -- nadanie graczowi ze bierze udzial
	return true
end
movement:type("stepin")
movement:aid(7000)
movement:register()
