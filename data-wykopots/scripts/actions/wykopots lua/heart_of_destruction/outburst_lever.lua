-- FUNCTIONS
local function doCheckArea()
	local upConer = { x = 5456, y = 1402, z = 14 } -- upLeftCorner {x = 5456, y = 1402, z = 14}
	local downConer = { x = 5479, y = 1424, z = 14 } -- downRightCorner {x = 5479, y = 1424, z = 14}

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
	local upConer = { x = 5456, y = 1402, z = 14 } -- upLeftCorner {x = 5456, y = 1402, z = 14}
	local downConer = { x = 5479, y = 1424, z = 14 } -- downRightCorner {x = 5479, y = 1424, z = 14}

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
								c:teleportTo({ x = 5441, y = 1500, z = 14 }) --{x = 5441, y = 1500, z = 14}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaOutburst1)
end
-- FUNCTIONS END

local heartDestructionOutburst = Action()
function heartDestructionOutburst.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		playerPositions = {
			Position(5440, 1412, 14), --{x = 5440, y = 1412, z = 14}
			Position(5440, 1413, 14),
			Position(5440, 1414, 14),
			Position(5440, 1415, 14),
			Position(5440, 1416, 14), --{x = 5440, y = 1416, z = 14}
		},

		newPos = { x = 5467, y = 1420, z = 14 }, --{x = 5467, y = 1420, z = 14}
	}

	local pushPos = { x = 5440, y = 1412, z = 14 }

	if item.actionid == 14331 then
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
						players:setStorageValue(14331, os.time() + 20 * 60 * 60)
					end
					Position(config.newPos):sendMagicEffect(11)

					areaOutburst1 = addEvent(clearArea, 15 * 60000)

					Game.createMonster("Spark of Destruction", { x = 5462, y = 1410, z = 14 }, false, true) --{x = 5462, y = 1410, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5463, y = 1415, z = 14 }, false, true) --{x = 5463, y = 1415, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5470, y = 1415, z = 14 }, false, true) --{x = 5470, y = 1415, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5471, y = 1410, z = 14 }, false, true) --{x = 5471, y = 1410, z = 14}
					Game.createMonster("Outburst", { x = 5467, y = 1412, z = 14 }, false, true) --{x = 5467, y = 1412, z = 14}

					outburstStage = 0
					outburstHealth = 290000

					local vortex = Tile({ x = 5458, y = 1413, z = 14 }):getItemById(23482) --{x = 5458, y = 1413, z = 14}
					if vortex then
						vortex:transform(23483)
						vortex:setActionId(14350)
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

heartDestructionOutburst:aid(14331)
heartDestructionOutburst:register()
