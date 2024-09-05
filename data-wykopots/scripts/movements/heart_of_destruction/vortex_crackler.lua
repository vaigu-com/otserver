local positions1 = {
	{ x = 5430, y = 1450, z = 14 }, --{x = 5430, y = 1450, z = 14}
	{ x = 5435, y = 1456, z = 14 }, --{x = 5435, y = 1456, z = 14}
	{ x = 5441, y = 1452, z = 14 }, --{x = 5441, y = 1452, z = 14}
	{ x = 5443, y = 1462, z = 14 }, --{x = 5443, y = 1462, z = 14}
}

local positions2 = {
	{ x = 5435, y = 1453, z = 14 }, --{x = 5435, y = 1453, z = 14}
	{ x = 5434, y = 1462, z = 14 }, --{x = 5434, y = 1462, z = 14}
	{ x = 5448, y = 1462, z = 14 }, --{x = 5448, y = 1462, z = 14}
	{ x = 5441, y = 1448, z = 14 }, --{x = 5441, y = 1448, z = 14}
}

local positions3 = {
	{ x = 5432, y = 1457, z = 14 }, --{x = 5432, y = 1457, z = 14}
	{ x = 5440, y = 1463, z = 14 }, --{x = 5440, y = 1463, z = 14}
	{ x = 5441, y = 1455, z = 14 }, --{x = 5441, y = 1455, z = 14}
	{ x = 5446, y = 1450, z = 14 }, --{x = 5446, y = 1450, z = 14}
}

local positions4 = {
	{ x = 5436, y = 1447, z = 14 }, --{x = 5436, y = 1447, z = 14}
	{ x = 5438, y = 1453, z = 14 }, --{x = 5438, y = 1453, z = 14}
	{ x = 5445, y = 1458, z = 14 }, --{x = 5445, y = 1458, z = 14}
	{ x = 5452, y = 1456, z = 14 }, --{x = 5452, y = 1456, z = 14}
}

local vortexCrackler = MoveEvent()

function vortexCrackler.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item.itemid == 23471 then
		if vortexPositions == 1 then
			local storePlayers, playerTile = {}
			for i = 1, #positions1 do
				playerTile = Tile(positions1[i]):getTopCreature()
				if playerTile:isPlayer() then
					storePlayers[#storePlayers + 1] = playerTile
				end
			end
			if #storePlayers == #positions1 then
				cracklerTransform = true
			end
		elseif vortexPositions == 2 then
			local storePlayers, playerTile = {}
			for i = 1, #positions2 do
				playerTile = Tile(positions2[i]):getTopCreature()
				if playerTile:isPlayer() then
					storePlayers[#storePlayers + 1] = playerTile
				end
			end
			if #storePlayers == #positions2 then
				cracklerTransform = true
			end
		elseif vortexPositions == 3 then
			local storePlayers, playerTile = {}
			for i = 1, #positions3 do
				playerTile = Tile(positions3[i]):getTopCreature()
				if playerTile:isPlayer() then
					storePlayers[#storePlayers + 1] = playerTile
				end
			end
			if #storePlayers == #positions3 then
				cracklerTransform = true
			end
		elseif vortexPositions == 0 then
			local storePlayers, playerTile = {}
			for i = 1, #positions4 do
				playerTile = Tile(positions4[i]):getTopCreature()
				if playerTile:isPlayer() then
					storePlayers[#storePlayers + 1] = playerTile
				end
			end
			if #storePlayers == #positions4 then
				cracklerTransform = true
			end
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your presence begins to polarize the area!")
		player:getPosition():sendMagicEffect(48)
	end
	return true
end

vortexCrackler:type("stepin")
vortexCrackler:id(23471)
--vortexCrackler:register()

vortexCrackler = MoveEvent()

function vortexCrackler.onStepOut(creature, item, position, fromPosition)
	cracklerTransform = false
	return true
end

vortexCrackler:type("stepout")
vortexCrackler:id(23471)
--vortexCrackler:register()
