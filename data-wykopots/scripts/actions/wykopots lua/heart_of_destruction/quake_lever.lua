-- FUNCTIONS
local function doCheckArea()
	local upConer = { x = 5430, y = 1364, z = 14 } -- upLeftCorner {x = 5430, y = 1364, z = 14}
	local downConer = { x = 5452, y = 1387, z = 14 } -- downRightCorner {x = 5452, y = 1387, z = 14}

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
	local upConer = { x = 5430, y = 1364, z = 14 } -- upLeftCorner {x = 5430, y = 1364, z = 14}
	local downConer = { x = 5452, y = 1387, z = 14 } -- downRightCorner {x = 5452, y = 1387, z = 14}

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
								c:teleportTo({ x = 5501, y = 1378, z = 12 }) --{x = 5501, y = 1378, z = 12}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaQuake1)
end
-- FUNCTIONS END

local heartDestructionQuake = Action()
function heartDestructionQuake.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		playerPositions = {
			Position(5415, 1372, 14), --{x = 5415, y = 1372, z = 14}
			Position(5415, 1373, 14),
			Position(5415, 1374, 14),
			Position(5415, 1375, 14),
			Position(5415, 1376, 14), --{x = 5415, y = 1376, z = 14}
		},

		newPos = { x = 5441, y = 1384, z = 14 }, --{x = 5441, y = 1384, z = 14}
	}

	local pushPos = { x = 5415, y = 1372, z = 14 }

	if item.actionid == 14329 then
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
						players:setStorageValue(14325, os.time() + 20 * 60 * 60)
					end
					Position(config.newPos):sendMagicEffect(11)

					areaQuake1 = addEvent(clearArea, 15 * 60000)

					Game.createMonster("Spark of Destruction", { x = 5436, y = 1374, z = 14 }, false, true) --{x = 5436, y = 1374, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5438, y = 1379, z = 14 }, false, true) --{x = 5438, y = 1379, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5443, y = 1379, z = 14 }, false, true) --{x = 5443, y = 1379, z = 14}
					Game.createMonster("Spark of Destruction", { x = 5445, y = 1374, z = 14 }, false, true) --{x = 5445, y = 1374, z = 14}
					Game.createMonster("Foreshock", { x = 5441, y = 1376, z = 14 }, false, true) --{x = 5441, y = 1376, z = 14}

					foreshockHealth = 105000
					aftershockHealth = 105000
					realityQuakeStage = 0
					foreshockStage = 0
					aftershockStage = 0

					local vortex = Tile({ x = 5432, y = 1376, z = 14 }):getItemById(23482) --{x = 5432, y = 1376, z = 14}
					if vortex then
						vortex:transform(23483)
						vortex:setActionId(14345)
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

heartDestructionQuake:aid(14329)
heartDestructionQuake:register()
