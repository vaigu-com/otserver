-- FUNCTIONS
local function doCheckArea()
	local upConer = { x = 5557, y = 1368, z = 14 } -- upLeftCorner {x = 5557, y = 1368, z = 14}
	local downConer = { x = 5580, y = 1390, z = 14 } -- downRightCorner {x = 5580, y = 1390, z = 14}

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
	local upConer = { x = 5557, y = 1368, z = 14 } -- upLeftCorner {x = 5557, y = 1368, z = 14}
	local downConer = { x = 5580, y = 1390, z = 14 } -- downRightCorner {x = 5580, y = 1390, z = 14}

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
								c:teleportTo({ x = 5521, y = 1486, z = 12 }) --{x = 5521, y = 1486, z = 12}
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

local heartDestructionRupture = Action()
function heartDestructionRupture.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		playerPositions = {
			Position(5542, 1376, 14), --{x = 5542, y = 1376, z = 14}
			Position(5542, 1377, 14),
			Position(5542, 1378, 14),
			Position(5542, 1379, 14),
			Position(5542, 1380, 14), --{x = 5542, y = 1380, z = 14}
		},

		newPos = { x = 5568, y = 1385, z = 14 }, --{x = 5568, y = 1385, z = 14}
	}

	local pushPos = { x = 5542, y = 1376, z = 14 }

	if item.actionid == 14327 then
		if item.itemid == 8911 then
			if player:getPosition().x == pushPos.x and player:getPosition().y == pushPos.y and player:getPosition().z == pushPos.z then
				local storePlayers, playerTile = {}
				for i = 1, #config.playerPositions do
					playerTile = Tile(config.playerPositions[i]):getTopCreature()
					if isPlayer(playerTile) then
						storePlayers[#storePlayers + 1] = playerTile
					end
				end

				if doCheckArea() == false then
					clearArea()

					local players

					for i = 1, #storePlayers do
						players = storePlayers[i]
						config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
						players:teleportTo(config.newPos)
						players:setStorageValue(14323, os.time() + 20 * 60 * 60)
					end
					Position(config.newPos):sendMagicEffect(11)

					areaRupture1 = addEvent(clearArea, 15 * 60000)

					ruptureResonanceStage = 0
					resonanceActive = false

					Game.createMonster("Spark of Destruction", { x = 5563, y = 1375, z = 14 }, false, true) --{x = 5563, y = 1375, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5565, y = 1382, z = 14 }, false, true) --{x = 5565, y = 1382, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5573, y = 1382, z = 14 }, false, true) --{x = 5573, y = 1382, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5571, y = 1374, z = 14 }, false, true) --{x = 5571, y = 1374, z = 14}
					Game.createMonster("Rupture", { x = 5571, y = 1378, z = 14 }, false, true) --{x = 5571, y = 1378, z = 14}

					local vortex = Tile({ x = 5559, y = 1378, z = 14 }):getItemById(23482) --{x = 5559, y = 1378, z = 14}
					if vortex then
						vortex:transform(23483)
						vortex:setActionId(14343)
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

heartDestructionRupture:aid(14327)
heartDestructionRupture:register()
