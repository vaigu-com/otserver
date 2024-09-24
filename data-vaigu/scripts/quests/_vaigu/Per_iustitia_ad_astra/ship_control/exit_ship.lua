	:Script(function(storageToRequiredState)
local function getDestination(aid)
	local toPos = SPACESHIP_AID_TO_POS[aid]
	if not toPos then
		return false
	end
	return toPos
end

local exitDevice = MoveEvent()

function exitDevice.onStepIn(player, _, _, _)
	if not player:isPlayer() then
		return false
	end

	local aid = player:getStorageValue(Storage.PerIustitiaAdAstra.ShipControl.Current)
	local toPos = getDestination(aid)
	if not toPos then
		return
	end

	player:teleportTo(toPos)
	toPos:sendMagicEffect(CONST_ME_TELEPORT)
end

exitDevice:aid(Storage.PerIustitiaAdAstra.ShipControl.Exit)
exitDevice:register()
end)
