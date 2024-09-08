local setting = {
	[48060] = Position(5371, 1464, 12), -- from pustynia --{x = 5370, y = 1464, z = 12}
	[48061] = Position(6842, 1264, 3), -- to pustynia --{x = 6842, y = 1264, z = 3}
	[48064] = Position(5382, 1426, 12), -- to ankrah {x = 5382, y = 1426, z = 12} </\
	[48065] = Position(5334, 1384, 12), -- from ankrah {x = 5334, y = 1384, z = 12}
	[48066] = Position(5445, 1387, 12), -- to svargrond {x = 5445, y = 1387, z = 12} >/\
	[48067] = Position(5492, 1381, 12), -- from svargrond {x = 5445, y = 1387, z = 12}
	[48068] = Position(5456, 1479, 12), -- to farmine {x = 5456, y = 1479, z = 12} >\/
	[48069] = Position(5499, 1484, 12), -- from farmine {x = 5499, y = 1484, z = 12}
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = setting[item.actionid]
	if not targetPosition then
		return true
	end

	if player:getLevel() >= 130 then
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(Position(6842, 1264, 3)) --6842, 1264, 3
		player:sendCancelMessage("You need at least 130 level to enter here.")
	end
	return true
end

teleport:type("stepin")

for index, value in pairs(setting) do
	teleport:aid(index)
end

teleport:register()
