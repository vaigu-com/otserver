local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.prey

local callback = EventCallback()

function callback.monsterOnDropLoot(monster, corpse)
	local player = Player(corpse:getCorpseOwner())
	if not player then
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

	local preyChance = 0
	local preyActivators = {}
	for _, participant in ipairs(participants) do
		local participantChance = participant:getPreyLootPercentage(mType:raceId())
		table.insert(preyActivators, participant:getName())
		preyChance = preyChance + participantChance
	end
	if #preyActivators > 0 then
		local numActivators = #preyActivators
		preyChance = (preyChance / numActivators) ^ configManager.getFloat(configKeys.PARTY_SHARE_LOOT_BOOSTS_DIMINISHING_FACTOR)
	end
	if math.random(1, 100) > preyChance then
		return
	end

	local totalLoot = TryGenerateLootRoll(lootLayer, monster, player, lootFactor, applyGut, filter)
	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
end

callback:register()
