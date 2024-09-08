local setting = {
	[7922] = Position(6282, 1834, 13), -- from elfy
	[7928] = Position(6323, 1979, 13), -- to dram scar
}

local dreamcourtteleport = MoveEvent()

function dreamcourtteleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = setting[item.actionid]
	if not targetPosition then
		return true
	end

	if player:getStorageValue(Storage.TheDreamCourts.QuestLine) >= 3 then -- dream storage
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition)
		player:sendCancelMessage("You dont have permission to use this portal.")
	end
	return true
end

dreamcourtteleport:type("stepin")

for index, value in pairs(setting) do
	dreamcourtteleport:aid(index)
end

dreamcourtteleport:register()
