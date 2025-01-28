local function isLootableRewardBoss(boss)
	if not boss or boss:isPlayer() or boss:getMaster() then
		return false
	end

	local monsterType = boss:getType()

	if monsterType and monsterType:isRewardBoss() then
		return true
	end
	return false
end

local bosstiarySlotsCount = 2
local baseLootFactor = 1

local bossDeath = CreatureEvent("BossDeath")

function bossDeath.onDeath(boss, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if not isLootableRewardBoss(boss) then
		return
	end

	if not corpse or not corpse.isContainer or not corpse:isContainer() then
		if corpse.getId then
			logger.debug("[bossDeath.onDeath] Boss {} has a corpse (id: {}, name: {}), but it is not a container.", boss:getName(), corpse:getId(), corpse:getName())
		else
			logger.debug("[bossDeath.onDeath] Boss {} does not have a corpse or corpse not found at position {}", boss:getName(), boss:getPosition())
		end
		corpse = Game.createItem(ITEM_BAG, 1)
	end
	corpse:registerReward()
	local bossMonsterId = boss:getId()
	local rewardId = corpse:getAttribute(ITEM_ATTRIBUTE_DATE)

	ResetAndSetTargetList(boss)

	-- Avoid dividing by zero
	local totalDamageOut, totalDamageIn, totalHealing = 0.1, 0.1, 0.1

	local playerScores = {}
	local info = _G.GlobalBosses[bossMonsterId]
	local damageMap = boss:getDamageMap()

	for guid, stats in pairs(info) do
		local player = Player(stats.playerId)
		local part = damageMap[stats.playerId]
		local damageOut, damageIn, healing = (stats.damageOut or 0) + (part and part.total or 0), stats.damageIn or 0, stats.healing or 0

		totalDamageOut = totalDamageOut + damageOut
		totalDamageIn = totalDamageIn + damageIn
		totalHealing = totalHealing + healing

		table.insert(playerScores, {
			player = player,
			guid = guid,
			damageOut = damageOut,
			damageIn = damageIn,
			healing = healing,
		})
	end

	local participantsCount = 0
	for _, con in ipairs(playerScores) do
		local score = (con.damageOut / totalDamageOut) + (con.damageIn / totalDamageIn) + (con.healing / totalHealing)
		-- Normalize to 0-1
		con.score = score / 3
		if score ~= 0 then
			participantsCount = participantsCount + 1
		end
	end
	table.sort(playerScores, function(a, b)
		return a.score > b.score
	end)

	for key, con in pairs(playerScores) do
		if con.score == 0 then
			playerScores[key] = nil
		end
	end

	local expectedScore = 1 / participantsCount
	local monsterType = boss:getType()
	local isBoosted = boss:getName():lower() == (Game.getBoostedBoss()):lower()

	for _, playerScore in ipairs(playerScores) do
		local player = playerScore.player or Game.getOfflinePlayer(playerScore.guid)

		local rewardItem = player:getReward(rewardId, true)

		-- Tone down the loot a notch if there are many participants
		local playerLootFactor = baseLootFactor / (participantsCount ^ (1 / 3))
		-- Increase the loot multiplicatively by how many times the player surpassed the expected score
		playerLootFactor = playerLootFactor * (1 + playerLootFactor) ^ (playerScore.score / expectedScore)
		-- Bosstiary Loot Bonus

		local rolls = 1
		local raceId = monsterType:raceId()
		if raceId ~= 0 then
			for i = 1, bosstiarySlotsCount do
				if player:getSlotBossId(i) then
					rolls = rolls + player:getBossBonus(i) / 100.0
				end
			end
		end

		-- decide if we get an extra roll
		if math.random(0, 100) < (rolls % 1) * 100 then
			rolls = math.ceil(rolls)
		else
			rolls = math.floor(rolls)
		end

		local lootRegistryIdentifier = tostring(bossMonsterId) .. "_" .. tostring(player:getId())
		if isBoosted then
			local bossLootBoosted = TryGenerateLootRoll(MONSTER_LOOT_LAYER.boosted, boss, player, configManager.getNumber(configKeys.BOOSTED_BOSS_LOOT_BONUS) / 100, applyGut)
			LootTableRegistry:Append(bossLootBoosted, lootRegistryIdentifier, MONSTER_LOOT_LAYER.boosted)
		end

		local bossLootAtelier = TryGenerateLootRoll(MONSTER_LOOT_LAYER.atelier, boss, player, baseLootFactor, applyGut)
		LootTableRegistry:Append(bossLootAtelier, lootRegistryIdentifier, MONSTER_LOOT_LAYER.atelier)

		for _ = 1, rolls do
			local bossLootBase = TryGenerateLootRoll(MONSTER_LOOT_LAYER.base, boss, player, playerLootFactor, applyGut)
			LootTableRegistry:Append(bossLootBase, lootRegistryIdentifier, MONSTER_LOOT_LAYER.base)
		end

		-- Add droped items to reward container
		local lootTable = LootTableRegistry:Get(lootRegistryIdentifier):Get()
		for _, lootLayer in pairs(MONSTER_LOOT_LAYER) do
			local items = lootTable[lootLayer]
			if items then
				rewardItem:addLoot(items)
			end
		end

		if playerScore.player and lootTable then
			local lootMessage = RewardbossLootParseDesc(boss, rewardItem, true, lootRegistryIdentifier)
			player:sendTextMessage(MESSAGE_LOOT, lootMessage)
		else
			player:save()
		end
	end
	_G.GlobalBosses[bossMonsterId] = nil
	return true
end

bossDeath:register()

local bossParticipation = CreatureEvent("BossParticipation")

function bossParticipation.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not next(_G.GlobalBosses) then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if not creature or not attacker then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local stats = creature:inBossFight()
	if not stats then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local creatureId, attackerId = creature:getId(), attacker:getId()
	-- Update player id
	stats.playerId = creatureId

	-- Account for healing of others active in the boss fight
	if primaryType == COMBAT_HEALING and attacker:isPlayer() and attackerId ~= creatureId then
		local healerStats = GetPlayerStats(stats.bossId, attacker:getGuid(), true)
		healerStats.active = true
		-- Update player id
		healerStats.playerId = attackerId
		healerStats.healing = healerStats.healing + primaryDamage
	elseif stats.bossId == attackerId then
		-- Account for damage taken from the boss
		stats.damageIn = stats.damageIn + primaryDamage
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

bossParticipation:register()

local loginBossPlayer = CreatureEvent("LoginBossPlayer")

function loginBossPlayer.onLogin(player)
	player:registerEvent("BossDeath")
	return true
end

loginBossPlayer:register()

local bossThink = CreatureEvent("BossThink")

function bossThink.onThink(creature, interval)
	if not creature then
		return true
	end

	ResetAndSetTargetList(creature)
end

bossThink:register()
