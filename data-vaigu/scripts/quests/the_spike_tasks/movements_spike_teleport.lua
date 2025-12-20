local actionIdToTeleportData = {
	[4226] = { destination = Position(32243, 32598, 8) },
	[4227] = { destination = Position(6445, 1836, 10) },
	[4228] = { destination = Position(32228, 32596, 8) },
	[4229] = { destination = Position(32237, 32605, 8) },
	[4230] = { destination = Position(32243, 32619, 9) },
	[4231] = { destination = Position(32237, 32605, 9) },
	[4232] = { destination = Position(32240, 32620, 10) },
	[4233] = { destination = Position(32237, 32605, 10) },
	[4234] = { destination = Position(32227, 32598, 11) },
	[4235] = { destination = Position(32237, 32605, 11) },
	[4236] = { destination = Position(32238, 32622, 12) },
	[4237] = { destination = Position(32237, 32605, 12) },
	[4238] = { destination = Position(32244, 32619, 13) },
	[4239] = { destination = Position(32237, 32605, 13) },
	[4240] = { destination = Position(32244, 32588, 14) },
	[4241] = { destination = Position(32237, 32605, 14) },
	[4242] = { destination = Position(32224, 32606, 15) },
	[4243] = { destination = Position(32237, 32605, 15) },
}

local spikeTeleport = MoveEvent()

function spikeTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPortal = actionIdToTeleportData[item.actionid]
	if not targetPortal then
		return true
	end

	player:teleportTo(targetPortal.destination)
	return true
end

spikeTeleport:type("stepin")

for actionId in pairs(actionIdToTeleportData) do
	spikeTeleport:aid(actionId)
end

spikeTeleport:register()
