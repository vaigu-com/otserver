local teleportData = {
	[45701] = Position(6482, 2569, 10),
	[45702] = Position(6491, 2568, 11),
	[45703] = Position(6468, 2517, 12),
}

local spawnLockData = {
	[45701] = SpawnLocks.BigfootsBurden.Warzone1,
	[45702] = SpawnLocks.BigfootsBurden.Warzone3,
	[45703] = SpawnLocks.BigfootsBurden.Warzone2,
}

local movement = MoveEvent()
function movement.onStepIn(creature, item, toPosition, fromPosition)
	if not creature:isPlayer() then
		creature:teleportTo(fromPosition)
		return false
	end

	local teleporterAid = item:getActionId()

	local destination, spawnLock = teleportData[teleporterAid], spawnLockData[teleporterAid]
	if not (destination and spawnLock) then
		return false
	end

	creature:teleportTo(destination)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
movement:type("stepin")
movement:aid(45701, 45702, 45703)
movement:register()
