---@class SurpriseMinibossData
---@field regularMonsters string[] kill those to spawn minibosses
---@field minibosses string[] one of those bosses will be spawned upon killing regular monsters
---@field chance number between epsilon and 1
---@field private spawnLock SpawnLock
SurpriseMiniboss = {}
SurpriseMiniboss.__index = SurpriseMiniboss
function SurpriseMiniboss.New(context)
	local newObj = {
		regularMonsters = context.regularMonsters,
		minibosses = context.minibosses,
		chance = context.chance,
		spawnLock = SpawnLock(),
	}
	setmetatable(newObj, SurpriseMiniboss)
	return newObj
end
setmetatable(SurpriseMiniboss, {
	__call = function(_, ...)
		return SurpriseMiniboss.New(...)
	end,
})
function SurpriseMiniboss:GetRegularMonsters()
	return self.regularMonsters
end

local effect = CONST_ME_TELEPORT
local effectCount = 3
local delayBetweenEffectsSeconds = 1

---@param spawnPosition Position
function SurpriseMiniboss:TrySpawnBoss(spawnPosition)
	local requiredRoll = self.chance
	local roll = math.random()
	if roll > requiredRoll then
		return
	end

	if self.spawnLock:IsSet() then
		return
	end

	Game.createDelayedEffects(spawnPosition, effect, effectCount, delayBetweenEffectsSeconds)
	addEvent(function()
		local monster = Game.createMonster(table.random(self.minibosses), spawnPosition, true, true)
		if not monster then
			return
		end
		self.spawnLock:Set(monster)
	end, (effectCount + 1) * delayBetweenEffectsSeconds * 1000)
end

---@class SurpriseMinibossDataRegistry
SurpriseMinibossRegistry = {}
SurpriseMinibossRegistry.__index = SurpriseMinibossRegistry
SurpriseMinibossRegistry.registry = {}

---@param surpriseMinibossData SurpriseMinibossData
---@return SurpriseMinibossDataRegistry
function SurpriseMinibossRegistry:Add(surpriseMinibossData)
	for _, regularMonsterName in pairs(surpriseMinibossData:GetRegularMonsters()) do
		self.registry[regularMonsterName] = surpriseMinibossData
	end
	return self
end
---@param monsterName string
---@return SurpriseMinibossData
function SurpriseMinibossRegistry:Get(monsterName)
	return self.registry[monsterName]
end

local surpriseMinibossesDatas = {
	SurpriseMiniboss({ regularMonsters = { "Lizard Chosen" }, minibosses = { "The Voice of Ruin" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Killer Caiman" }, minibosses = { "Dreadmaw" }, chance = 0.005 }),
	SurpriseMiniboss({ regularMonsters = { "Warlock" }, minibosses = { "Zarabustor" }, chance = 0.008 }),
	SurpriseMiniboss({ regularMonsters = { "Ice Witch" }, minibosses = { "Yakchal" }, chance = 0.006 }),
	SurpriseMiniboss({ regularMonsters = { "Lizard Dragon Priest" }, minibosses = { "Flamecaller Zazrak" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Lich" }, minibosses = { "Gravelord Oshuran" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Lizard High Guard" }, minibosses = { "Lizard Gate Guardian" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Dragon" }, minibosses = { "Grand Mother Foulscale" }, chance = 0.008 }),
	SurpriseMiniboss({ regularMonsters = { "Faun", "Dark Faun" }, minibosses = { "Raxias" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Cyclops Smith" }, minibosses = { "The Old Whopper" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Dworc Venomsniper", "Dworc Fleshhunter", "Dworc Voodoomaster" }, minibosses = { "Oodok Witchmaster" }, chance = 0.03 }),
	SurpriseMiniboss({ regularMonsters = { "Haunted Treeling" }, minibosses = { "Bane Lord" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Orc Marauder" }, minibosses = { "Cublarc the Plunderer" }, chance = 0.03 }),
	SurpriseMiniboss({ regularMonsters = { "Carrion Worm" }, minibosses = { "White Pale" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Witch" }, minibosses = { "Yaga the Crone" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Lion" }, minibosses = { "Zomba" }, chance = 0.05 }),
	SurpriseMiniboss({ regularMonsters = { "Wasp" }, minibosses = { "Willi Wasp" }, chance = 0.03 }),
	SurpriseMiniboss({ regularMonsters = { "Wereboar" }, minibosses = { "Owin" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Serpent Spawn" }, minibosses = { "Srezz Yellow Eyes" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Werewolf" }, minibosses = { "Darkfang" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Werebadger" }, minibosses = { "Sharpclaw" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Werehyaena", "Werehyaena Shaman" }, minibosses = { "Katex Blood Tongue" }, chance = 0.006 }),
	SurpriseMiniboss({ regularMonsters = { "Orc Warlord" }, minibosses = { "Bibby Bloodbath" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Hellflayer" }, minibosses = { "Bragrumol" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Medusa" }, minibosses = { "Gorgo" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Kollos" }, minibosses = { "Maw" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Spidris" }, minibosses = { "Fleshslicer" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Spitter" }, minibosses = { "Rotspit" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Waspoid" }, minibosses = { "Chopper" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Insectoid Worker" }, minibosses = { "Mindmasher" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Giant Spider" }, minibosses = { "Mamma Longlegs" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Bog Raider" }, minibosses = { "Weakened Shlorg" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Enlightened of the Cult" }, minibosses = { "Grandfather Tridian" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Brimstone Bug" }, minibosses = { "Sulphur Scuttler" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Crystal Spider" }, minibosses = { "The Bloodweb" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Destroyer" }, minibosses = { "Bretzecutioner" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Burning Gladiator" }, minibosses = { "Amenef the Burning" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Priestess of the Wild Sun", "Black Sphinx Acolyte" }, minibosses = { "Sister Hetai" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Undead Dragon" }, minibosses = { "Bones" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Hunter", "Poacher" }, minibosses = { "Arthom the Hunter" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Pirate Corsair" }, minibosses = { "Brutus Bloodbeard" }, chance = 0.004 }),
	SurpriseMiniboss({ regularMonsters = { "Pirate Buccaneer" }, minibosses = { "Ron The Ripper", "Deadeye Devious", "Lethal Lissy" }, chance = 0.003 }),
	SurpriseMiniboss({ regularMonsters = { "Mutated Bat" }, minibosses = { "Bruise Payne" }, chance = 0.006 }),
	SurpriseMiniboss({ regularMonsters = { "Glooth Anemone" }, minibosses = { "Lisa" }, chance = 0.006 }),
	SurpriseMiniboss({ regularMonsters = { "Moohtant" }, minibosses = { "Bullwark" }, chance = 0.006 }),
	SurpriseMiniboss({ regularMonsters = { "Guzzlemaw" }, minibosses = { "Mawhawk" }, chance = 0.003 }),
	SurpriseMiniboss({ regularMonsters = { "Hellhound" }, minibosses = { "Mozradek" }, chance = 0.007 }),
	SurpriseMiniboss({ regularMonsters = { "Adult Goanna" }, minibosses = { "Yirkas Blue Scales" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Glooth Golem" }, minibosses = { "Glooth Fairy" }, chance = 0.006 }),
	SurpriseMiniboss({ regularMonsters = { "Dragon Lord" }, minibosses = { "Kalyassa" }, chance = 0.002 }),
	SurpriseMiniboss({ regularMonsters = { "Ice Dragon" }, minibosses = { "Gelidrazah the Frozen" }, chance = 0.01 }),
	SurpriseMiniboss({ regularMonsters = { "Hydra" }, minibosses = { "Tazhadur" }, chance = 0.003 }),
	SurpriseMiniboss({ regularMonsters = { "Ghastly Dragon" }, minibosses = { "Zorvorax" }, chance = 0.005 }),
	SurpriseMiniboss({ regularMonsters = { "Silencer", "Plaguesmith", "Grimeleech", "Boar Man", "Crape Man", "Vexclaw", "Draken Abomination", "Arachnophobica" }, minibosses = { "Ugly Monster" }, chance = 0.002 }),
	SurpriseMiniboss({ regularMonsters = { "Cobra Assassin", "Cobra Scout", "Cobra Vizier" }, minibosses = { "Guard Captain Quaid", "Gaffir", "Custodian" }, chance = 0.006 }),
	

}
for _, surpriseMinibossesData in pairs(surpriseMinibossesDatas) do
	SurpriseMinibossRegistry:Add(surpriseMinibossesData)
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

	local surpriseMinibossData = SurpriseMinibossRegistry:Get(deadMonsterName)
	surpriseMinibossData:TrySpawnBoss(deadMonsterPos)
end
surpriseMiniboss:register()

local taskMonsterDeathStartup = GlobalEvent("SurpriseMinibossStartup")
function taskMonsterDeathStartup.onStartup()
	for monsterName in pairs(SurpriseMinibossRegistry.registry) do
		local mType = MonsterType(monsterName)
		if not mType then
			logger.error("[SurpriseMinibossStartup] monster with name {} is not a valid MonsterType", monsterName)
		else
			mType:registerEvent("MinibossFromRegularMonster")
		end
	end
end
taskMonsterDeathStartup:register()
