local minigameZone = Zone("minigames.zombie")
minigameZone:add

local encounter = Encounter("zombie", {
	zone = minigameZone,
	timeToSpawnMonsters = "1000ms",
	jackedChance = 0,
	playerSpeed = 400,
	onDeathEvent = "ZombiePlayerDeath",
	isMinigame = true,
})

function encounter:onReset()
	encounter:removeMonsters()
	encounter.jackedChance = 0
end

encounter:addRemoveMonsters():autoAdvance()
encounter
	:addStage({
		start = function()
			for _, player in pairs(encounter.zone:getPlayers()) do
				player:setStorageValue(Storage.hasteLock, encounter.playerSpeed)
				player:registerEvent(encounter.onDeathEvent)
				player:changeSpeed()
			end
		end,
	})
	:autoAdvance()

EncounterDefinitionRegistry():register(encounter)

local zombieSpawns = GlobalEvent("minigames.zombie.spawn-zombies")
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

kv():scoped("minigames"):scoped(encounter.name):scoped("current-players"):set(0)
kv():scoped("minigames"):scoped(encounter.name):scoped("starting-players"):set(0)
kv():scoped("minigames"):scoped(encounter.name):scoped("monster-count"):set(0)
kv():scoped("minigames"):scoped(encounter.name):scoped("start-time"):set(os.time())
