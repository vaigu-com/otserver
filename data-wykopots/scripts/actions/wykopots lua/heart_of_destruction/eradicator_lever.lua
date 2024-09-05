-- FUNCTIONS
local function doCheckArea()
	local upConer = { x = 5530, y = 1401, z = 14 } -- upLeftCorner {x = 5530, y = 1401, z = 14}
	local downConer = { x = 5554, y = 1423, z = 14 } -- downRightCorner {x = 5554, y = 1423, z = 14}

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
	local upConer = { x = 5530, y = 1401, z = 14 } -- upLeftCorner {x = 5530, y = 1401, z = 14}
	local downConer = { x = 5554, y = 1423, z = 14 } -- downRightCorner {x = 5554, y = 1423, z = 14}

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
								c:teleportTo({ x = 5451, y = 1503, z = 14 }) --{x = 5451, y = 1503, z = 14}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaEradicator1)
	stopEvent(areaEradicator2)
end
-- FUNCTIONS END

local heartDestructionEradicator = Action()
function heartDestructionEradicator.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		playerPositions = {
			Position(5567, 1412, 14), --{x = 5567, y = 1412, z = 14}
			Position(5567, 1413, 14),
			Position(5567, 1414, 14),
			Position(5567, 1415, 14),
			Position(5567, 1416, 14), --{x = 5567, y = 1416, z = 14}
		},

		newPos = { x = 5542, y = 1418, z = 14 }, --{x = 5542, y = 1418, z = 14}
	}

	local pushPos = { x = 5567, y = 1412, z = 14 }

	if item.actionid == 14330 then
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
						players:setStorageValue(14329, os.time() + 20 * 60 * 60)
					end
					Position(config.newPos):sendMagicEffect(11)

					eradicatorReleaseT = false -- Liberar Spell
					eradicatorWeak = 0 -- Eradicator Form
					areaEradicator1 = addEvent(clearArea, 15 * 60000)
					areaEradicator2 = addEvent(function()
						eradicatorReleaseT = true
					end, 74000)

					Game.createMonster("Spark of Destruction", { x = 5537, y = 1410, z = 14 }, false, true) --{x = 5537, y = 1410, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5538, y = 1415, z = 14 }, false, true) --{x = 5538, y = 1415, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5545, y = 1415, z = 14 }, false, true) --{x = 5545, y = 1415, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5547, y = 1410, z = 14 }, false, true) --{x = 5547, y = 1410, z = 14}
					Game.createMonster("Eradicator", { x = 5542, y = 1411, z = 14 }, false, true) --{x = 5542, y = 1411, z = 14}

					local vortex = Tile({ x = 5551, y = 1412, z = 14 }):getItemById(23482) --{x = 5551, y = 1412, z = 14}
					if vortex then
						vortex:transform(23483)
						vortex:setActionId(14348)
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

heartDestructionEradicator:aid(14330)
heartDestructionEradicator:register()
