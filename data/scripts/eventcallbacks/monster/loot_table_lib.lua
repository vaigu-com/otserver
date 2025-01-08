---@enum MONSTER_LOOT_TIER
MONSTER_LOOT_LAYER = {
	base = "base",
	charmPseudo = "charmPseudo",
	boosted = "boosted",
	prey = "prey",
	wealthDuplex = "wealthDuplex",
	hazard = "hazard",
	bossReward = "bossReward",
	atelier = "atelier",
	raidSilver = "raidSilver",
}

function Player:canReceiveLoot()
	return self:getStamina() > 840
end

function GenerateLootRoll(layerName, monster, player, lootFactor, applyGut, filter)
	local mType = monster:getType()
	if not mType then
		logger.warning(debug.traceback("monsterOnDropLoot: monster has no type"))
		return
	end

	--3af add monster object-specific loot
	--	local totalLoot = table.merged(monster:generateLootRoll(player, lootFactor, applyGut, filter) , mType:generateLootRoll(player, lootFactor, applyGut, filter))
	if layerName == MONSTER_LOOT_LAYER.atelier then
		return monster:generateGemAtelierLoot()
	end
	if layerName == MONSTER_LOOT_LAYER.raidSilver then
		return {}
	end
	return mType:generateLootRoll(player, lootFactor, applyGut, filter)
end

LootTable = {}
LootTable.__index = LootTable
function LootTable.New(...)
	local newObj = {}
	setmetatable(newObj, LootTable)
	newObj.loot = {}
	return newObj
end
setmetatable(LootTable, {
	__call = function(_, ...)
		return LootTable.New(...)
	end,
})

function LootTable:Set(loot, lootLayer)
	self.loot[lootLayer] = loot
	return self
end

function LootTable:IsEmpty()
	for _, layerLoot in pairs(self.loot) do
		if TableSize(layerLoot) > 0 then
			return false
		end
	end
	return true
end

function LootTable:LowStamina(state)
	self.lowStamina = state
end

function LootTable:IsLowStamina()
	return self.lowStamina
end

function LootTable:HasBaseLayerLoot()
	return self.loot[MONSTER_LOOT_LAYER.base] ~= nil
end

function LootTable:HasNonBaseLayerLoot()
	for layerName, layerLoot in pairs(self.loot) do
		if layerName ~= MONSTER_LOOT_LAYER.base and TableSize(layerLoot) > 0 then
			return true
		end
	end
	return false
end

function LootTable:Get()
	return self.loot
end

LootTableRegistry = {}
LootTableRegistry.__index = LootTableRegistry
LootTableRegistry.registry = {}
function LootTableRegistry:Append(newLoot, monsterId, lootLayer)
	LootTableRegistry.registry[monsterId] = LootTableRegistry.registry[monsterId] or LootTable()
	LootTableRegistry.registry[monsterId]:Set(newLoot, lootLayer)
end

function LootTableRegistry:Get(monsterId)
	return LootTableRegistry.registry[monsterId]
end

function LootTableRegistry:LowStamina(monsterId)
	LootTableRegistry.registry[monsterId]:LowStamina(true)
end