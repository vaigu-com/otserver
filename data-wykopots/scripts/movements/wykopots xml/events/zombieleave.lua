local depo = Position(5893, 1548, 9)
--local ze_joinCountGlobalStorage = Game.getStorageValue(ze_joinCountGlobalStorage)

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(depo)
	depo:sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "Opusciles event!")
	setGlobalStorageValue(GlobalStorage.ZEPlayerCount, getGlobalStorageValue(GlobalStorage.ZEPlayerCount) - 1)
	player:setStorageValue(ze_joinStorage, 0)
	Game.broadcastMessage(string.format("%s opuscil event Zombie! [%s/" .. ze_maxPlayers .. "].", player:getName(), Game.getStorageValue(ze_joinCountGlobalStorage)), MESSAGE_STATUS_DEFAULT)
end
movement:type("stepin")
movement:aid(25003)
movement:register()
