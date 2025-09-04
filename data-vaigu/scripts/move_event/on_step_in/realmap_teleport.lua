Storage.RealMapTeleport = {
	ToDeepling = {},
	FromDeepling = {},
}
local keyToDestination = {
	[Storage.RealMapTeleport.ToDeepling] = Position(33514, 31323, 8),
	[Storage.RealMapTeleport.FromDeepling] = Position(6779, 2563, 7),
}

local keyToAnimate = {
	[Storage.RealMapTeleport.FromDeepling] = true,
}

local realMapTeleport = MoveEvent()
function realMapTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local destination = keyToDestination[item:getKey()]
	if not destination then
		return
	end

	local shouldAnimate = keyToAnimate[item:getKey()]
	if shouldAnimate then
		player:teleportTo(destination)
	else
		player:teleportTo(destination, true)
	end
	return true
end
realMapTeleport:type("stepin")
for _, key in pairs(Storage.RealMapTeleport) do
	realMapTeleport:key(key)
end
realMapTeleport:register()
