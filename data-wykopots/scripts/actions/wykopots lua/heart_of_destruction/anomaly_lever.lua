-- FUNCTIONS
local function doCheckArea()
	local upConer = { x = 5492, y = 1366, z = 14 } -- upLeftCorner {x = 5492, y = 1366, z = 14}
	local downConer = { x = 5516, y = 1389, z = 14 } -- downRightCorner {x = 5516, y = 1389, z = 14}

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
	local upConer = { x = 5492, y = 1366, z = 14 } -- upLeftCorner
	local downConer = { x = 5516, y = 1389, z = 14 } -- downRightCorner

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
								c:teleportTo({ x = 5327, y = 1379, z = 12 }) --{x = 5327, y = 1379, z = 12}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
end
-- FUNCTIONS END

local heartDestructionAnomaly = Action()
function heartDestructionAnomaly.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		entranceTiles = {
			Position(5478, 1373, 14), --{x = 5478, y = 1373, z = 14}
			Position(5478, 1374, 14),
			Position(5478, 1375, 14),
			Position(5478, 1376, 14),
			Position(5478, 1377, 14),
		},

		newPos = { x = 5504, y = 1385, z = 14 }, --{x = 5504, y = 1385, z = 14}
	}

	local pushPos = { x = 5478, y = 1373, z = 14 }

	if item.actionid == 14325 then
		if item.itemid == 8911 then
			if player:getPosition().x == pushPos.x and player:getPosition().y == pushPos.y and player:getPosition().z == pushPos.z then
				local storePlayers, playerTile = {}
				for i = 1, #config.entranceTiles do
					playerTile = Tile(config.entranceTiles[i]):getTopCreature()
					if isPlayer(playerTile) then
						storePlayers[#storePlayers + 1] = playerTile
					end
				end

				if doCheckArea() == false then
					clearArea()

					local players

					for i = 1, #storePlayers do
						players = storePlayers[i]
						config.entranceTiles[i]:sendMagicEffect(CONST_ME_POFF)
						players:teleportTo(config.newPos)
						players:setStorageValue(14321, os.time() + 20 * 60 * 60)
					end
					Position(config.newPos):sendMagicEffect(11)

					areaAnomaly1 = addEvent(clearArea, 15 * 60000)

					Game.setStorageValue(14322, 0) -- Anomaly Stages

					Game.createMonster("Spark of Destruction", { x = 5500, y = 1381, z = 14 }, false, true) --{x = 5500, y = 1381, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5507, y = 1383, z = 14 }, false, true) --{x = 5507, y = 1383, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5507, y = 1377, z = 14 }, false, true) --{x = 5507, y = 1377, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5500, y = 1377, z = 14 }, false, true) --{x = 5500, y = 1377, z = 14}
					Game.createMonster("Anomaly", { x = 5504, y = 1377, z = 14 }, false, true) --{x = 5504, y = 1377, z = 14}

					local vortex = Tile({ x = 5494, y = 1378, z = 14 }):getItemById(23482) --{x = 5494, y = 1378, z = 14}
					if vortex then
						vortex:transform(2547)
						vortex:setActionId(14324)
					end
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

heartDestructionAnomaly:aid(14325)
heartDestructionAnomaly:register()
