local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.wealthDuplex

local callback = EventCallback("MonsterOnDropLootWealthDuplex")

function callback.monsterOnDropLoot(monster, corpse)
	local player = Player(corpse:getCorpseOwner())
	if not player or not player:canReceiveLoot() then
		return
	end
	local mType = monster:getType()
	if not mType then
		return
	end

	local participants = { player }
	if configManager.getBoolean(configKeys.PARTY_SHARE_LOOT_BOOSTS) then
		local party = player:getParty()
		if party and party:isSharedExperienceEnabled() then
			participants = party:getMembers()
			table.insert(participants, party:getLeader())
		end
	end

	local wealthDuplex = Concoction.find(Concoction.Ids.WealthDuplex)
	if not wealthDuplex then
		logger.debug("[Monster:onDropLoot] - Could not find WealthDuplex concoction.")
		return
	end

	local chance = 0
	local wealthActivators = {}
	for _, participant in ipairs(participants) do
		if participant and wealthDuplex:active(participant) then
			chance = chance + wealthDuplex.config.rate
			table.insert(wealthActivators, participant:getName())
		end
	end

	if #wealthActivators > 0 then
		local numActivators = #wealthActivators
		chance = (chance / numActivators) ^ configManager.getFloat(configKeys.PARTY_SHARE_LOOT_BOOSTS_DIMINISHING_FACTOR)
	end

	local rolls = chance / 100
	if math.random(0, 100) < (rolls % 1) * 100 then
		rolls = math.ceil(rolls)
	else
		rolls = math.floor(rolls)
	end

	if rolls == 0 then
		return
	end

	local totalLoot = {}
	for _ = 1, rolls do
		totalLoot = table.merged(totalLoot, TryGenerateLootRoll(MONSTER_LOOT_LAYER.wealthDuplex, monster, player, lootFactor, applyGut, filter))
	end

	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
end

callback:register()
