	:Script(function(storageToRequiredState)
local updateStorages = {
	[Storage.PathOfTheUndead.Questline] = 4,
	[Storage.PathOfTheUndead.Mission03] = 2,
}

local exitPos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = 4, y = -32, z = -2 })
local portal = MoveEvent()

function portal.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.PathOfTheUndead.Questline)
	if storageVal == 3 then
		player:UpdateStorages(updateStorages)
	end

	player:teleportTo(exitPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

portal:aid(Storage.PathOfTheUndead.BossRoomExit)
portal:type("stepin")
portal:register()
end)
