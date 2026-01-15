local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.exaltationForge

local callback = EventCallback("MonsterOnDropLootForge")

function callback.monsterOnDropLoot(monster, corpse)
	if not monster or not corpse then
		return
	end
	local player = Player(corpse:getCorpseOwner())

	local totalLoot = TryGenerateLootRoll(lootLayer, monster, player, lootFactor, applyGut, filter)
	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
end

callback:register()

function Monster:generateForgeLoot()
	local mType = self:getType()
	if not mType then
		return {}
	end
	local category = "none"
	local forgeClassification = self:getMonsterForgeClassification()
	if forgeClassification == FORGE_INFLUENCED_MONSTER then
		return {}
	elseif forgeClassification == FORGE_FIENDISH_MONSTER then
		category = "fiendish"
	elseif (mType:bossRace() or ""):lower() == "archfoe" then
		category = "archfoe"
	end
	if category == "none" then
		return {}
	end

	local maxSlivers = configManager.getNumber(configKeys.FORGE_MAX_SLIVERS)
	local minSlivers = configManager.getNumber(configKeys.FORGE_MIN_SLIVERS)
	local sliverAmount = math.random(minSlivers, maxSlivers)

	local loot = {
		[ITEM_FORGE_SLIVER] = sliverAmount,
	}
	return loot
end
