local destinations = {
	[28810] = Position(6140, 1869, 9),
	[28811] = Position(6141, 1885, 9),
	[28812] = Position(6146, 1875, 9),
	[28813] = Position(6149, 1872, 9),
	[28814] = Position(6158, 1871, 9),
	[28815] = Position(6129, 1873, 9),
	[28816] = Position(6142, 1882, 9),
	[28817] = Position(6157, 1861, 9),
	[28818] = Position(6159, 1872, 9),
	[28819] = Position(6158, 1854, 9),
	[28820] = Position(6145, 1878, 9),
	[28821] = Position(6163, 1885, 9),
	[28822] = Position(6143, 1888, 9),
	[28823] = Position(6149, 1852, 9),
	[28824] = Position(6156, 1888, 9),
	[28825] = Position(6157, 1869, 9),
	[28826] = Position(6143, 1888, 9),
	[28827] = Position(6163, 1882, 9),
	[28828] = Position(6129, 1879, 9),
	[28829] = Position(6160, 1861, 9),
	[28830] = Position(6163, 1866, 9),
	[28831] = Position(6157, 1886, 9),
	[28832] = Position(6157, 1885, 9),
	[28833] = Position(6157, 1883, 9),
	[28834] = Position(6157, 1884, 9),
}

local tileTeleport = MoveEvent()

function tileTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(destinations[item.actionid])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tileTeleport:type("stepin")

for index, value in pairs(destinations) do
	tileTeleport:aid(index)
end

tileTeleport:register()
