local zombieOnDeath = CreatureEvent("ZombieOnDeath")

function zombieOnDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	-- Send text and effect
	monster:say("POWROCE!", TALKTYPE_MONSTER_YELL)
	monster:getPosition():sendMagicEffect(CONST_ME_MORTAREA)

	-- Remove zombie count, when it dies
	Game.setStorageValue(ze_zombieCountGlobalStorage, getZombieEventZombieCount() - 1)

	-- Store player kills
	local killerId = killer:getId()
	if zombieKillCount[killerId] ~= nil then
		zombieKillCount[killerId] = zombieKillCount[killerId] + 1
	else
		zombieKillCount[killerId] = 1
	end

	return true
end
zombieOnDeath:register()

local function winnerGlobalMessage(count, playerName, zombieCount, timeAlive)
	local timeString = ""

	local seconds = timeAlive % 60
	local minutes = math.floor(timeAlive / 60) % 60
	local hours = math.floor(timeAlive / 3600)

	if hours > 0 then
		timeString = tostring(hours) .. " h "
	end

	if minutes > 0 then
		timeString = timeString .. tostring(minutes) .. " min "
	end

	if seconds > 0 then
		timeString = timeString .. tostring(seconds) .. " sek"
	end

	Game.broadcastMessage(string.format("%d miejsce zdobywa %s zmierzajac sie z %d Zombie i przezywajac %s.", count, playerName, zombieCount, timeString))
end

local zombiePrepareDeath = CreatureEvent("ZombiePlayerDeath")

function zombiePrepareDeath.onPrepareDeath(creature, killer)
	local player = Player(creature)
	local exprate = Game.getExperienceStage(player:getLevel())

	-- Remove player from count
	local count = getZombieEventJoinedCount()
	Game.setStorageValue(ze_joinCountGlobalStorage, count - 1)

	-- Reset player after death
	-- Teleport player
	local depo = Position(6238, 1605, 8)
	player:teleportTo(depo)
	depo:sendMagicEffect(CONST_ME_TELEPORT) -- efekt
	-- Reset storages & events
	player:setStorageValue(ze_joinStorage, 0)
	player:setStorageValue(Storage.healLock, -1)
	player:setStorageValue(Storage.mwLock, -1)
	player:unregisterEvent("ZombiePlayerDeath")
	-- Set normal hp&mana
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
	-- Set normal speed
	player:setStorageValue(Storage.hasteLock, -1)
	player:changeSpeed()
	-- Remove Conditions
	local conditions = { CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY, CONDITION_BLEEDING, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_FREEZING, CONDITION_DAZZLED, CONDITION_CURSED, CONDITION_INFIGHT }
	for i = 1, #conditions do
		player:removeCondition(conditions[i])
	end

	-- Let's reward players
	if count <= 6 and count >= 4 then -- 6-4 miesjce
		local playerName = player:getName()
		-- Add Tibia Coins
		player:addTibiaCoins(1)
		player:addTransferableCoins(1)
		player:setExpBoostStamina(player:getExpBoostStamina() + (3 * 60))
		player:setStoreXpBoost(50 * exprate)

		-- Store kill count and remove from table to avoid memory leak
		local playerId, killCount = player:getId(), 0
		if zombieKillCount[playerId] ~= nil then
			killCount = zombieKillCount[playerId]
			zombieKillCount[playerId] = nil
		end
	elseif count <= 3 then
		local playerName = player:getName()

		local trophy = ze_trophiesTable[count]
		local item = player:addItem(trophy.itemid, 1)
		if item then
			item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("%s %s\n%s.", playerName, trophy.description, os.date("%x")))
		end
		-- Add Tibia Coins
		player:addTibiaCoins(trophy.tibiacoins)
		player:addTransferableCoins(trophy.tibiacoins)
		-- Xp boost
		if player:getExpBoostStamina() <= 28800 then
			player:setExpBoostStamina(player:getExpBoostStamina() + (trophy.xpminutes * 60))
			player:setStoreXpBoost(50 * exprate)
		end

		-- Store kill count and remove from table to avoid memory leak
		local playerId, killCount = player:getId(), 0
		if zombieKillCount[playerId] ~= nil then
			killCount = zombieKillCount[playerId]
			zombieKillCount[playerId] = nil
		end

		-- Broadcast
		local timeAlive = os.time() - Game.getStorageValue(GlobalStorage.ZombieTimer)
		winnerGlobalMessage(count, playerName, getZombieEventZombieCount(), timeAlive)

		-- Add event points & record
		incrementStorage(player:getId(), Storage.overallPoints, trophy.points)
		incrementStorage(player:getId(), Storage.zombiePoints, trophy.points)

		if timeAlive > player:getStorageValue(Storage.zombieRecord) then
			player:setStorageValue(Storage.zombieRecord, timeAlive) -- set player record
		end

		if count == 1 then -- add "win"
			incrementStorage(player:getId(), Storage.overallWins, 1)
			incrementStorage(player:getId(), Storage.zombieWins, 1)
		end

		-- The last player died, let's reset the event
		if count <= 1 then
			resetZombieEvent()
		end
	end

	return false
end

zombiePrepareDeath:register()
