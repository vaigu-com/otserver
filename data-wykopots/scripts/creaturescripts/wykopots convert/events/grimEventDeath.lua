local grimOnDeath = CreatureEvent("GrimOnDeath")

function grimOnDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	-- Send text and effect
	monster:say("JESZCZE SIE ZOBACZYMY!", TALKTYPE_MONSTER_YELL)
	monster:getPosition():sendMagicEffect(CONST_ME_MORTAREA)

	-- Remove grim count, when it dies
	Game.setStorageValue(ge_grimCountGlobalStorage, getGrimEventGrimCount() - 1)

	-- Store player kills
	local killerId = killer:getId()
	if grimKillCount[killerId] ~= nil then
		grimKillCount[killerId] = grimKillCount[killerId] + 1
	else
		grimKillCount[killerId] = 1
	end

	return true
end
grimOnDeath:register()

local grimPrepareDeath = CreatureEvent("GrimPlayerDeath")

function grimPrepareDeath.onPrepareDeath(creature, killer)
	local player = Player(creature)
	local exprate = Game.getExperienceStage(player:getLevel())

	-- Remove player from count
	local count = getGrimEventJoinedCount()
	Game.setStorageValue(ge_joinCountGlobalStorage, count - 1)

	-- Reset player after death
	local depo = Position(5893, 1544, 9)
	player:teleportTo(depo)
	depo:sendMagicEffect(CONST_ME_TELEPORT) -- efekt
	player:setStorageValue(ge_joinStorage, 0)
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
	player:unregisterEvent("GrimPlayerDeath")
	-- Remove Conditions
	local conditions = { CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY, CONDITION_BLEEDING, CONDITION_PARALYZE, CONDITION_DROWN, CONDITION_FREEZING, CONDITION_DAZZLED, CONDITION_CURSED, CONDITION_INFIGHT }
	for i = 1, #conditions do
		player:removeCondition(conditions[i])
	end

	-- Let's reward the 3 last players
	if count <= 6 and count >= 4 then -- 6-4 miejsce
		local playerName = player:getName()
		-- Add Tibia Coins
		player:addTibiaCoins(1)
		player:addTransferableCoins(1)
		player:setExpBoostStamina(player:getExpBoostStamina() + (3 * 60))
		player:setStoreXpBoost(50 * exprate)

		-- Store kill count and remove from table to avoid memory leak
		local playerId, killCount = player:getId(), 0
		if grimKillCount[playerId] ~= nil then
			killCount = grimKillCount[playerId]
			grimKillCount[playerId] = nil
		end
	elseif count <= 3 then
		local playerName = player:getName()

		local trophy = ge_trophiesTable[count]
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
		if grimKillCount[playerId] ~= nil then
			killCount = grimKillCount[playerId]
			grimKillCount[playerId] = nil
		end

		-- Broadcast
		Game.broadcastMessage(string.format("%d miejsce zdobywa %s zmierzajac sie z %d Grimow oraz pokonujac %d Grimow.", count, playerName, getGrimEventGrimCount(), killCount))

		-- Broadcast
		local timeAlive = os.time() - Game.getStorageValue(GlobalStorage.GrimTimer)
		--winnerGlobalMessage(count, playerName, getZombieEventZombieCount(), timeAlive)]]

		-- Add event points & record
		incrementStorage(player:getId(), Storage.overallPoints, trophy.points)
		incrementStorage(player:getId(), Storage.grimPoints, trophy.points)

		if timeAlive > player:getStorageValue(Storage.grimRecord) then
			player:setStorageValue(Storage.grimRecord, timeAlive) -- set player record
		end

		if count == 1 then -- add "win"
			incrementStorage(player:getId(), Storage.overallWins, 1)
			incrementStorage(player:getId(), Storage.grimWins, 1)
		end

		-- The last player died, let's reset the event
		if count <= 1 then
			resetGrimEvent()
		end
	end

	return false
end

grimPrepareDeath:register()
