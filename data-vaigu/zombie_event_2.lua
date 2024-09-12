local config = {
	bossName = "zombie",
	encounterName = "zombie",
	requiredLevel = 250,

	entranceTiles = {
		{ pos = { x = 33812, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33811, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33810, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33809, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
		{ pos = { x = 33808, y = 32584, z = 12 }, destination = { x = 33831, y = 32591, z = 12 }, effect = CONST_ME_TELEPORT },
	},
	requiredPlayers = 5,
	zoneArea = {
		Position(5930, 1618, 7),
		Position(5941, 1630, 7),
	},
	exitTpPosition = { x = 33829, y = 32591, z = 12 },
	exitTpDestination = { x = 33810, y = 32587, z = 12 },
}
local encounterData = EncounterData(config)
encounterData:position({ x = 33813, y = 32584, z = 12 })
encounterData:register()
do
	return
end

local encounter = Encounter("zombie", {
	timeToSpawnMonsters = "1000ms",
	jackedChance = 0,
	playerSpeed = 400,
	onDeathEvent = "ZombiePlayerDeath",
	isMinigame = true,
	zoneArea = {
		Position(5930, 1618, 7),
		Position(5941, 1630, 7),
	},
})



function encounter:onReset()
	encounter:removeMonsters()
	encounter.jackedChance = 0
end

encounter:addRemoveMonsters():autoAdvance()

EncounterDefinitionRegistry():Register(encounter)

local zombieSpawns = GlobalEvent("encounter.zombie.spawn-zombies")
function zombieSpawns.onThink()
	local pos = encounter.zone:randomPosition()
	local roll = math.random(1, 100)
	if roll < encounter.jackedChance then
		Game.createMonster("Zombie Event Jacked", pos)
	else
		Game.createMonster("Zombie Event", pos)
	end
	encounter.jackedChance = encounter.jackedChance + 1
	return true
end
zombieSpawns:interval(10000)
zombieSpawns:register()

kv:scoped("encounter"):scoped(encounter.name):scoped("current-players"):set(0)
kv:scoped("encounter"):scoped(encounter.name):scoped("starting-players"):set(0)
kv:scoped("encounter"):scoped(encounter.name):scoped("monster-count"):set(0)
kv:scoped("encounter"):scoped(encounter.name):scoped("start-time"):set(os.time())
