local positions = {
	Position(7510, 1476, 10), --{x = 7510, y = 1476, z = 10}
	Position(7510, 1477, 10),
	Position(7510, 1478, 10),
	Position(7510, 1479, 10),
}

local barrierPositions = {
	Position(7511, 1476, 10),
	Position(7511, 1477, 10),
	Position(7511, 1478, 10),
	Position(7511, 1479, 10),
}

local function clearArena()
	local spectators = Game.getSpectators(Position(7527, 1456, 10), false, false, 10, 10, 13, 13)
	local exitPosition = Position(7424, 1437, 10)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isPlayer() then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
			spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zostales teleportowany przez systemy bezpieczenstwa.")
		else
			spectator:remove()
		end
	end
end

local function restoreWall(position)
	Game.createItem(16169, 1, position)
end

local creatureevent = CreatureEvent("BigfootBurdenParasiteDeath")

function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	if Game.getStorageValue(GlobalStorage.Weeper) >= 1 then
		return true
	end

	local targetPosition = targetMonster:getPosition()
	local barrier = false
	for i = 1, #positions do
		if targetPosition == positions[i] then
			barrier = true
			break
		end
	end

	if not barrier then
		return true
	end

	for i = 1, #barrierPositions do
		local tile = Tile(barrierPositions[i])
		if tile then
			local item = tile:getItemById(16169)
			if item then
				item:remove()
				addEvent(restoreWall, 5 * 60 * 1000, barrierPositions[i])
			end
		end
	end

	Game.setStorageValue(GlobalStorage.Weeper, 1)
	addEvent(Game.setStorageValue, 30 * 60 * 1000, GlobalStorage.Weeper, 0)
	addEvent(clearArena, 30 * 60 * 1000)
	return true
end

creatureevent:register()
