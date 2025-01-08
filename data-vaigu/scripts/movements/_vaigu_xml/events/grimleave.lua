local depo = Position(5893, 1548, 9)
--local ge_joinCountStorage = Game.getStorageValueByKey(ge_joinCountStorage)

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(depo)
	depo:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Opusciles event!")
	setStorageValueByKey(Storage.GrimEventPlayerCount, getStorageValueByKey(Storage.GrimEventPlayerCount) - 1)
	player:setStorageValueByKey(ge_joinStorage, 0)
	Game.broadcastMessage(string.format("%s opuscil Grim Event! [%s/" .. ge_maxPlayers .. "].", player:getName(), Game.getStorageValueByKey(ge_joinCountStorage)), MESSAGE_STATUS_DEFAULT)
end
movement:type("stepin")
movement:aid(25004)
movement:register()
