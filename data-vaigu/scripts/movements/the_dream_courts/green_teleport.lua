local setting = {
	[7923] = Position(6324, 1888, 13), -- from zielony
}

local greenteleport = MoveEvent()

function greenteleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = setting[item.actionid]
	if not targetPosition then
		return true
	end

	if player:getStorageValue(Storage.TheDreamCourts.RosebushPlant) == 1 then
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition)
		player:sendCancelMessage("You dont have permission to use this portal.")
	end
	return true
end

greenteleport:type("stepin")

for index, value in pairs(setting) do
	greenteleport:aid(index)
end

greenteleport:register()
