local vortex = {
	[14321] = Position(5382, 1487, 14), -- Charger TP 1 {x = 5382, y = 1487, z = 14}
	[14322] = Position(5315, 1390, 12), -- Charger Exit {x = 5315, y = 1390, z = 12}
	[14324] = Position(5327, 1379, 12), -- Anomaly Exit {x = 5327, y = 1379, z = 12}
	[14325] = Position(5449, 1508, 14), -- Main Room {x = 5449, y = 1508, z = 14}
	[14340] = Position(5407, 1360, 11), -- Main Room Exit {x = 5407, y = 1360, z = 11}
	[14341] = Position(5512, 1484, 12), -- Cracklers Exit {x = 5512, y = 1484, z = 12}
	[14343] = Position(5521, 1486, 12), -- Rupture Exit {x = 5521, y = 1486, z = 12}
	[14345] = Position(5501, 1377, 12), -- Realityquake Exit {x = 5501, y = 1377, z = 12}
	[14347] = Position(5496, 1372, 12), -- Unstable Sparks Exit {x = 5496, y = 1372, z = 12}
	[14348] = Position(5451, 1503, 14), -- Eradicator Exit (Main Room) {x = 5451, y = 1503, z = 14}
	[14350] = Position(5441, 1500, 14), -- Outburst Exit (Main Room) {x = 5441, y = 1500, z = 14}
	[14352] = Position(5447, 1504, 14), -- World Devourer Exit (Main Room) {x = 5447, y = 1504, z = 14}
	[14354] = Position(5344, 1502, 14), -- World Devourer (Reward Room) {x = 5344, y = 1502, z = 14}
}

local accessVortex = {
	-- Anomaly enter
	[14323] = {
		position = Position(5479, 1380, 14), --{x = 5479, y = 1380, z = 14}
		storage = 14320,
		storageTime = 14321,
	},
	-- Rupture enter
	[14342] = {
		position = Position(5538, 1377, 12), --{x = 5538, y = 1377, z = 14}
		storage = 14322,
		storageTime = 14323,
	},
	-- Realityquake enter
	[14344] = {
		position = Position(5413, 1368, 14), --{x = 5413, y = 1368, z = 14}
		storage = 14324,
		storageTime = 14325,
	},
}

local finalBosses = {
	-- Eradicator enter
	[14346] = {
		position = Position(5571, 1420, 14), --{x = 5571, y = 1420, z = 14}
		storage1 = 14326,
		storage2 = 14327,
		storage3 = 14328,
		storageTime = 14329,
	},
	-- Outburst enter
	[14349] = {
		position = Position(5436, 1416, 14), --{x = 5436, y = 1416, z = 14}
		storage1 = 14326,
		storage2 = 14327,
		storage3 = 14328,
		storageTime = 14331,
	},
}

local teleportHeart = MoveEvent()

function teleportHeart.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local normalVortex = vortex[item.actionid]
	local bossVortex = accessVortex[item.actionid]
	local uBosses = finalBosses[item.actionid]
	if normalVortex then
		player:teleportTo(normalVortex)
	elseif bossVortex then
		if player:getStorageValue(bossVortex.storage) >= 1 then
			if player:getStorageValue(bossVortex.storageTime) < os.time() then
				player:teleportTo(bossVortex.position)
			else
				player:teleportTo(fromPosition)
				player:sendTextMessage(19, "It's too early for you to endure this challenge again.")
			end
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(19, "You don't have access to this portal.")
		end
	elseif uBosses then
		if player:getStorageValue(uBosses.storage1) >= 1 and player:getStorageValue(uBosses.storage2) >= 1 and player:getStorageValue(uBosses.storage3) >= 1 then
			if player:getStorageValue(uBosses.storageTime) < os.time() then
				player:teleportTo(uBosses.position)
			else
				player:teleportTo(fromPosition)
				player:sendTextMessage(19, "It's too early for you to endure this challenge again.")
			end
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(19, "You don't have access to this portal.")
		end
	elseif item.actionid == 14351 then
		if player:getStorageValue(14330) >= 1 and player:getStorageValue(14332) >= 1 then
			if player:getStorageValue(14333) < os.time() then
				player:teleportTo(Position(5505, 1512, 14)) --{x = 5505, y = 1512, z = 14}
			else
				player:teleportTo(fromPosition)
				player:sendTextMessage(19, "It's too early for you to endure this challenge again.")
			end
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(19, "You don't have access to this portal.")
		end
	elseif item.actionid == 14353 then -- Remove storages from mini bosses
		player:teleportTo(Position(5447, 1504, 14)) --{x = 5447, y = 1504, z = 14}
		player:setStorageValue(14334, -1)
		player:setStorageValue(14335, -1)
		player:setStorageValue(14336, -1)
		player:unregisterEvent("DevourerStorage")
	end
	return true
end

teleportHeart:type("stepin")

for index, value in pairs(vortex) do
	teleportHeart:aid(index)
end

--teleportHeart:register()
