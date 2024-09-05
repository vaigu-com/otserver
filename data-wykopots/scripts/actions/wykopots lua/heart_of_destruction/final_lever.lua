--[[
Storages:
The Hunger = 14334
The Destruction = 14335
The Rage = 14336
]]
--
-- FUNCTIONS
function sparkDevourerSpawn()
	local positions = {
		{ x = 5501, y = 1469, z = 14 }, --{x = 5501, y = 1469, z = 14}
		{ x = 5502, y = 1480, z = 14 }, --{x = 5502, y = 1480, z = 14}
		{ x = 5510, y = 1479, z = 14 }, --{x = 5510, y = 1479, z = 14}
		{ x = 5507, y = 1470, z = 14 }, --{x = 5507, y = 1470, z = 14}
	}

	if sparkSpawnCount > 0 then
		for i = 1, sparkSpawnCount do
			Game.createMonster("Spark of Destruction2", positions[i], false, true)
		end
		sparkSpawnCount = 0
	end
	areaDevourer6 = addEvent(sparkDevourerSpawn, 10000)
end

local function doCheckArea()
	local upConer = { x = 5493, y = 1464, z = 14 } -- upLeftCorner {x = 5493, y = 1464, z = 14}
	local downConer = { x = 5517, y = 1489, z = 14 } -- downRightCorner {x = 5517, y = 1489, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
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

	for _, online in ipairs(Game.getPlayers()) do
		if online:isPlayer() then
			if online:getStorageValue(14334) >= 1 or online:getStorageValue(14335) >= 1 or online:getStorageValue(14336) >= 1 then
				return true
			end
		end
	end

	return false
end

local function changeArea()
	local function organizeHunger()
		local upConer = { x = 5466, y = 1488, z = 14 } -- upLeftCorner {x = 5466, y = 1488, z = 14}
		local downConer = { x = 5489, y = 1512, z = 14 } -- downRightCorner {x = 5489, y = 1512, z = 14}
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						if creatures and #creatures > 0 then
							if theHungerKilled == false then
								for _, c in pairs(creatures) do
									if isMonster(c) then
										c:teleportTo({ x = 5477, y = 1497, z = 14 }) --{x = 5477, y = 1497, z = 14}
									end
								end
							else
								devourerBossesKilled = devourerBossesKilled - 1
								Game.createMonster("The Hunger", { x = 5477, y = 1500, z = 14 }, false, true) --{x = 5477, y = 1500, z = 14}
								theHungerKilled = false
							end
						end
					end
				end
			end
		end
	end

	local function organizeDestruction()
		local upConer = { x = 5492, y = 1433, z = 14 } -- upLeftCorner {x = 5492, y = 1433, z = 14}
		local downConer = { x = 5517, y = 1456, z = 14 } -- downRightCorner {x = 5517, y = 1456, z = 14}
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						if creatures and #creatures > 0 then
							if theDestructionKilled == false then
								for _, c in pairs(creatures) do
									if isMonster(c) then
										c:teleportTo({ x = 5504, y = 1441, z = 14 }) --{x = 5504, y = 1441, z = 14}
									end
								end
							else
								devourerBossesKilled = devourerBossesKilled - 1
								Game.createMonster("The Destruction", { x = 5504, y = 1444, z = 14 }, false, true) --{x = 5504, y = 1444, z = 14}
								theDestructionKilled = false
							end
						end
					end
				end
			end
		end
	end

	local function organizeRage()
		local upConer = { x = 5521, y = 1488, z = 14 } -- upLeftCorner {x = 5521, y = 1488, z = 14}
		local downConer = { x = 5544, y = 1512, z = 14 } -- downRightCorner {x = 5544, y = 1512, z = 14}
		for i = upConer.x, downConer.x do
			for j = upConer.y, downConer.y do
				for k = upConer.z, downConer.z do
					local tile = Tile(i, j, k)
					if tile then
						local creatures = tile:getCreatures()
						if creatures and #creatures > 0 then
							if theRageKilled == false then
								for _, c in pairs(creatures) do
									if isMonster(c) then
										c:teleportTo({ x = 5532, y = 1497, z = 14 }) --{x = 5532, y = 1497, z = 14}
									end
								end
							else
								devourerBossesKilled = devourerBossesKilled - 1
								Game.createMonster("The Rage", { x = 5532, y = 1500, z = 14 }, false, true) --{x = 5532, y = 1500, z = 14}
								theRageKilled = false
							end
						end
					end
				end
			end
		end
	end

	if devourerBossesKilled < 3 then
		for _, online in ipairs(Game.getPlayers()) do
			if online:isPlayer() then
				-- Teleport players from The Hunger to The Rage
				if online:getStorageValue(14334) >= 1 then
					online:setStorageValue(14334, -1)
					online:setStorageValue(14336, 1)
					online:teleportTo({ x = 5532, y = 1500, z = 14 }) --{x = 5532, y = 1500, z = 14}
					online:say("A polarity shift moves you into another part of the heart of destruction.", TALKTYPE_MONSTER_SAY)
					Position({ x = 5532, y = 1500, z = 14 }):sendMagicEffect(11)
				-- Teleport players from The Destruction to The Hunger
				elseif online:getStorageValue(14335) >= 1 then
					online:setStorageValue(14335, -1)
					online:setStorageValue(14334, 1)
					online:teleportTo({ x = 5477, y = 1500, z = 14 }) --{x = 5477, y = 1500, z = 14}
					online:say("A polarity shift moves you into another part of the heart of destruction.", TALKTYPE_MONSTER_SAY)
					Position({ x = 5477, y = 1500, z = 14 }):sendMagicEffect(11)
				-- Teleport players from The Rage to The Destruction
				elseif online:getStorageValue(14336) >= 1 then
					online:setStorageValue(14336, -1)
					online:setStorageValue(14335, 1)
					online:teleportTo({ x = 5504, y = 1444, z = 14 }) --{x = 5504, y = 1444, z = 14}
					online:say("A polarity shift moves you into another part of the heart of destruction.", TALKTYPE_MONSTER_SAY)
					Position({ x = 5504, y = 1444, z = 14 }):sendMagicEffect(11)
				end
			end
		end
		organizeHunger()
		organizeDestruction()
		organizeRage()
		areaDevourer4 = addEvent(changeArea, 30000)
	else
		stopEvent(areaDevourer1)
		stopEvent(areaDevourer2)
		stopEvent(areaDevourer3)
		stopEvent(areaDevourer4)
		for _, online in ipairs(Game.getPlayers()) do
			if online:isPlayer() then
				if online:getStorageValue(14334) >= 1 then
					online:setStorageValue(14334, -1)
					online:unregisterEvent("DevourerStorage")
					online:teleportTo({ x = 5504, y = 1485, z = 14 }) --{x = 5504, y = 1485, z = 14}
					Position({ x = 5504, y = 1485, z = 14 }):sendMagicEffect(11)
				elseif online:getStorageValue(14335) >= 1 then
					online:setStorageValue(14335, -1)
					online:unregisterEvent("DevourerStorage")
					online:teleportTo({ x = 5505, y = 1485, z = 14 }) --{x = 5505, y = 1485, z = 14}
					Position({ x = 5505, y = 1485, z = 14 }):sendMagicEffect(11)
				elseif online:getStorageValue(14336) >= 1 then
					online:setStorageValue(14336, -1)
					online:unregisterEvent("DevourerStorage")
					online:teleportTo({ x = 5506, y = 1485, z = 14 }) --{x = 5506, y = 1485, z = 14}
					Position({ x = 5506, y = 1485, z = 14 }):sendMagicEffect(11)
				end
			end
		end
		local spectators = Game.getSpectators(Position(5504, 1476, 14), false, true, 10, 10, 10, 10) --{x = 5504, y = 1476, z = 14}
		if #spectators > 0 then
			for i = 1, #spectators do
				spectators[i]:say("With the Rage, Hunger and Destruction gone, you're sucked into the heart of destruction!! THE WORLD DEVOURER AWAITS YOU!", TALKTYPE_MONSTER_YELL, false, spectators[i], Position(5504, 1476, 14))
			end
		end

		Game.createMonster("World Devourer", { x = 5504, y = 1475, z = 14 }, false, true) --{x = 5504, y = 1475, z = 14}
		Game.createMonster("Spark of Destruction2", { x = 5501, y = 1469, z = 14 }, false, true) --{x = 5501, y = 1469, z = 14}
		Game.createMonster("Spark of Destruction2", { x = 5508, y = 1470, z = 14 }, false, true) --{x = 5508, y = 1470, z = 14}
		Game.createMonster("Spark of Destruction2", { x = 5502, y = 1480, z = 14 }, false, true) --{x = 5502, y = 1480, z = 14}
		Game.createMonster("Spark of Destruction2", { x = 5510, y = 1479, z = 14 }, false, true) --{x = 5510, y = 1479, z = 14}
		sparkSpawnCount = 0
		devourerSummon = 0
		areaDevourer5 = addEvent(clearDevourer, 30 * 60000)
		areaDevourer6 = addEvent(sparkDevourerSpawn, 10000)
	end
end

local function clearHunger()
	local upConer = { x = 5466, y = 1488, z = 14 } -- upLeftCorner {x = 5466, y = 1488, z = 14}
	local downConer = { x = 5488, y = 1512, z = 14 } -- downRightCorner {x = 5488, y = 1512, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							if isPlayer(c) then
								c:teleportTo({ x = 5441, y = 1500, z = 14 }) --{x = 5441, y = 1500, z = 14}
							elseif isMonster(c) and c:getName() ~= "Spark of Destruction" then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer1)
end

local function clearDestruction()
	local upConer = { x = 5491, y = 1432, z = 14 } -- upLeftCorner {x = 5491, y = 1432, z = 14}
	local downConer = { x = 5517, y = 1457, z = 14 } -- downRightCorner {x = 5517, y = 1457, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							if isPlayer(c) then
								c:teleportTo({ x = 5441, y = 1500, z = 14 }) --{x = 5441, y = 1500, z = 14}
							elseif isMonster(c) and c:getName() ~= "Spark of Destruction" then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer2)
end

local function clearRage()
	local upConer = { x = 5521, y = 1488, z = 14 } -- upLeftCorner {x = 5521, y = 1488, z = 14}
	local downConer = { x = 5545, y = 1513, z = 14 } -- downRightCorner {x = 5545, y = 1513, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, c in pairs(creatures) do
							if isPlayer(c) then
								c:teleportTo({ x = 5441, y = 1500, z = 14 }) --{x = 5441, y = 1500, z = 14}
							elseif isMonster(c) and c:getName() ~= "Spark of Destruction" then
								c:remove()
							end
						end
					end
				end
			end
		end
	end
	stopEvent(areaDevourer3)
end

function clearDevourer()
	local upConer = { x = 5491, y = 1464, z = 14 } -- upLeftCorner {x = 5491, y = 1464, z = 14}
	local downConer = { x = 5517, y = 1488, z = 14 } -- downRightCorner {x = 5517, y = 1488, z = 14}

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local tile = Tile(i, j, k)
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
	stopEvent(areaDevourer4)
	stopEvent(areaDevourer5)
	stopEvent(areaDevourer6)
end
-- FUNCTIONS END

local heartDestructionFinal = Action()
function heartDestructionFinal.onUse(player, item, fromPosition, itemEx, toPosition)
	local config = {
		hungerPositions = {
			Position(5504, 1502, 14), --{x = 5504, y = 1502, z = 14}
			Position(5504, 1503, 14),
			Position(5504, 1504, 14),
			Position(5504, 1505, 14),
			Position(5504, 1506, 14), --{x = 5504, y = 1506, z = 14}
		},

		destructionPositions = {
			Position(5505, 1502, 14), --{x = 5505, y = 1502, z = 14}
			Position(5505, 1503, 14),
			Position(5505, 1504, 14),
			Position(5505, 1505, 14),
			Position(5505, 1506, 14), --{x = 5505, y = 1506, z = 14}
		},

		ragePositions = {
			Position(5506, 1502, 14), --{x = 5506, y = 1502, z = 14}
			Position(5506, 1503, 14),
			Position(5506, 1504, 14),
			Position(5506, 1505, 14),
			Position(5506, 1506, 14), --{x = 5506, y = 1506, z = 14}
		},

		hungerNewPos = { x = 5477, y = 1509, z = 14 }, --{x = 5477, y = 1509, z = 14}
		destructionNewPos = { x = 5504, y = 1453, z = 14 }, --{x = 5504, y = 1453, z = 14}
		rageNewPos = { x = 5532, y = 1509, z = 14 }, --{x = 5532, y = 1509, z = 14}
	}

	local pushPos = { x = 5505, y = 1502, z = 14 } --{x = 5505, y = 1502, z = 14}

	if item.actionid == 14332 then
		if item.itemid == 8911 then
			if player:getPosition().x == pushPos.x and player:getPosition().y == pushPos.y and player:getPosition().z == pushPos.z then
				local storeHunger, hungerTile = {}
				local storeDestruction, destructionTile = {}
				local storeRage, rageTile = {}

				for i = 1, #config.hungerPositions do
					hungerTile = Tile(config.hungerPositions[i]):getTopCreature()
					if isPlayer(hungerTile) then
						storeHunger[#storeHunger + 1] = hungerTile
					end
				end

				for i = 1, #config.destructionPositions do
					destructionTile = Tile(config.destructionPositions[i]):getTopCreature()
					if isPlayer(destructionTile) then
						storeDestruction[#storeDestruction + 1] = destructionTile
					end
				end

				for i = 1, #config.ragePositions do
					rageTile = Tile(config.ragePositions[i]):getTopCreature()
					if isPlayer(rageTile) then
						storeRage[#storeRage + 1] = rageTile
					end
				end

				if #storeHunger < 1 or #storeDestruction < 1 or #storeRage < 1 then
					player:sendTextMessage(19, "You need at least 3 players, each in a column.")
					return true
				end

				if doCheckArea() == false then
					clearHunger()
					clearDestruction()
					clearRage()
					clearDevourer()

					local teamHunger
					local teamDestruction
					local teamRage

					for i = 1, #storeHunger do
						teamHunger = storeHunger[i]
						config.hungerPositions[i]:sendMagicEffect(CONST_ME_POFF)
						teamHunger:teleportTo(config.hungerNewPos)
						teamHunger:setStorageValue(14333, os.time() + 7 * 24 * 60 * 60)
						teamHunger:setStorageValue(14334, 1) --storage Hunger
						teamHunger:registerEvent("DevourerStorage")
					end

					for i = 1, #storeDestruction do
						teamDestruction = storeDestruction[i]
						config.destructionPositions[i]:sendMagicEffect(CONST_ME_POFF)
						teamDestruction:teleportTo(config.destructionNewPos)
						teamDestruction:setStorageValue(14333, os.time() + 7 * 24 * 60 * 60)
						teamDestruction:setStorageValue(14335, 1) --storage Destruction
						teamDestruction:registerEvent("DevourerStorage")
					end

					for i = 1, #storeRage do
						teamRage = storeRage[i]
						config.ragePositions[i]:sendMagicEffect(CONST_ME_POFF)
						teamRage:teleportTo(config.rageNewPos)
						teamRage:setStorageValue(14333, os.time() + 7 * 24 * 60 * 60)
						teamRage:setStorageValue(14336, 1) --storage Rage
						teamRage:registerEvent("DevourerStorage")
					end

					Position(config.hungerNewPos):sendMagicEffect(11)
					Position(config.destructionNewPos):sendMagicEffect(11)
					Position(config.rageNewPos):sendMagicEffect(11)

					areaDevourer1 = addEvent(clearHunger, 30 * 60000)
					areaDevourer2 = addEvent(clearDestruction, 30 * 60000)
					areaDevourer3 = addEvent(clearRage, 30 * 60000)
					areaDevourer4 = addEvent(changeArea, 30000) --mudar

					--Variables
					devourerBossesKilled = 0
					theHungerKilled = false
					theDestructionKilled = false
					theRageKilled = false

					hungerSummon = 0
					rageSummon = 0
					destructionSummon = 0
					devourerSummon = 0

					Game.createMonster("The Hunger", { x = 5477, y = 1500, z = 14 }, false, true) --{x = 5477, y = 1500, z = 14}
					Game.createMonster("The Destruction", { x = 5504, y = 1444, z = 14 }, false, true) --{x = 5504, y = 1444, z = 14}
					Game.createMonster("The Rage", { x = 5532, y = 1500, z = 14 }, false, true) --{x = 5532, y = 1500, z = 14}

					local vortex = Tile({ x = 5514, y = 1476, z = 14 }):getItemById(23482) --{x = 5514, y = 1476, z = 14}
					if vortex then
						vortex:transform(23483)
						vortex:setActionId(14352)
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

heartDestructionFinal:aid(14332)
heartDestructionFinal:register()
