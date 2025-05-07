MonsterTypeRepository = {}
MonsterTypeRepository.__index = MonsterTypeRepository
MonsterTypeRepository.registry = {}
function MonsterTypeRepository:Add(name, data)
	self.registry[name] = data
end

local rme_dir = "../rme/"
local monstersXmlPath = rme_dir .. "data/creatures/monsters.xml"

local function extractCorpseData(firstStageId)
	local firstStageitem = ItemType(firstStageId)
	if not firstStageitem then
		return
	end
	local secondStageId = firstStageitem:getDecayId()
	if not secondStageId or (secondStageId == 0) or (secondStageId == -1) then
		return
	end

	local secondStageItem = ItemType(secondStageId)
	if not secondStageItem or (not secondStageItem:isContainer()) then
		return
	end

	return firstStageId, secondStageId
end

function MonsterTypeRepository:SerializeCorpses()
	local corpseIds = {}
	for name, data in pairs(self.registry) do
		local firstStageId, secondStageId = extractCorpseData(data.corpse)
		if firstStageId and secondStageId then
			local previousId = corpseIds[firstStageId]
			if previousId ~= secondStageId and previousId ~= nil then
				print(firstStageId, ":", previousId, secondStageId)
			end
			corpseIds[firstStageId] = secondStageId
		end
	end

	local corpseIdsStr = ""
	for key, value in pairs(corpseIds) do
		corpseIdsStr = corpseIdsStr .. "\n" .. key .. ", " .. value
	end

	local file = io.open("corpseIds.txt", "w+")
	if not file then
		logger.error(T("[MonsterTypeRepository::SerializeCorpses] Cannot open file :path:. Cropses have NOT been serialized.", { path = monstersXmlPath }))
		return
	end
	file:write(corpseIdsStr)
	file:close()
	logger.info("[MonsterTypeRepository::SerializeCorpses] Serialization succesful.")
end

function MonsterTypeRepository:Serialize()
	local xml = '<?xml version="1.0" encoding="UTF-8"?>\n<monsters>\n'
	for name, data in
		sortedkeypairs(self.registry, function(a, b)
			return a:lower() < b:lower()
		end)
	do
		xml = xml
			.. T('\t<monster name=":name:" looktype=":looktype:" lookhead=":lookhead:" lookbody=":lookbody:" looklegs=":looklegs:" lookfeet=":lookfeet:" lookaddon=":lookaddon:" lookitem = ":lookitem:"/>\n', {
				name = name,
				looktype = data.outfit.lookType or 0,
				lookhead = data.outfit.lookHead or 0,
				lookbody = data.outfit.lookBody or 0,
				looklegs = data.outfit.lookLegs or 0,
				lookfeet = data.outfit.lookFeet or 0,
				lookaddon = data.outfit.lookAddons or 0,
				lookitem = data.outfit.lookTypeEx or 0,
			})
	end
	xml = xml .. "</monsters>\n"
	local file = io.open(monstersXmlPath, "w+")
	if not file then
		logger.error(T("[MonsterTypeRepository::Serialize] Cannot open file :path:. Monsters have NOT been serialized.", { path = monstersXmlPath }))
		return
	end
	file:write(xml)
	file:close()
	logger.info("[MonsterTypeRepository::Serialize] Serialization succesful.")
end

registerMonsterType = {}
setmetatable(registerMonsterType, {
	__call = function(self, mtype, mask)
		for _, parse in pairs(self) do
			parse(mtype, mask)
		end
	end,
})

local bestiarykillcountRealToVaigu = {
	[5000] = {
		toKill = 2000,
		FirstUnlock = 500,
		SecondUnlock = 1000,
		CharmsPoints = 100,
	},
	[2500] = {
		toKill = 1000,
		FirstUnlock = 50,
		SecondUnlock = 500,
		CharmsPoints = 50,
	},
	[1000] = {
		toKill = 200,
		FirstUnlock = 25,
		SecondUnlock = 50,
		CharmsPoints = 25,
	},
	[500] = {
		toKill = 50,
		FirstUnlock = 10,
		SecondUnlock = 25,
		CharmsPoints = 15,
	},
	[250] = {
		toKill = 25,
		FirstUnlock = 5,
		SecondUnlock = 10,
		CharmsPoints = 5,
	},
	[25] = {
		toKill = 10,
		FirstUnlock = 3,
		SecondUnlock = 5,
		CharmsPoints = 1,
	},
	[5] = {
		toKill = 5,
		FirstUnlock = 2,
		SecondUnlock = 3,
		CharmsPoints = 50,
	},
}

local nameToNewExp = {
	["Anomaly"] = 200000,
	["Behemoth"] = 3000,
	["Blightwalker"] = 7500,
	["Blue Djinn"] = 300,
	["Bog Raider"] = 1000,
	["Bones"] = 10000,
	["Bragrumol"] = 40000,
	["Braindeath"] = 1100,
	["Bretzecutioner"] = 6000,
	["Crawler"] = 1300,
	["Crystalcrusher"] = 700,
	["Deepworm"] = 2900,
	["Diremaw"] = 3200,
	["Dreadmaw"] = 4000,
	["Drillworm"] = 1400,
	["Elder Wyrm"] = 2700,
	["Eradicator"] = 200000,
	["Falcon Knight"] = 8000,
	["Falcon Paladin"] = 8000,
	["Ferumbras"] = 100000,
	["Flamecaller Zazrak"] = 6000,
	["Frost Giant"] = 220,
	["Frost Giantess"] = 220,
	["Furyosa"] = 20000,
	["Gravelord Oshuran"] = 4000,
	["Green Djinn"] = 300,
	["Hellflayer"] = 14000,
	["Ironblight"] = 6100,
	["Jaul"] = 70000,
	["Juggernaut"] = 15000,
	["Kollos"] = 3000,
	["Lizard Gate Guardian"] = 5000,
	["Lost Exile"] = 2000,
	["Lost Husher"] = 2000,
	["Mawhawk"] = 33000,
	["Obujos"] = 40000,
	["Ogre Brute"] = 1000,
	["Orc Leader"] = 340,
	["Orewalker"] = 6700,
	["Outburst"] = 200000,
	["Owin"] = 10000,
	["Plaguesmith"] = 6000,
	["Rotspit"] = 7000,
	["Shock Head"] = 4000,
	["Spidris"] = 3300,
	["Spitter"] = 1400,
	["Stampor"] = 1000,
	["The Voice of Ruin"] = 8000,
	["War Golem"] = 3700,
	["Wiggler"] = 1100,
	["Worker Golem"] = 1700,
	["Yakchal"] = 7000,
	["Zulazza the Corruptor"] = 50000,
}

local function countMonsters(filePath)
	local monsterCounts = {}

	local xml = io.open(filePath, "r")
	if not xml then
		logger.warn("[countMonsters] file not found: " .. filePath)
		return {}
	end

	for name in xml:read("*a"):gmatch('<monster%s+[^>]-name="(.-)"') do
		monsterCounts[name] = (monsterCounts[name] or 0) + 1
	end
	xml:close()

	return monsterCounts
end

local function applyCustomExp(mask)
	if not mask.name then
		return mask
	end

	local newExp = nameToNewExp[mask.name]
	if not newExp then
		return mask
	end

	mask.experience = newExp
	return mask
end

local countToMultiplier = {
	--impossible
	--[0] = 1,

	[1] = 0.25,
	[2] = 0.25,
	[3] = 0.25,
	[4] = 0.25,
	[5] = 0.25,

	[6] = 0.5,
	[7] = 0.5,
	[8] = 0.5,
	[9] = 0.5,
	[10] = 0.5,

	[11] = 0.75,
	[12] = 0.75,
	[13] = 0.75,
	[14] = 0.75,
	[15] = 0.75,
	[16] = 0.75,
	[17] = 0.75,
	[18] = 0.75,
	[19] = 0.75,
	[20] = 0.75,
}

local monsterNameToCountOnMap = nil
local function applyCustomBestiaryKillCounts(mask, monsterType)
	monsterNameToCountOnMap = monsterNameToCountOnMap or countMonsters(DATA_DIRECTORY .. "/world/vaigu-monster.xml")
	if mask.Bestiary and mask.Bestiary.toKill then
		local newData = bestiarykillcountRealToVaigu[mask.Bestiary.toKill]
		if not newData then
			logger.warn(T("[applyCustomBestiaryKillCounts] Unknown realtibia 'toKill' :toKill:. No modifications were applied.", { toKill = mask.Bestiary.toKill }))
			return mask
		end

		mask.Bestiary.toKill = newData.toKill
		mask.Bestiary.FirstUnlock = newData.FirstUnlock
		mask.Bestiary.SecondUnlock = newData.SecondUnlock
		mask.Bestiary.CharmsPoints = newData.CharmsPoints
		if mask.Bestiary.toKill > 25 then
			local monsterName = monsterType:name()
			local monsterCount = monsterNameToCountOnMap[monsterName]
			local bestiaryMultiplier = countToMultiplier[monsterCount]
			if monsterCount and bestiaryMultiplier then
				logger.trace(T("Monster :name: has only :count: spawn points! Its bestiary kill counts have been reduced accordingly.", { name = monsterName, count = monsterCount }))
			end
			bestiaryMultiplier = bestiaryMultiplier or 1
			mask.Bestiary.toKill = math.ceil(mask.Bestiary.toKill * bestiaryMultiplier)
			mask.Bestiary.FirstUnlock = math.ceil(mask.Bestiary.FirstUnlock * bestiaryMultiplier)
			mask.Bestiary.SecondUnlock = math.ceil(mask.Bestiary.SecondUnlock * bestiaryMultiplier)

			bestiaryMultiplier = bestiaryMultiplier or 1
			--logger.warn(monsterType:name(), monsterCount, countToMultiplier[monsterCount])
		end
	end

	return mask
end

local customAttributeCallbacks = {
	applyCustomBestiaryKillCounts,
	applyCustomExp,
}
local function applyCustomAttributes(mask, monsterType)
	for _, callback in pairs(customAttributeCallbacks) do
		mask = callback(mask, monsterType)
		break
	end
	return mask
end

MonsterType.register = function(self, mask)
	mask = applyCustomAttributes(mask, self)
	registerMonsterType(self, mask)
	MonsterTypeRepository:Add(self:getUniqueName(), mask)
end

local smallAreaRadius = 3
local superDrunkDuration = 4000

registerMonsterType.name = function(mtype, mask)
	if mask.name then
		mtype:name(mask.name)
		-- Try register hazard monsters
		mtype.onSpawn = function(monster, spawnPosition)
			HazardMonster.onSpawn(monster, spawnPosition)
		end
	end
end
registerMonsterType.description = function(mtype, mask)
	if mask.description then
		mtype:nameDescription(mask.description)
	end
end
registerMonsterType.variant = function(mtype, mask)
	if mask.variant then
		mtype:variant(mask.variant)
	end
end
registerMonsterType.experience = function(mtype, mask)
	if mask.experience then
		mtype:experience(mask.experience)
	end
end
registerMonsterType.raceId = function(mtype, mask)
	if mask.raceId then
		mtype:raceId(mask.raceId)
	end
end
registerMonsterType.Bestiary = function(mtype, mask)
	if mask.Bestiary then
		if mask.Bestiary.race then
			mtype:Bestiaryrace(mask.Bestiary.race)
		end
		if mask.Bestiary.class then
			mtype:Bestiaryclass(mask.Bestiary.class)
		end
		if mask.Bestiary.toKill then
			mtype:BestiarytoKill(mask.Bestiary.toKill)
		end
		if mask.Bestiary.FirstUnlock then
			mtype:BestiaryFirstUnlock(mask.Bestiary.FirstUnlock)
		end
		if mask.Bestiary.SecondUnlock then
			mtype:BestiarySecondUnlock(mask.Bestiary.SecondUnlock)
		end
		if mask.Bestiary.CharmsPoints then
			mtype:BestiaryCharmsPoints(mask.Bestiary.CharmsPoints)
		end
		if mask.Bestiary.Stars then
			mtype:BestiaryStars(mask.Bestiary.Stars)
		end
		if mask.Bestiary.Occurrence then
			mtype:BestiaryOccurrence(mask.Bestiary.Occurrence)
		end
		if mask.Bestiary.Locations then
			mtype:BestiaryLocations(mask.Bestiary.Locations)
		end
	end
end
registerMonsterType.bosstiary = function(mtype, mask)
	local bossClass = nil
	if mask.bosstiary then
		if mask.bosstiary.bossRace then
			if mask.bosstiary.bossRace == RARITY_BANE then
				bossClass = "Bane"
			elseif mask.bosstiary.bossRace == RARITY_ARCHFOE then
				bossClass = "Archfoe"
			elseif mask.bosstiary.bossRace == RARITY_NEMESIS then
				bossClass = "Nemesis"
			end
		end
		if bossClass == nil then
			logger.error("Attempting to register a bosstiary boss without a race. Boss name: {}", mtype:name())
			return
		end
		if mask.bosstiary.bossRaceId then
			mtype:bossRaceId(mask.bosstiary.bossRaceId)
		else
			logger.error("Attempting to register a bosstiary boss without a raceId. Boss name: {}", mtype:name())
		end
		mtype:bossRace(mask.bosstiary.bossRace, bossClass)
	end
end
registerMonsterType.skull = function(mtype, mask)
	if mask.skull then
		mtype:skull(mask.skull)
	end
end
registerMonsterType.outfit = function(mtype, mask)
	if mask.outfit then
		mtype:outfit(mask.outfit)
	end
end
registerMonsterType.maxHealth = function(mtype, mask)
	if mask.maxHealth then
		mtype:maxHealth(mask.maxHealth)
	end
end
registerMonsterType.health = function(mtype, mask)
	if mask.health then
		mtype:health(mask.health)
	end
end
registerMonsterType.race = function(mtype, mask)
	if mask.race then
		mtype:race(mask.race)
	end
end
registerMonsterType.manaCost = function(mtype, mask)
	if mask.manaCost then
		mtype:manaCost(mask.manaCost)
	end
end
registerMonsterType.speed = function(mtype, mask)
	if mask.speed then
		mtype:baseSpeed(mask.speed)
	end
end
registerMonsterType.corpse = function(mtype, mask)
	if mask.corpse then
		mtype:corpseId(mask.corpse)
	end
end
registerMonsterType.faction = function(mtype, mask)
	if mask.faction then
		mtype:faction(mask.faction)
	end
end
registerMonsterType.targetPreferPlayer = function(mtype, mask)
	if mask.targetPreferPlayer then
		mtype:targetPreferPlayer(mask.targetPreferPlayer)
	end
end
registerMonsterType.targetPreferMaster = function(mtype, mask)
	if mask.targetPreferMaster then
		mtype:targetPreferMaster(mask.targetPreferMaster)
	end
end
registerMonsterType.enemyFactions = function(mtype, mask)
	if mask.enemyFactions then
		for _, enemyFaction in pairs(mask.enemyFactions) do
			if not enemyFaction then
				print('[Error - Loading monsters] Monster: "' .. mtype:name() .. '". Unknown enemy faction.')
			else
				mtype:enemyFactions(enemyFaction)
			end
		end
	end
end
registerMonsterType.flags = function(mtype, mask)
	if mask.flags then
		if mask.flags.attackable ~= nil then
			mtype:isAttackable(mask.flags.attackable)
		end
		if mask.flags.convinceable ~= nil then
			mtype:isConvinceable(mask.flags.convinceable)
		end
		if mask.flags.summonable ~= nil then
			mtype:isSummonable(mask.flags.summonable)
		end
		if mask.flags.illusionable ~= nil then
			mtype:isIllusionable(mask.flags.illusionable)
		end
		if mask.flags.hostile ~= nil then
			mtype:isHostile(mask.flags.hostile)
		end
		if mask.flags.healthHidden ~= nil then
			mtype:isHealthHidden(mask.flags.healthHidden)
		end
		if mask.flags.pushable ~= nil then
			mtype:isPushable(mask.flags.pushable)
		end
		if mask.flags.canPushItems ~= nil then
			mtype:canPushItems(mask.flags.canPushItems)
		end
		if mask.flags.rewardBoss then
			mtype:isRewardBoss(mask.flags.rewardBoss)
			mtype.onSpawn = function(monster, spawnPosition)
				monster:setReward(true)
			end
		end
		if mask.flags.familiar then
			mtype:familiar(mask.flags.familiar)
		end
		if mask.flags.respawntype or mask.flags.respawnType then
			logger.warn("[registerMonsterType.flags] - Monster: {}. Deprecated flag 'respawnType', use instead table 'respawnType = { period = RespawnPeriod_t, underground = boolean}'", mtype:name())
		end
		if mask.flags.canPushCreatures ~= nil then
			mtype:canPushCreatures(mask.flags.canPushCreatures)
		end
		if mask.flags.critChance ~= nil then
			mtype:critChance(mask.flags.critChance)
		end
		if mask.flags.targetDistance then
			mtype:targetDistance(math.max(1, mask.flags.targetDistance))
		end
		if mask.flags.runHealth then
			mtype:runHealth(mask.flags.runHealth)
		end
		if mask.flags.staticAttackChance then
			mtype:staticAttackChance(mask.flags.staticAttackChance)
		end
		if mask.flags.canWalkOnEnergy ~= nil then
			mtype:canWalkOnEnergy(mask.flags.canWalkOnEnergy)
		end
		if mask.flags.canWalkOnFire ~= nil then
			mtype:canWalkOnFire(mask.flags.canWalkOnFire)
		end
		if mask.flags.canWalkOnPoison ~= nil then
			mtype:canWalkOnPoison(mask.flags.canWalkOnPoison)
		end
		if mask.flags.isBlockable ~= nil then
			mtype:isBlockable(mask.flags.isBlockable)
		end
		if mask.flags.isForgeCreature ~= nil then
			mtype:isForgeCreature(mask.flags.isForgeCreature)
		end
		if mask.flags.ignoreCreatures ~= nil then
			mtype:ignoreCreatures(mask.flags.ignoreCreatures)
		end
	end
end
registerMonsterType.light = function(mtype, mask)
	if mask.light then
		local color = 0
		if mask.light.color then
			color = mask.light.color
		end
		if mask.light.level then
			mtype:light(color, mask.light.level)
		end
	end
end
registerMonsterType.changeTarget = function(mtype, mask)
	if mask.changeTarget then
		if mask.changeTarget.chance then
			mtype:changeTargetChance(mask.changeTarget.chance)
		end
		if mask.changeTarget.interval then
			mtype:changeTargetSpeed(mask.changeTarget.interval)
		end
	end
end
registerMonsterType.strategiesTarget = function(mtype, mask)
	if mask.strategiesTarget then
		if mask.strategiesTarget.nearest then
			mtype:strategiesTargetNearest(mask.strategiesTarget.nearest)
		end
		if mask.strategiesTarget.health then
			mtype:strategiesTargetHealth(mask.strategiesTarget.health)
		end
		if mask.strategiesTarget.damage then
			mtype:strategiesTargetDamage(mask.strategiesTarget.damage)
		end
		if mask.strategiesTarget.random then
			mtype:strategiesTargetRandom(mask.strategiesTarget.random)
		end
	end
end
registerMonsterType.respawnType = function(mtype, mask)
	if mask.respawnType then
		if mask.respawnType.period then
			mtype:respawnTypePeriod(mask.respawnType.period)
		end
		if mask.respawnType.underground then
			mtype:respawnTypeIsUnderground(mask.respawnType.underground)
		end
	end
end
registerMonsterType.sounds = function(mtype, mask)
	if type(mask.sounds) == "table" then
		if mask.sounds.death then
			mtype:deathSound(mask.sounds.death)
		end
		if mask.sounds.ticks and mask.sounds.chance and mask.sounds.ids and type(mask.sounds.ids) == "table" and #mask.sounds.ids > 0 then
			mtype:soundSpeedTicks(mask.sounds.ticks)
			mtype:soundChance(mask.sounds.chance)
			for _, v in pairs(mask.sounds.ids) do
				mtype:addSound(v)
			end
		end
	end
end
registerMonsterType.voices = function(mtype, mask)
	if type(mask.voices) == "table" then
		local interval, chance
		if mask.voices.interval then
			interval = mask.voices.interval
		end
		if mask.voices.chance then
			chance = mask.voices.chance
		end
		for k, v in pairs(mask.voices) do
			if type(v) == "table" then
				mtype:addVoice(v.text, interval, chance, v.yell)
			end
		end
	end
end
registerMonsterType.summon = function(mtype, mask)
	if mask.summon then
		if mask.summon.maxSummons then
			mtype:maxSummons(mask.summon.maxSummons)
		end
		if type(mask.summon.summons) == "table" then
			for k, v in pairs(mask.summon.summons) do
				mtype:addSummon(v.name, v.interval, v.chance, v.count)
			end
		end
	end
end
registerMonsterType.events = function(mtype, mask)
	if type(mask.events) == "table" then
		for k, v in pairs(mask.events) do
			mtype:registerEvent(v)
		end
	end
end

function SortLootByChance(loot)
	if not configManager.getBoolean(configKeys.SORT_LOOT_BY_CHANCE) then
		return
	end

	table.sort(loot, function(loot1, loot2)
		if not loot1.chance or not loot2.chance then
			return 0
		end

		return loot1.chance < loot2.chance
	end)
end

function Loot.fromItem(loot)
	local lootError = false
	local parent = Loot()
	if loot.name then
		if not parent:setIdFromName(loot.name) then
			lootError = true
		end
	else
		if not isInteger(loot.id) or loot.id < 1 then
			lootError = true
		end
		parent:setId(loot.id)
	end
	if loot.subType or loot.charges then
		parent:setSubType(loot.subType or loot.charges)
	else
		local lType = ItemType(loot.name and loot.name or loot.id)
		if lType and lType:getCharges() > 1 then
			parent:setSubType(lType:getCharges())
		end
	end
	if loot.chance then
		parent:setChance(loot.chance)
	end
	if loot.minCount then
		parent:setMinCount(loot.minCount)
	end
	if loot.maxCount then
		parent:setMaxCount(loot.maxCount)
	end
	if loot.aid or loot.actionId then
		parent:setActionId(loot.aid or loot.actionId)
	end
	if loot.text or loot.description then
		parent:setText(loot.text or loot.description)
	end
	if loot.name then
		parent:setNameItem(loot.name)
	end
	if loot.article then
		parent:setArticle(loot.article)
	end
	if loot.attack then
		parent:setAttack(loot.attack)
	end
	if loot.defense then
		parent:setDefense(loot.defense)
	end
	if loot.extraDefense or loot.extraDef then
		parent:setExtraDefense(loot.extraDefense or loot.extraDef)
	end
	if loot.armor then
		parent:setArmor(loot.armor)
	end
	if loot.shootRange or loot.range then
		parent:setShootRange(loot.shootRange or loot.range)
	end
	if loot.unique then
		parent:setUnique(loot.unique)
	end
	if loot.child then
		SortLootByChance(loot.child)
		for _, children in pairs(loot.child) do
			local child = Loot()
			if children.name then
				if not child:setIdFromName(children.name) then
					lootError = true
				end
			else
				if not isInteger(children.id) or children.id < 1 then
					lootError = true
				end
				child:setId(children.id)
			end
			if children.subType or children.charges then
				child:setSubType(children.subType or children.charges)
			else
				local cType = ItemType(children.name and children.name or children.id)
				if cType and cType:getCharges() > 1 then
					child:setSubType(cType:getCharges())
				end
			end
			if children.chance then
				child:setChance(children.chance)
			end
			if children.minCount then
				child:setMinCount(children.minCount)
			end
			if children.maxCount then
				child:setMaxCount(children.maxCount)
			end
			if children.aid or children.actionId then
				child:setActionId(children.aid or children.actionId)
			end
			if children.text or children.description then
				child:setText(children.text or children.description)
			end
			if loot.name then
				child:setNameItem(loot.name)
			end
			if children.article then
				child:setArticle(children.article)
			end
			if children.attack then
				child:setAttack(children.attack)
			end
			if children.defense then
				child:setDefense(children.defense)
			end
			if children.extraDefense or children.extraDef then
				child:setExtraDefense(children.extraDefense or children.extraDef)
			end
			if children.armor then
				child:setArmor(children.armor)
			end
			if children.shootRange or children.range then
				child:setShootRange(children.shootRange or children.range)
			end
			if children.unique then
				child:setUnique(children.unique)
			end
			parent:addChildLoot(child)
		end
	end
	return parent, lootError
end

registerMonsterType.loot = function(mtype, mask)
	if type(mask.loot) == "table" then
		SortLootByChance(mask.loot)
		local atLeastOneError = false
		for _, item in pairs(mask.loot) do
			local parent, lootError = Loot.fromItem(item)
			mtype:addLoot(parent)
			if lootError then
				atLeastOneError = true
			end
		end
		if atLeastOneError then
			logger.warn("[registerMonsterType.loot] - Monster: {} loot could not correctly be load", mtype:name())
		end
	end
end
local playerElements = { COMBAT_PHYSICALDAMAGE, COMBAT_ENERGYDAMAGE, COMBAT_EARTHDAMAGE, COMBAT_FIREDAMAGE, COMBAT_ICEDAMAGE, COMBAT_HOLYDAMAGE, COMBAT_DEATHDAMAGE }
registerMonsterType.elements = function(mtype, mask)
	local min = configManager.getNumber(configKeys.MIN_ELEMENTAL_RESISTANCE)
	local max = configManager.getNumber(configKeys.MAX_ELEMENTAL_RESISTANCE)
	local canClip = false
	if type(mask.elements) == "table" then
		for _, playerElement in pairs(playerElements) do
			local found = false
			for _, element in pairs(mask.elements) do
				if element.type == playerElement then
					found = true
					canClip = canClip or element.percent ~= 100
					break
				end
			end
			canClip = canClip or not found
		end
		for _, element in pairs(mask.elements) do
			if element.type and element.percent then
				local value = element.percent
				if canClip then
					value = math.min(math.max(element.percent, min), max)
				end
				mtype:addElement(element.type, value)
			end
		end
	end
end
registerMonsterType.reflects = function(mtype, mask)
	local max = configManager.getNumber(configKeys.MAX_DAMAGE_REFLECTION)
	if type(mask.reflects) == "table" then
		for _, reflect in pairs(mask.reflects) do
			if reflect.type and reflect.percent then
				mtype:addReflect(reflect.type, math.min(reflect.percent, max))
			end
		end
	end
end
registerMonsterType.heals = function(mtype, mask)
	if type(mask.heals) == "table" then
		for _, heal in pairs(mask.heals) do
			if heal.type and heal.percent then
				mtype:addHealing(heal.type, heal.percent)
			end
		end
	end
end
registerMonsterType.immunities = function(mtype, mask)
	if type(mask.immunities) == "table" then
		for _, immunity in pairs(mask.immunities) do
			if immunity.type and immunity.combat then
				mtype:combatImmunities(immunity.type)
			end
			if immunity.type and immunity.condition then
				mtype:conditionImmunities(immunity.type)
			end
		end
	end
end
registerMonsterType.attacks = function(mtype, mask)
	if type(mask.attacks) == "table" then
		for _, attack in pairs(mask.attacks) do
			mtype:addAttack(readSpell(attack, mtype))
		end
	end
end

registerMonsterType.defenses = function(mtype, mask)
	if type(mask.defenses) == "table" then
		if mask.defenses.defense then
			mtype:defense(mask.defenses.defense)
		end
		if mask.defenses.armor then
			mtype:armor(mask.defenses.armor)
		end
		if mask.defenses.mitigation then
			mtype:mitigation(mask.defenses.mitigation)
		end
		for _, defense in pairs(mask.defenses) do
			if type(defense) == "table" then
				mtype:addDefense(readSpell(defense, mtype))
			end
		end
	end
end

local function loadcastSound(effect, incomingLua, mtype)
	-- Throw shoottype
	if
		effect == CONST_ANI_SPEAR
		or effect == CONST_ANI_THROWINGSTAR
		or effect == CONST_ANI_THROWINGKNIFE
		or effect == CONST_ANI_SMALLSTONE
		or effect == CONST_ANI_LARGEROCK
		or effect == CONST_ANI_SNOWBALL
		or effect == CONST_ANI_HUNTINGSPEAR
		or effect == CONST_ANI_ENCHANTEDSPEAR
		or effect == CONST_ANI_REDSTAR
		or effect == CONST_ANI_GREENSTAR
		or effect == CONST_ANI_ROYALSPEAR
		or effect == CONST_ANI_WHIRLWINDSWORD
		or effect == CONST_ANI_WHIRLWINDAXE
		or effect == CONST_ANI_WHIRLWINDCLUB
		or effect == CONST_ANI_CAKE
		or effect == CONST_ANI_GLOOTHSPEAR
		or effect == CONST_ANI_LEAFSTAR
		or effect == CONST_ANI_ROYALSTAR
	then
		return SOUND_EFFECT_TYPE_DIST_ATK_THROW

		-- Crossbow shoottype
	elseif effect == CONST_ANI_BOLT or effect == CONST_ANI_POWERBOLT or effect == CONST_ANI_INFERNALBOLT or effect == CONST_ANI_PIERCINGBOLT or effect == CONST_ANI_VORTEXBOLT or effect == CONST_ANI_PRISMATICBOLT or effect == CONST_ANI_DRILLBOLT or effect == CONST_ANI_SPECTRALBOLT then
		return SOUND_EFFECT_TYPE_DIST_ATK_CROSSBOW

		-- Bow shoottype
	elseif
		effect == CONST_ANI_POISONARROW
		or effect == CONST_ANI_BURSTARROW
		or effect == CONST_ANI_SNIPERARROW
		or effect == CONST_ANI_ONYXARROW
		or effect == CONST_ANI_FLASHARROW
		or effect == CONST_ANI_FLAMMINGARROW
		or effect == CONST_ANI_SHIVERARROW
		or effect == CONST_ANI_EARTHARROW
		or effect == CONST_ANI_TARSALARROW
		or effect == CONST_ANI_CRYSTALLINEARROW
		or effect == CONST_ANI_ENVENOMEDARROW
		or effect == CONST_ANI_SIMPLEARROW
		or effect == CONST_ANI_DIAMONDARROW
	then
		return SOUND_EFFECT_TYPE_DIST_ATK_BOW

		-- Magical shoottype
	elseif
		effect == CONST_ANI_FIRE
		or effect == CONST_ANI_ENERGY
		or effect == CONST_ANI_DEATH
		or effect == CONST_ANI_POISON
		or effect == CONST_ANI_ETHEREALSPEAR
		or effect == CONST_ANI_ICE
		or effect == CONST_ANI_EARTH
		or effect == CONST_ANI_HOLY
		or effect == CONST_ANI_SUDDENDEATH
		or effect == CONST_ANI_ENERGYBALL
		or effect == CONST_ANI_SMALLICE
		or effect == CONST_ANI_SMALLHOLY
		or effect == CONST_ANI_SMALLEARTH
		or effect == CONST_ANI_EXPLOSION
	then
		return SOUND_EFFECT_TYPE_MAGICAL_RANGE_ATK
	end

	return SOUND_EFFECT_TYPE_SILENCE
end

local function loadImpactSound(incomingLua, mtype)
	local nameType = "physical"
	if incomingLua.name == "melee" then
		local meleeSoundTable = {}
		if mtype:targetDistance() <= 1 then
			meleeSoundTable = {
				[1] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_FIST,
				[2] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_CLAW,
				[3] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_BITE,
			}
		else
			meleeSoundTable = {
				[1] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_RIP,
				--[2] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_ACID,
				[2] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_MAGIC,
				--[4] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_ETHEREAL,
				--[5] = SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_CONSTRUCT,
			}
		end
		return meleeSoundTable[math.random(1, #meleeSoundTable)]
	elseif incomingLua.name == "combat" then
		if incomingLua.type == COMBAT_PHYSICALDAMAGE then
			nameType = "physical"
		elseif incomingLua.type == COMBAT_ENERGYDAMAGE then
			nameType = "energy"
		elseif incomingLua.type == COMBAT_EARTHDAMAGE then
			nameType = "earth"
		elseif incomingLua.type == COMBAT_FIREDAMAGE then
			nameType = "fire"
		elseif incomingLua.type == COMBAT_UNDEFINEDDAMAGE then
			nameType = "bleeding"
		elseif incomingLua.type == COMBAT_LIFEDRAIN then
			nameType = "lifedrain"
		elseif incomingLua.type == COMBAT_MANADRAIN then
			nameType = "manadrain"
		elseif incomingLua.type == COMBAT_HEALING then
			nameType = "healing"
		elseif incomingLua.type == COMBAT_DROWNDAMAGE then
			nameType = "drown"
		elseif incomingLua.type == COMBAT_ICEDAMAGE then
			nameType = "ice"
		elseif incomingLua.type == COMBAT_HOLYDAMAGE then
			nameType = "holy"
		elseif incomingLua.type == COMBAT_DEATHDAMAGE then
			nameType = "death"
		end
	elseif incomingLua.name == "drunk" then
		if incomingLua.duration and incomingLua.duration > superDrunkDuration then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SUPER_DRUNKEN
		end
		return SOUND_EFFECT_TYPE_MONSTER_SPELL_DRUNKEN
	elseif incomingLua.name == "speed" then
		return SOUND_EFFECT_TYPE_MONSTER_SPELL_SPEED
	elseif incomingLua.name == "outfit" then
		return SOUND_EFFECT_TYPE_MONSTER_SPELL_OUTFIT
	elseif incomingLua.name == "strength" then
		return SOUND_EFFECT_TYPE_MONSTER_SPELL_STRENGTH
	elseif incomingLua.name == "firefield" then
		return SOUND_EFFECT_TYPE_SPELL_FIRE_FIELD_RUNE
	elseif incomingLua.name == "energyfield" then
		return SOUND_EFFECT_TYPE_SPELL_ENERGY_FIELD_RUNE
	elseif incomingLua.name == "earthfield" or incomingLua.name == "poisonfield" then
		return SOUND_EFFECT_TYPE_SPELL_POISON_FIELD_RUNE
	elseif incomingLua.name == "condition" then
		-- To-Do
	end

	-- Waves
	if incomingLua.length and incomingLua.spread then
		if nameType == "bleeding" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_BLEEDING
		elseif nameType == "energy" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_ENERGY
		elseif nameType == "earth" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_EARTH
		elseif nameType == "fire" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_FIRE
		elseif nameType == "lifedrain" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_LIFEDRAIN
		elseif nameType == "manadrain" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_MANADRAIN
		elseif nameType == "healing" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_HEALING
		elseif nameType == "drown" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_DROWNING
		elseif nameType == "ice" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_ICE
		elseif nameType == "holy" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_HOLY
		elseif nameType == "death" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_DEATH
		elseif nameType == "physical" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_WAVE_HIT
		end

		-- Bombs area (not field)
	elseif incomingLua.radius then
		if nameType == "bleeding" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_BLEEDING
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_BLEEDING
			end
		elseif nameType == "energy" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_ENERGY
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_ENERGY
			end
		elseif nameType == "earth" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_EARTH
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_EARTH
			end
		elseif nameType == "fire" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_FIRE
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_FIRE
			end
		elseif nameType == "lifedrain" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_LIFEDRAIN
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_LIFEDRAIN
			end
		elseif nameType == "manadrain" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_MANADRAIN
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_MANADRAIN
			end
		elseif nameType == "healing" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_HEALING
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_HEALING
			end
		elseif nameType == "drown" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_DROWNING
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_DROWNING
			end
		elseif nameType == "ice" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_ICE
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_ICE
			end
		elseif nameType == "holy" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_HOLY
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_HOLY
			end
		elseif nameType == "death" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_DEATH
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_DEATH
			end
		elseif nameType == "physical" then
			if incomingLua.radius <= smallAreaRadius then
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_SMALL_AREA_HIT
			else
				return SOUND_EFFECT_TYPE_MONSTER_SPELL_LARGE_AREA_HIT
			end
		end

		-- Since all failed, im assuming its a single target spell
	else
		if nameType == "bleeding" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_BLEEDING
		elseif nameType == "energy" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_ENERGY
		elseif nameType == "earth" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_EARTH
		elseif nameType == "fire" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_FIRE
		elseif nameType == "lifedrain" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_LIFEDRAIN
		elseif nameType == "manadrain" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_MANADRAIN
		elseif nameType == "healing" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_HEALING
		elseif nameType == "drown" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_DROWNING
		elseif nameType == "ice" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_ICE
		elseif nameType == "holy" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_HOLY
		elseif nameType == "death" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_DEATH
		elseif nameType == "physical" then
			return SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_HIT
		end
	end

	return SOUND_EFFECT_TYPE_SILENCE
end

local function loadSpellSoundType(incomingLua, mtype)
	local castSound, impactSound = SOUND_EFFECT_TYPE_SILENCE, SOUND_EFFECT_TYPE_MONSTER_CLOSE_ATK_FIST

	-- Shoot effect
	if incomingLua.shootEffect ~= nil then
		castSound = loadcastSound(incomingLua.shootEffect, incomingLua, mtype)
	end

	impactSound = loadImpactSound(incomingLua, mtype)
	return { cast = castSound, impact = impactSound }
end

function readSpell(incomingLua, mtype)
	local hasCastSound, hasImpactSound = false, false
	local spell = MonsterSpell()
	if incomingLua.name then
		if incomingLua.name == "melee" then
			spell:setType("melee")
			if incomingLua.attack and incomingLua.skill then
				spell:setAttackValue(incomingLua.attack, incomingLua.skill)
			end
			if incomingLua.minDamage and incomingLua.maxDamage then
				spell:setCombatValue(incomingLua.minDamage, incomingLua.maxDamage)
			end
			if incomingLua.interval then
				spell:setInterval(incomingLua.interval)
			end
			if incomingLua.effect then
				spell:setCombatEffect(incomingLua.effect)
			end
			if incomingLua.soundCast then
				spell:castSound(incomingLua.soundCast)
				hasCastSound = true
			end
			if incomingLua.impactCast then
				spell:impactSound(incomingLua.impactCast)
				hasImpactSound = true
			end
		else
			spell:setType(incomingLua.name)
			if incomingLua.type then
				if incomingLua.name == "combat" then
					spell:setCombatType(incomingLua.type)
				elseif incomingLua.name == "condition" then
					spell:setConditionType(incomingLua.type)
				else
					logger.warn("[readSpell] - Monster {}: Loading spell {}. Parameter type applies only for condition and combat.", mtype:name(), incomingLua.name)
				end
			end
			if incomingLua.interval then
				spell:setInterval(incomingLua.interval)
			end
			if incomingLua.chance then
				spell:setChance(incomingLua.chance)
			end
			if incomingLua.range then
				spell:setRange(incomingLua.range)
			end
			if incomingLua.duration then
				spell:setConditionDuration(incomingLua.duration)
			end
			if incomingLua.speedChange then
				spell:setConditionSpeedChange(incomingLua.speedChange)
			end
			if incomingLua.target then
				spell:setNeedTarget(incomingLua.target)
			end
			if incomingLua.length then
				spell:setCombatLength(incomingLua.length)
			end
			if incomingLua.spread then
				spell:setCombatSpread(incomingLua.spread)
			end
			if incomingLua.radius then
				spell:setCombatRadius(incomingLua.radius)
			end
			if incomingLua.outfitMonster then
				spell:setOutfitMonster(incomingLua.outfitMonster)
			end
			if incomingLua.outfitItem then
				spell:setOutfitItem(incomingLua.outfitItem)
			end
			if incomingLua.soundCast then
				spell:castSound(incomingLua.soundCast)
				hasCastSound = true
			end
			if incomingLua.impactCast then
				spell:impactSound(incomingLua.impactCast)
				hasImpactSound = true
			end
			if incomingLua.minDamage and incomingLua.maxDamage then
				if incomingLua.name == "combat" or Spell(incomingLua.name) then
					spell:setCombatValue(incomingLua.minDamage, incomingLua.maxDamage)
				else
					local startDamage = 0
					if incomingLua.startDamage then
						startDamage = incomingLua.startDamage
					end
					spell:setConditionDamage(incomingLua.minDamage, incomingLua.maxDamage, startDamage)
				end
			end
			if incomingLua.effect then
				spell:setCombatEffect(incomingLua.effect)
			end
			if incomingLua.shootEffect or incomingLua.shooteffect then
				spell:setCombatShootEffect(incomingLua.shootEffect or incomingLua.shooteffect)
			end
		end

		-- This is for a complex spell, that has combat damage AND some condition
		-- For example scorpions, which attack and cause poison on attack
		if incomingLua.condition then
			if incomingLua.condition.type then
				spell:setConditionType(incomingLua.condition.type)
			end
			if incomingLua.condition.duration then
				spell:setConditionDuration(incomingLua.condition.duration)
			end
			if incomingLua.condition.interval then
				spell:setConditionTickInterval(incomingLua.condition.interval)
			end

			spell:setConditionDamage(incomingLua.condition.totalDamage, incomingLua.condition.totalDamage, 0)
		end
		local isArea = (incomingLua.radius and incomingLua.radius > 1) or incomingLua.length or incomingLua.spread
		if isArea and incomingLua.effect == nil and not string.find(incomingLua.name, "field") then
			logger.warn("[readSpell] - Monster {}: Spell {} is area but has no effect. Set to `false` explicitly to supress this alert and hide the effect", mtype:name(), incomingLua.name)
			spell:setCombatEffect(CONST_ME_POFF)
		end
	elseif incomingLua.script then
		spell:setScriptName("monster/" .. incomingLua.script .. ".lua")
		if incomingLua.interval then
			spell:setInterval(incomingLua.interval)
		end
		if incomingLua.chance then
			spell:setChance(incomingLua.chance)
		end
		if incomingLua.minDamage and incomingLua.maxDamage then
			spell:setCombatValue(incomingLua.minDamage, incomingLua.maxDamage)
		end
		if incomingLua.target then
			spell:setNeedTarget(incomingLua.target)
		end
		if incomingLua.soundCast then
			spell:castSound(incomingLua.soundCast)
			hasCastSound = true
		end
		if incomingLua.impactCast then
			spell:impactSound(incomingLua.impactCast)
			hasImpactSound = true
		end
	end

	if not hasImpactSound or not hasCastSound then
		local sounds = loadSpellSoundType(incomingLua, mtype)
		if not hasCastSound and sounds.cast ~= SOUND_EFFECT_TYPE_SILENCE then
			spell:castSound(sounds.cast)
		end
		if not hasImpactSound and sounds.impact ~= SOUND_EFFECT_TYPE_SILENCE then
			spell:castSound(sounds.impact)
		end
	end
	return spell
end
