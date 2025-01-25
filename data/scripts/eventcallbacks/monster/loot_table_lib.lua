---@enum MONSTER_LOOT_LAYER
MONSTER_LOOT_LAYER = {
	base = "base",
	charmPseudo = "charmPseudo",
	boosted = "boosted",
	prey = "prey",
	wealthDuplex = "wealthDuplex",
	hazard = "hazard",
	atelier = "atelier",
	raidSilver = "raidSilver",
}

ForceBaseLootMonsters = {
	--Issavi
	["Burning Gladiator"] = true,
	["Priestess of the Wild Sun"] = true,
	["Black Sphinx Acolyte"] = true,
	["Young Goanna"] = true,
	["Adult Goanna"] = true,
	["Lamassu"] = true,
	["Sphinx"] = true,
	["Feral Sphinx"] = true,
	["Crypt Warden"] = true,
	["Ogre Rowdy"] = true,
	["Ogre Ruffian"] = true,
	["Ogre Sage"] = true,
	-- Deathlings
	["Deathling Scout"] = true,
	["Deathling Spellsinger"] = true,
	-- Dire Spectres
	["Gazer Spectre"] = true,
	["Ripper Spectre"] = true,
	["Burster Spectre"] = true,
	-- The Secret Library
	["Burning Book"] = true,
	["Rage Squid"] = true,
	["Guardian of Tales"] = true,
	["Ink Blob"] = true,
	["Icecold Book"] = true,
	["Squid Warden"] = true,
	["Animated Feather"] = true,
	["Energetic Book"] = true,
	["Brain Squid"] = true,
	["Energuardian of Tales"] = true,
	["Knowledge Elemental"] = true,
	["Biting Book"] = true,
	["Cursed Book"] = true,
	-- Roshamuul weak
	["Weakened Frazzlemaw"] = true,
	["Enfeebled Silencer"] = true,
	-- Roshamuul
	["Frazzlemaw"] = true,
	["Guzzlemaw"] = true,
	["Silencer"] = true,
	["Retching Horror"] = true,
	["Choking Fear"] = true,
	["Arachnophobica"] = true,
	-- Court of Summer; Court of winter
	["Crazed Winter Vanguard"] = true,
	["Crazed Winter Rearguard"] = true,
	["Crazed Summer Vanguard"] = true,
	["Crazed Summer Rearguard"] = true,
	["Insane Siren"] = true,
	["Soul-Broken Harbinger"] = true,
	-- Carnivora's Rocks
	["Spiky Carnivor"] = true,
	["Menacing Carnivor"] = true,
	["Lumbering Carnivor"] = true,
	-- Ferumbras Ascendant
	["Grimeleech"] = true,
	["Hellflayer"] = true,
	["Vexclaw"] = true,
	-- Asuri
	["Dawnfire Asura"] = true,
	["Midnight Asura"] = true,
	["Frost Flower Asura"] = true,
	["True Midnight Asura"] = true,
	["True Dawnfire Asura"] = true,
	["True Frost Flower Asura"] = true,
	-- Deep Desert
	["Skeleton Elite Warrior"] = true,
	["Undead Elite Gladiator"] = true,
	-- Falcon Bastion
	["Falcon Knight"] = true,
	["Falcon Paladin"] = true,
	["Cobra Assassin"] = true,
	["Cobra Scout"] = true,
	["Cobra Vizier"] = true,
	-- Glooth
	["Glooth Bandit"] = true,
	["Glooth Brigand"] = true,
	["Glooth Golem"] = true,
	["Devourer"] = true,
	-- Otherworld
	["Reality Reaver"] = true,
	["Dread Intruder"] = true,
	["Breach Brood"] = true,
	["Sparkion"] = true,
	-- Warzone 5,6; Gnome Deep Hub
	["Cave Devourer"] = true,
	["Tunnel Tyrant"] = true,
	["Deepworm"] = true,
	["Diremaw"] = true,
	-- Draken
	["Draken Warmaster"] = true,
	["Draken Spellweaver"] = true,
	["Draken Abomination"] = true,
	["Dark Torturer"] = true,
	["Medusa"] = true,
	["Serpent Spawn"] = true,
	["Werefox"] = true,
	["Werebadger"] = true,
	["Werelion"] = true,
	["Werelioness"] = true,
	["White Lion"] = true,
}

local function tryRollItem(item, factor, applyGut)
	local iType = ItemType(item.itemId)

	local chance = item.chance

	local roll = randomLootRoll(factor)
	local chanceWithGut = nil
	if applyGut and iType:getType() == ITEM_TYPE_CREATUREPRODUCT then
		chanceWithGut = math.ceil((chance * GLOBAL_CHARM_GUT) / 100)
	end

	if applyGut then
		if not (roll >= chance and chanceWithGut <= roll) then
			return
		end
	elseif roll >= chance then
		return
	end

	local count = 0
	local charges = iType:getCharges()
	if charges > 0 then
		count = charges
	elseif iType:isStackable() then
		local maxc, minc = item.maxCount or 1, item.minCount or 1
		count = math.max(0, roll % (maxc - minc + 1)) + minc
	else
		count = 1
	end

	if count == 0 then
		return nil
	end

	local droppedItem = {
		id = item.itemId,
		count = count,
		subType = item.subType,
		text = item.text,
		actionId = item.actionId,
		key = item.key,
	}
	return droppedItem
end

local function extractPossibleLoot(monsterOrType)
	return monsterOrType:getLoot()
end

function Player:canReceiveLoot()
	return self:getStamina() > 840
end

local function generateLootRoll(possibleLoot, monsterType, player, lootFactor, applyGut)
	lootFactor = lootFactor or 1.0

	if monsterType:isRewardBoss() then
		lootFactor = lootFactor * SCHEDULE_BOSS_LOOT_RATE / 100
	end

	local droppedItems = {}
	local serverMultiplier = configManager.getNumber(configKeys.RATE_LOOT)
	lootFactor = serverMultiplier * (lootFactor or 1) * (SCHEDULE_LOOT_RATE / 100)

	if ForceBaseLootMonsters[monsterType:getName()] then
		lootFactor = 1.0
	elseif player and player:getStorageValueByKey(Storage.ForceBaseLoot) == FORCED_BASE_LOOT then
		lootFactor = 1.0
	end

	for _, candidateItem in pairs(possibleLoot) do
		local droppedItem = tryRollItem(candidateItem, lootFactor, applyGut)
		if droppedItem then
			local existingItem = droppedItems[droppedItem.id]
			if existingItem then
				existingItem.count = existingItem.count + droppedItem.count
			else
				droppedItems[droppedItem.id] = droppedItem
			end
		end
	end
	return droppedItems
end

---@param layerName MONSTER_LOOT_LAYER
---@param monster Monster
---@param player Player
---@param lootFactor number 0 to 1
---@param applyGut boolean
---@return table loot
function TryGenerateLootRoll(layerName, monster, player, lootFactor, applyGut)
	if configManager.getNumber(configKeys.RATE_LOOT) <= 0 then
		return {}
	end

	local monsterType = monster:getType()
	if not monsterType then
		logger.warning(debug.traceback("monsterOnDropLoot: monster has no type"))
		return
	end

	if monsterType:isRewardBoss() then
		lootFactor = lootFactor * SCHEDULE_BOSS_LOOT_RATE / 100
	end

	if layerName == MONSTER_LOOT_LAYER.atelier then
		return monster:generateGemAtelierLoot()
	end
	if layerName == MONSTER_LOOT_LAYER.raidSilver then
		return GenerateLootRollMonster(monster, player, lootFactor, applyGut)
	end
	return GenerateLootRollMonsterType(monsterType, player, lootFactor, applyGut)
end

function GenerateLootRollMonster(monster, player, lootFactor, applyGut)
	return generateLootRoll(extractPossibleLoot(monster), monster:getType(), player, lootFactor, applyGut)
end

function GenerateLootRollMonsterType(monsterType, player, lootFactor, applyGut)
	return generateLootRoll(extractPossibleLoot(monsterType), monsterType, player, lootFactor, applyGut)
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
