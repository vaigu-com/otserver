local function chargerSpawn(pos)
	Game.createMonster("charger", pos, false, true)
	spawningCharge = false
	return true
end

local chargerSpawn = CreatureEvent("ChargerSpawn")
function chargerSpawn.onDeath(creature)
	local positions = {
		{ x = 5384, y = 1484, z = 14 },
		{ x = 5386, y = 1489, z = 14 },
		{ x = 5387, y = 1481, z = 14 },
		{ x = 5389, y = 1485, z = 14 },
		{ x = 5391, y = 1478, z = 14 },
		{ x = 5391, y = 1490, z = 14 },
		{ x = 5392, y = 1482, z = 14 },
		{ x = 5394, y = 1488, z = 14 },
		{ x = 5395, y = 1480, z = 14 },
		{ x = 5396, y = 1484, z = 14 },
	}

	local pos = positions[math.random(1, #positions)]
	addEvent(chargerSpawn, 6000, pos)
	spawningCharge = true
	return true
end

--chargerSpawn:register()
