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

encounter:addRemoveMonsters()
encounter:startOnEnter()
encounter:register()

-- EncounterDefinitionRegistry():Register(encounter)

local zombieSpawns = GlobalEvent("encounter.zombie.spawn-zombies")
function zombieSpawns.onThink()
    if not encounter:isActive() then
        return true
    end
	local pos = encounter:getZone():randomPosition()
	local roll = math.random(1, 100)
	if roll < encounter.jackedChance then
		Game.createMonster("Zombie", pos)
	else
		Game.createMonster("Dog", pos)
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
