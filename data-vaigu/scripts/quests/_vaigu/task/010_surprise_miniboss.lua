---@class SurpriseMinibossData
---@field regularMonsters string[]
---@field minibosses string[]
---@field spawnLock SpawnLock
---@field chance number between epsilon and 1
SurpriseMinibossData = {}
SurpriseMinibossData.__index = SurpriseMinibossData
function SurpriseMinibossData.New(context)
	local newObj = {
		regularMonsters = context.regularMonsters,
		minibosses = context.minibosses,
		chance = context.chance,
		spawnLock = SpawnLock(),
	}
	setmetatable(newObj, SurpriseMinibossData)
	return newObj
end
setmetatable(SurpriseMinibossData, {
	__call = function(_, ...)
		return SurpriseMinibossData.New(...)
	end,
})
function SurpriseMinibossData:GetRegularMonsters()
	return self.regularMonsters
end
---@param spawnPosition Position
function SurpriseMinibossData:TrySpawnBoss(spawnPosition)
	local requiredRoll = self.chance * 100
	local roll = math.random(1, 100)
	if roll > requiredRoll then
		return
	end

	if self.spawnLock:IsSet() then
		return
	end

	addEvent(function()
		local monster = Game.createMonster(table.random(self.minibosses), spawnPosition)
		if monster then
			self.spawnLock:Set(monster)
		end
	end, 5000)
end

---@class SurpriseMinibossDataRegistry
SurpriseMinibossDataRegistry = {}
SurpriseMinibossDataRegistry.__index = SurpriseMinibossDataRegistry
SurpriseMinibossDataRegistry.registry = {}

---@param surpriseMinibossData SurpriseMinibossData
---@return SurpriseMinibossDataRegistry
function SurpriseMinibossDataRegistry:Add(surpriseMinibossData)
	for _, regularMonsterName in pairs(surpriseMinibossData:GetRegularMonsters()) do
		self.registry[regularMonsterName] = surpriseMinibossData
	end
	return self
end
---@param monsterName string
---@return SurpriseMinibossData
function SurpriseMinibossDataRegistry:Get(monsterName)
	return self.registry[monsterName]
end

local surpriseMinibossesDatas = {
	SurpriseMinibossData({ regularMonsters = { "Lizard Chosen" }, minibosses = { "The Voice of Ruin" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Killer Caiman" }, minibosses = { "Dreadmaw" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Warlock" }, minibosses = { "Zarabustor" }, chance = 0.008 }),
	SurpriseMinibossData({ regularMonsters = { "Ice Witch" }, minibosses = { "Yakchal" }, chance = 0.008 }),
	SurpriseMinibossData({ regularMonsters = { "Lizard Dragon Priest" }, minibosses = { "Flamecaller Zazrak" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Lich" }, minibosses = { "Gravelord Oshuran" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Lizard High Guard" }, minibosses = { "Lizard Gate Guardian" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Dragon" }, minibosses = { "Grand Mother Foulscale" }, chance = 0.009 }),
	SurpriseMinibossData({ regularMonsters = { "Faun", "Dark Faun" }, minibosses = { "Raxias" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Cyclops Smith" }, minibosses = { "The Old Whopper" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Dworc Venomsniper", "Dworc Fleshhunter", "Dworc Voodoomaster" }, minibosses = { "Oodok Witchmaster" }, chance = 0.04 }),
	SurpriseMinibossData({ regularMonsters = { "Haunted Treeling" }, minibosses = { "Bane Lord" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Orc Marauder" }, minibosses = { "Cublarc the Plunderer" }, chance = 0.03 }),
	SurpriseMinibossData({ regularMonsters = { "Carrion Worm" }, minibosses = { "White Pale" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Witch" }, minibosses = { "Yaga the Crone" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Lion" }, minibosses = { "Zomba" }, chance = 0.05 }),
	SurpriseMinibossData({ regularMonsters = { "Wasp" }, minibosses = { "Willi Wasp" }, chance = 0.03 }),
	SurpriseMinibossData({ regularMonsters = { "Wereboar" }, minibosses = { "Owin" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Serpent Spawn" }, minibosses = { "Srezz Yellow Eyes" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Werewolf" }, minibosses = { "Darkfang" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Werebadger" }, minibosses = { "Sharpclaw" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Orc Warlord" }, minibosses = { "Bibby Bloodbath" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Hellflayer" }, minibosses = { "Bragrumol" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Medusa" }, minibosses = { "Gorgo" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Kollos" }, minibosses = { "Maw" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Spidris" }, minibosses = { "Fleshslicer" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Spitter" }, minibosses = { "Rotspit" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Waspoid" }, minibosses = { "Chopper" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Insectoid Worker" }, minibosses = { "Mindmasher" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Giant Spider" }, minibosses = { "Mamma Longlegs" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Bog Raider" }, minibosses = { "Weakened Shlorg" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Brimstone Bug" }, minibosses = { "Sulphur Scuttler" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Crystal Spider" }, minibosses = { "The Bloodweb" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Destroyer" }, minibosses = { "Bretzecutioner" }, chance = 0.02 }),
	SurpriseMinibossData({ regularMonsters = { "Undead Dragon" }, minibosses = { "Bones" }, chance = 0.01 }),
	SurpriseMinibossData({ regularMonsters = { "Hunter", "Poacher" }, minibosses = { "Arthom the Hunter" }, chance = 0.02 }),
	SurpriseMinibossData({ regularMonsters = { "Pirate Corsair" }, minibosses = { "Brutus Bloodbeard" }, chance = 0.006 }),
	SurpriseMinibossData({ regularMonsters = { "Mutated Bat" }, minibosses = { "Bruise Payne" }, chance = 0.008 }),

}
for _, surpriseMinibossesData in pairs(surpriseMinibossesDatas) do
	SurpriseMinibossDataRegistry:Add(surpriseMinibossesData)
end

local surpriseMiniboss = CreatureEvent("MinibossFromRegularMonster")
function surpriseMiniboss.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
	local targetMonster = killedCreature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local deadMonsterName = targetMonster:getName()
	local deadMonsterPos = targetMonster:getPosition()
	if not (deadMonsterName and deadMonsterPos) then
		return
	end

	local surpriseMinibossData = SurpriseMinibossDataRegistry:Get(deadMonsterName)
	surpriseMinibossData:TrySpawnBoss(deadMonsterPos)
end
surpriseMiniboss:register()

local taskMonsterDeathStartup = GlobalEvent("SurpriseMinibossStartup")
function taskMonsterDeathStartup.onStartup()
	for monsterName in pairs(SurpriseMinibossDataRegistry.registry) do
		local mType = MonsterType(monsterName)
		if not mType then
			logger.error("[SurpriseMinibossStartup] monster with name {} is not a valid MonsterType", monsterName)
		else
			mType:registerEvent("MinibossFromRegularMonster")
		end
	end
end
taskMonsterDeathStartup:register()
