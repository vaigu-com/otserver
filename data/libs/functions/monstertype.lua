-- Vaigu custom
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

local function tryRollItem(item, factor, applyGut, filter)
	local iType = ItemType(item.itemId)
	if filter and not filter(iType, item.unique) then
		return nil
	end

	local chance = item.chance

	local roll = getLootRandom(factor)
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

-- return a dictionary of itemId => { count, gut }
---@param player Player
---@param lootFactor number
---@param applyGut boolean
---@param filter? fun(itemType: ItemType, unique: boolean): boolean
---@return LootItems droppedItems
function MonsterType:generateLootRoll(player, lootFactor, applyGut, filter)
	if configManager.getNumber(configKeys.RATE_LOOT) <= 0 then
		return {}
	end

	local monsterLoot = self:getLoot() or {}
	lootFactor = lootFactor or 1.0

	if self:isRewardBoss() then
		lootFactor = lootFactor * SCHEDULE_BOSS_LOOT_RATE / 100
	end

	local droppedItems = {}
	local serverMultiplier = configManager.getNumber(configKeys.RATE_LOOT)
	lootFactor = (serverMultiplier * SCHEDULE_LOOT_RATE) * (lootFactor or 1)

	if ForceBaseLootMonsters[self.name] then
		lootFactor = 100
	elseif player and player:getStorageValueByKey(Storage.ForceBaseLoot) == FORCED_BASE_LOOT then
		lootFactor = 100
	end

	for _, candidateItem in pairs(monsterLoot) do
		local droppedItem = tryRollItem(candidateItem, lootFactor, applyGut, filter)
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
