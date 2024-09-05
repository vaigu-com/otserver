local team = {}

-- FUNCTIONS

local function shuffleTable(t, count, ri, rj)
	ri = ri or 1
	rj = rj or #t
	for x = 1, count or 1 do
		for i = rj, ri + 1, -1 do
			local j = math.random(ri, rj)
			t[i], t[j] = t[j], t[i]
		end
	end
end

local function doCheckArea()
	--Room 1
	local upConer = { x = 5366, y = 1469, z = 14 } -- upLeftCorner {x = 5366, y = 1469, z = 14}
	local downConer = { x = 5408, y = 1503, z = 14 } -- downRightCorner {x = 5408, y = 1503, z = 14}

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

	--Room 2
	local upConer2 = { x = 5372, y = 1467, z = 15 } -- upLeftCorner {x = 5372, y = 1467, z = 15}
	local downConer2 = { x = 5410, y = 1504, z = 15 } -- downRightCorner {x = 5410, y = 1504, z = 15}

	for f = upConer2.x, downConer2.x do
		for g = upConer2.y, downConer2.y do
			for h = upConer2.z, downConer2.z do
				local room = { x = f, y = g, z = h }
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

	if spawningCharge == true then
		return true
	end

	return false
end

local function clearArea()
	--Room 1
	local upConer = { x = 5366, y = 1469, z = 14 } -- upLeftCorner {x = 5366, y = 1469, z = 14}
	local downConer = { x = 5408, y = 1503, z = 14 } -- downRightCorner {x = 5408, y = 1503, z = 14}

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
								c:teleportTo({ x = 5315, y = 1390, z = 12 }) --{x = 5315, y = 1390, z = 12}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end

	--Room 2
	local upConer2 = { x = 5372, y = 1467, z = 15 } -- upLeftCorner {x = 5372, y = 1467, z = 15}
	local downConer2 = { x = 5410, y = 1504, z = 15 } -- downRightCorner {x = 5410, y = 1504, z = 15}

	for f = upConer2.x, downConer2.x do
		for g = upConer2.y, downConer2.y do
			for h = upConer2.z, downConer2.z do
				local room = { x = f, y = g, z = h }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							if isPlayer(c) then
								c:teleportTo({ x = 5315, y = 1390, z = 12 }) --{x = 5315, y = 1390, z = 12}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	team = {}
	stopEvent(areaHeart1)
	stopEvent(areaHeart2)
	stopEvent(areaHeart3)
end

function teleportToCrackler()
	shuffleTable(team, 2, ri, rj) -- Embaralha a tabela para dar um random teleport

	--Room 1
	local upConer = { x = 5374, y = 1469, z = 14 } -- upLeftCorner {x = 5374, y = 1469, z = 14}
	local downConer = { x = 5408, y = 1501, z = 14 } -- downRightCorner {x = 5408, y = 1501, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							if c == team[1] or c == team[2] then
								c:teleportTo({ x = c:getPosition().x, y = c:getPosition().y, z = c:getPosition().z + 1 })
								c:say("A shift in polarity switches creatures with coresponding polarity into another phase of existence!", TALKTYPE_MONSTER_YELL, isInGhostMode, pid, { x = 32158, y = 31355, z = 14 })
							end
						end
					end
				end
			end
		end
	end
	areaHeart3 = addEvent(teleportToCharger, 10000)
end

function teleportToCharger()
	--Room 1
	local upConer = { x = 5374, y = 1469, z = 15 } -- upLeftCorner {x = 5374, y = 1469, z = 15}
	local downConer = { x = 5408, y = 1502, z = 15 } -- downRightCorner {x = 5408, y = 1502, z = 15}

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
								c:teleportTo({ x = c:getPosition().x, y = c:getPosition().y, z = c:getPosition().z - 1 })
							end
						end
					end
				end
			end
		end
	end
	areaHeart2 = addEvent(teleportToCrackler, 25000)
end
-- FUNCTIONS END

local heartDestructionCharges = Action()
function heartDestructionCharges.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		playerPositions = {
			Position(5314, 1388, 12), --{x = 5314, y = 1388, z = 12}
			Position(5315, 1388, 12),
			Position(5316, 1388, 12),
			Position(5317, 1388, 12),
			Position(5318, 1388, 12), --{x = 5318, y = 1388, z = 12}
		},

		newPos = { x = 5368, y = 1491, z = 14 }, --{x = 5368, y = 1491, z = 14}
	}

	local pushPos = { x = 5314, y = 1388, z = 12 }

	if item.actionid == 14320 then
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
						table.insert(team, players) -- Insert players on table to get a random teleport
						config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
						players:teleportTo(config.newPos)
						Position(config.newPos):sendMagicEffect(11)
					end

					areaHeart1 = addEvent(clearArea, 15 * 60000)
					areaHeart2 = addEvent(teleportToCrackler, 25000)

					Game.setStorageValue(14321, 0) -- Overcharge Count

					spawningCharge = false

					Game.createMonster("Charger", { x = 5391, y = 1478, z = 14 }, false, true) --{x = 5391, y = 1478, z = 14}
					Game.createMonster("Charger", { x = 5395, y = 1480, z = 14 }, false, true) --{x = 5395, y = 1480, z = 14}
					Game.createMonster("Charger", { x = 5387, y = 1481, z = 14 }, false, true) --{x = 5387, y = 1481, z = 14}
					Game.createMonster("Charger", { x = 5392, y = 1482, z = 14 }, false, true) --{x = 5392, y = 1482, z = 14}
					Game.createMonster("Charger", { x = 5396, y = 1484, z = 14 }, false, true) --{x = 5396, y = 1484, z = 14}
					Game.createMonster("Charger", { x = 5384, y = 1484, z = 14 }, false, true) --{x = 5384, y = 1484, z = 14}
					Game.createMonster("Charger", { x = 5389, y = 1485, z = 14 }, false, true) --{x = 5389, y = 1485, z = 14}
					Game.createMonster("Charger", { x = 5394, y = 1488, z = 14 }, false, true) --{x = 5394, y = 1488, z = 14}
					Game.createMonster("Charger", { x = 5386, y = 1489, z = 14 }, false, true) --{x = 5386, y = 1489, z = 14}
					Game.createMonster("Charger", { x = 5391, y = 1490, z = 14 }, false, true) --{x = 5391, y = 1490, z = 14}

					Game.createMonster("Overcharge", { x = 5384, y = 1482, z = 15 }, false, true) --{x = 5384, y = 1482, z = 15}
					Game.createMonster("Overcharge", { x = 5386, y = 1487, z = 15 }, false, true) --{x = 5386, y = 1487, z = 15}
					Game.createMonster("Overcharge", { x = 5392, y = 1487, z = 15 }, false, true) --{x = 5392, y = 1487, z = 15}
					Game.createMonster("Overcharge", { x = 5394, y = 1483, z = 15 }, false, true) --{x = 5394, y = 1483, z = 15}
					Game.createMonster("Overcharge", { x = 5390, y = 1479, z = 15 }, false, true) --{x = 5390, y = 1479, z = 15}
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

heartDestructionCharges:aid(14320)
heartDestructionCharges:register()
