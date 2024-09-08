local function doCheckArea()
	local upConer = { x = 5426, y = 1439, z = 14 } -- upLeftCorner {x = 5426, y = 1439, z = 14}
	local downConer = { x = 5459, y = 1471, z = 14 } -- downRightCorner {x = 5459, y = 1471, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							if isPlayer(c) then
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end

local function clearArea()
	local upConer = { x = 5426, y = 1439, z = 14 } -- upLeftCorner {x = 5426, y = 1439, z = 14}
	local downConer = { x = 5459, y = 1471, z = 14 } -- downRightCorner {x = 5459, y = 1471, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							if isPlayer(c) then
								c:teleportTo({ x = 5512, y = 1484, z = 12 }) --{x = 5512, y = 1484, z = 12}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaCrackler1)
	stopEvent(areaCrackler2)
end

local function createVortex()
	local positions1 = {
		{ x = 5430, y = 1450, z = 14 }, --{x = 5430, y = 1450, z = 14}
		{ x = 5435, y = 1456, z = 14 }, --{x = 5435, y = 1456, z = 14}
		{ x = 5441, y = 1452, z = 14 }, --{x = 5441, y = 1452, z = 14}
		{ x = 5443, y = 1462, z = 14 }, --{x = 5443, y = 1462, z = 14}
	}

	local positions2 = {
		{ x = 5434, y = 1462, z = 14 }, --{x = 5434, y = 1462, z = 14}
		{ x = 5448, y = 1460, z = 14 }, --{x = 5448, y = 1460, z = 14}
		{ x = 5435, y = 1453, z = 14 }, --{x = 5435, y = 1453, z = 14}
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
		{ x = 5451, y = 1456, z = 14 }, --{x = 5451, y = 1456, z = 14}
	}
	local tempo = 15
	if vortexPositions == 0 then
		for i = 1, #positions1 do
			local items = Tile(Position(positions1[i])):getGround()
			items:transform(23471)
			addEvent(function()
				items:transform(23051)
			end, tempo * 1000)
		end
		vortexPositions = 1
	elseif vortexPositions == 1 then
		for i = 1, #positions2 do
			local items = Tile(Position(positions2[i])):getGround()
			items:transform(23471)
			addEvent(function()
				items:transform(23051)
			end, tempo * 1000)
		end
		vortexPositions = 2
	elseif vortexPositions == 2 then
		for i = 1, #positions3 do
			local items = Tile(Position(positions3[i])):getGround()
			items:transform(23471)
			addEvent(function()
				items:transform(23051)
			end, tempo * 1000)
		end
		vortexPositions = 3
	elseif vortexPositions == 3 then
		for i = 1, #positions4 do
			local items = Tile(Position(positions4[i])):getGround()
			items:transform(23471)
			addEvent(function()
				items:transform(23051)
			end, tempo * 1000)
		end
		vortexPositions = 0
	end

	cracklerTransform = false
	areaCrackler2 = addEvent(createVortex, tempo * 1000)
end
-- FUNCTIONS END

local heartDestructionCracklers = Action()
function heartDestructionCracklers.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		entranceTiles = {
			Position(5512, 1478, 12), --{x = 5512, y = 1478, z = 12}
			Position(5512, 1479, 12),
			Position(5512, 1480, 12),
			Position(5512, 1481, 12),
			Position(5512, 1482, 12), --{x = 5512, y = 1482, z = 12}
		},

		newPos = { x = 5452, y = 1453, z = 14 }, --{x = 5452, y = 1453, z = 14}
	}

	local pushPos = { x = 5512, y = 1478, z = 12 }

	if item.actionid == 14326 then
		if item.itemid == 8911 then
			if player:getPosition().x == pushPos.x and player:getPosition().y == pushPos.y and player:getPosition().z == pushPos.z then
				local storePlayers, playerTile = {}
				for i = 1, #config.entranceTiles do
					playerTile = Tile(config.entranceTiles[i]):getTopCreature()
					if isPlayer(playerTile) then
						storePlayers[#storePlayers + 1] = playerTile
					end
				end

				if #storePlayers < 4 then
					player:sendTextMessage(19, "You need at least 4 players for this mission.")
					return true
				end

				if doCheckArea() == false then
					clearArea()

					local players

					for i = 1, #storePlayers do
						players = storePlayers[i]
						config.entranceTiles[i]:sendMagicEffect(CONST_ME_POFF)
						players:teleportTo(config.newPos)
					end
					Position(config.newPos):sendMagicEffect(11)

					areaCrackler1 = addEvent(clearArea, 15 * 60000)

					Game.createMonster("Crackler", { x = 5433, y = 1450, z = 14 }, false, true) --{x = 5433, y = 1450, z = 14}
					Game.createMonster("Crackler", { x = 5440, y = 1451, z = 14 }, false, true) --{x = 5440, y = 1451, z = 14}
					Game.createMonster("Crackler", { x = 5446, y = 1451, z = 14 }, false, true) --{x = 5446, y = 1451, z = 14}
					Game.createMonster("Crackler", { x = 5435, y = 1455, z = 14 }, false, true) --{x = 5435, y = 1455, z = 14}
					Game.createMonster("Crackler", { x = 5441, y = 1455, z = 14 }, false, true) --{x = 5441, y = 1455, z = 14}
					Game.createMonster("Crackler", { x = 5432, y = 1458, z = 14 }, false, true) --{x = 5432, y = 1458, z = 14}
					Game.createMonster("Crackler", { x = 5434, y = 1462, z = 14 }, false, true) --{x = 5434, y = 1462, z = 14}
					Game.createMonster("Crackler", { x = 5440, y = 1463, z = 14 }, false, true) --{x = 5440, y = 1463, z = 14}
					Game.createMonster("Crackler", { x = 5444, y = 1462, z = 14 }, false, true) --{x = 5444, y = 1462, z = 14}
					Game.createMonster("Crackler", { x = 5448, y = 1460, z = 14 }, false, true) --{x = 5448, y = 1460, z = 14}

					Game.setStorageValue(14323, 0) -- Depolarized Cracklers Count
					vortexPositions = 0
					createVortex()
				else
					player:sendTextMessage(19, "Someone is in the area.")
				end
			else
				return true
			end
		end
		item:transform(item.itemid == 8911 and 8912 or 8911)
	end

	return true
end

heartDestructionCracklers:aid(14326)
heartDestructionCracklers:register()
