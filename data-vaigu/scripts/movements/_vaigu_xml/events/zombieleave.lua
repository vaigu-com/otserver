local depo = Position(5893, 1548, 9)
--local ze_joinCountStorage = Game.getStorageValueByKey(ze_joinCountStorage)

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(depo)
	depo:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Opusciles event!")
	setStorageValueByKey(Storage.ZEPlayerCount, getStorageValueByKey(Storage.ZEPlayerCount) - 1)
	player:setStorageValueByKey(ze_joinStorage, 0)
	Game.broadcastMessage(string.format("%s opuscil event Zombie! [%s/" .. ze_maxPlayers .. "].", player:getName(), Game.getStorageValueByKey(ze_joinCountStorage)), MESSAGE_STATUS_DEFAULT)
end
movement:type("stepin")
movement:aid(25003)
movement:register()
