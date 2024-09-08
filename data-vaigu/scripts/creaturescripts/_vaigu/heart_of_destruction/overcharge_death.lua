local function setStorage()
	--Room 1
	local upConer = { x = 5366, y = 1469, z = 14 } -- upLeftCorner
	local downConer = { x = 5408, y = 1501, z = 14 } -- downRightCorner

	for i = upConer.x, downConer.x do
		for j = upConer.y, downConer.y do
			for k = upConer.z, downConer.z do
				local room = { x = i, y = j, z = k }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isPlayer() and creature:getStorageValue(14320) < 1 then
								creature:setStorageValue(14320, 1) -- Access to boss Anomaly
							end
						end
					end
				end
			end
		end
	end

	--Room 2
	local upConer2 = { x = 5373, y = 1469, z = 15 } -- upLeftCorner
	local downConer2 = { x = 5407, y = 1500, z = 15 } -- downRightCorner

	for f = upConer2.x, downConer2.x do
		for g = upConer2.y, downConer2.y do
			for h = upConer2.z, downConer2.z do
				local room = { x = f, y = g, z = h }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creature in pairs(creatures) do
							if creature:isPlayer() and creature:getStorageValue(14320) < 1 then -- hardcoded storges
								creature:setStorageValue(14320, 1) -- Access to boss Anomaly
							end
						end
					end
				end
			end
		end
	end
end

local overchargeDeath = CreatureEvent("OverchargeDeath")
function overchargeDeath.onDeath(creature)
	Game.setStorageValue(14321, Game.getStorageValue(14321) + 1)

	if Game.getStorageValue(14321) == 5 then
		setStorage()
		creature:say("You have reached enough charges to pass further into the destruction!", TALKTYPE_MONSTER_YELL, isInGhostMode, pid, { x = 5394, y = 1483, z = 15 })
		Game.setStorageValue(14321, -1)
	end

	return true
end

overchargeDeath:register()
