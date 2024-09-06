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
	local upConer = { x = 5358, y = 1425, z = 14 } -- upLeftCorner --{x = 5358, y = 1425, z = 14}
	local downConer = { x = 5395, y = 1450, z = 14 } -- downRightCorner {x = 5395, y = 1450, z = 14}

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
	local upConer = { x = 5358, y = 1425, z = 14 } -- upLeftCorner --{x = 5358, y = 1425, z = 14}
	local downConer = { x = 5395, y = 1450, z = 14 } -- downRightCorner {x = 5395, y = 1450, z = 14}

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
								c:teleportTo({ x = 5496, y = 1369, z = 12 }) --{x = 5496, y = 1369, z = 12}
							elseif isMonster(c) then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaSparks1)
	stopEvent(areaSparks2)
	stopEvent(areaSparks3)
	stopEvent(areaSparks4)
end

function createSparks()
	local positions = {
		{ x = 5365, y = 1434, z = 14 }, --
		{ x = 5365, y = 1440, z = 14 }, --
		{ x = 5366, y = 1437, z = 14 }, --
		{ x = 5369, y = 1430, z = 14 }, --
		{ x = 5369, y = 1435, z = 14 }, --
		{ x = 5370, y = 1439, z = 14 }, --
		{ x = 5372, y = 1432, z = 14 }, --
		{ x = 5371, y = 1442, z = 14 }, --
		{ x = 5374, y = 1435, z = 14 }, --
		{ x = 5374, y = 1438, z = 14 }, --
		{ x = 5374, y = 1443, z = 14 }, --
		{ x = 5377, y = 1441, z = 14 }, --
		{ x = 5378, y = 1430, z = 14 }, --
		{ x = 5378, y = 1437, z = 14 }, --
		{ x = 5378, y = 1445, z = 14 }, --
		{ x = 5381, y = 1443, z = 14 }, --
		{ x = 5382, y = 1432, z = 14 }, --
		{ x = 5383, y = 1440, z = 14 }, --
		{ x = 5385, y = 1430, z = 14 }, --
		{ x = 5386, y = 1443, z = 14 }, --
		{ x = 5387, y = 1433, z = 14 }, --
		{ x = 5387, y = 1438, z = 14 }, --
		{ x = 5390, y = 1430, z = 14 }, --
		{ x = 5390, y = 1436, z = 14 }, --
		{ x = 5390, y = 1441, z = 14 }, --
	}

	if unstableSparksCount < 11 then
		shuffleTable(positions, 2, ri, rj)

		for i = 1, 15 do
			Game.createMonster("Unstable Spark", positions[i], false, true)
		end

		areaSparks3 = addEvent(renewSparks, 7000)
	end
end

function renewSparks()
	local upConer = { x = 5358, y = 1425, z = 14 } -- upLeftCorner --{x = 5358, y = 1425, z = 14}
	local downConer = { x = 5395, y = 1450, z = 14 } -- downRightCorner {x = 5395, y = 1450, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							local cPos = c:getPosition()
							if isMonster(c) and c:getName() == "Unstable Spark" then
								cPos:sendMagicEffect(3)
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	areaSparks4 = addEvent(createSparks, 1000)
end

-- FUNCTIONS END
local heartDestructionSparks = Action()
function heartDestructionSparks.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		entranceTiles = {
			Position(5498, 1366, 12), --{x = 5498, y = 1366, z = 12}
			Position(5498, 1367, 12),
			Position(5498, 1368, 12),
			Position(5498, 1369, 12),
			Position(5498, 1370, 12), --{x = 5498, y = 1370, z = 12}
		},

		newPos = { x = 5384, y = 1429, z = 14 }, --{x = 5384, y = 1429, z = 14}
	}

	local pushPos = { x = 5498, y = 1366, z = 12 }

	if item.actionid == 14328 then
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
					end
					Position(config.newPos):sendMagicEffect(11)

					areaSparks1 = addEvent(clearArea, 15 * 60000)
					areaSparks2 = addEvent(createSparks, 10000)

					unstableSparksCount = 0
					--Game.createMonster("Crackler", {x = 32200, y = 31322, z = 14}, false, true)
					player:say("The room slowly beginns to crackle. An erruption seems imanent!", TALKTYPE_MONSTER_YELL, isInGhostMode, pid, { x = 5376, y = 1436, z = 14 }) --{x = 5376, y = 1436, z = 14}
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

heartDestructionSparks:aid(14328)
heartDestructionSparks:register()
