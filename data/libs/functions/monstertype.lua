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

-- return a dictionary of itemId => { count, gut }
---@param config { factor: number, gut: boolean, filter?: fun(itemType: ItemType, unique: boolean): boolean }
---@return LootItems
function MonsterType:generateLootRoll(config, resultTable, player)
	if configManager.getNumber(configKeys.RATE_LOOT) <= 0 then
		return resultTable or {}
	end

	local monsterLoot = self:getLoot() or {}
	local factor = config.factor or 1.0
	local uniqueItems = {}

	if self:isRewardBoss() then
		factor = factor * SCHEDULE_BOSS_LOOT_RATE / 100
	end

	local result = resultTable or {}
	local forceBaseLoot = false
	if ForceBaseLootMonsters[self.name] then
		forceBaseLoot = true
	end
	if player:getStorageValue(Storage.ForceBaseLoot) == FORCED_BASE_LOOT then
		forceBaseLoot = true
	end
	for _, item in ipairs(monsterLoot) do
		local iType = ItemType(item.itemId)
		if config.filter and not config.filter(iType, item.unique) then
			goto continue
		end
		if uniqueItems[item.itemId] then
			goto continue
		end
		if not result[item.itemId] then
			result[item.itemId] = { count = 0, gut = false }
		end

		local chance = item.chance
		if config.gut and iType:getType() == ITEM_TYPE_CREATUREPRODUCT then
			chance = math.ceil((chance * GLOBAL_CHARM_GUT) / 100)
		end

		local randValue = getLootRandom(factor, forceBaseLoot)
		if randValue >= chance then
			goto continue
		end

		local count = 0
		local charges = iType:getCharges()
		if charges > 0 then
			count = charges
		elseif iType:isStackable() then
			local maxc, minc = item.maxCount or 1, item.minCount or 1
			count = math.max(0, randValue % (maxc - minc + 1)) + minc
		else
			count = 1
		end

		result[item.itemId].count = result[item.itemId].count + count
		result[item.itemId].gut = config.gut and iType:getType() == ITEM_TYPE_CREATUREPRODUCT
		result[item.itemId].unique = item.unique
		result[item.itemId].subType = item.subType
		result[item.itemId].text = item.text
		result[item.itemId].actionId = item.actionId

		if count > 0 and item.unique then
			uniqueItems[item.itemId] = true
		end

		::continue::
	end

	for itemId, item in pairs(result) do
		if item.count <= 0 then
			result[itemId] = nil
		end
	end

	return result
end
