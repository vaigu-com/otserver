function clearDevourer()
	local upConer = { x = 5491, y = 1464, z = 14 } -- upLeftCorner
	local downConer = { x = 5517, y = 1488, z = 14 } -- downRightCorner
	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isMonster() then -- éMonstro
								creature:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer4)
	stopEvent(areaDevourer5)
	stopEvent(areaDevourer6)
end

local function setStorageDevourer()
	local upConer = { x = 5491, y = 1464, z = 14 } -- upLeftCorner
	local downConer = { x = 5517, y = 1488, z = 14 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isPlayer() then -- éPlayer
								creature:setStorageValue(60835, 1)
								creature:setStorageValue(60814, 1)
								creature:setStorageValue(60828, 1)
							end
						end
					end
				end
			end
		end
	end
end

local function setStorage(fromPos, toPos, storage)
	local upConer = fromPos -- upLeftCorner
	local downConer = toPos -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isPlayer() and creature:getStorageValue(storage) < 1 then
								creature:setStorageValue(storage, 1) -- Access to boss Anomaly
							end
						end
					end
				end
			end
		end
	end
end

local heartBossDeath = CreatureEvent("HeartBossDeath")
function heartBossDeath.onDeath(creature)
	local bosses = {
		["anomaly"] = {
			tile = { x = 5494, y = 1378, z = 14 },
			actionId = 14325,
			fromPos = { x = 5492, y = 1366, z = 14 },
			toPos = { x = 5516, y = 1389, z = 14 },
			storage = 14326,
		},
		["rupture"] = {
			tile = { x = 5559, y = 1378, z = 14 },
			actionId = 14325,
			fromPos = { x = 5557, y = 1368, z = 14 },
			toPos = { x = 5580, y = 1390, z = 14 },
			storage = 14327,
		},
		["realityquake"] = {
			tile = { x = 5432, y = 1376, z = 14 },
			actionId = 14325,
			fromPos = { x = 5430, y = 1364, z = 14 },
			toPos = { x = 5452, y = 1387, z = 14 },
			storage = 14328,
		},
		["eradicator"] = {
			tile = { x = 5551, y = 1412, z = 14 },
			actionId = 14325,
			fromPos = { x = 5530, y = 1401, z = 14 },
			toPos = { x = 5554, y = 1423, z = 14 },
			storage = 14330,
		},
		["outburst"] = {
			tile = { x = 5458, y = 1413, z = 14 },
			actionId = 14325,
			fromPos = { x = 5455, y = 1402, z = 14 },
			toPos = { x = 5478, y = 1424, z = 14 },
			storage = 14332,
		},
	}

	local monsterName = creature:getName():lower()
	local bossName = bosses[monsterName]
	if bossName then
		local vortex = Tile(bossName.tile):getItemById(23483)
		if vortex then
			vortex:transform(23482)
			vortex:setActionId(bossName.actionId)
		end
		setStorage(bossName.fromPos, bossName.toPos, bossName.storage)
	elseif monsterName == "world devourer" then
		local vortex = Tile({ x = 5514, y = 1476, z = 14 }):getItemById(23483)
		if vortex then
			vortex:transform(23482)
			vortex:setActionId(14354)
		end
		setStorageDevourer()
		clearDevourer()
	end
	return true
end

heartBossDeath:register()
