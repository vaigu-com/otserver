local roomCorner1 = Position(6454, 2485, 12)
local roomCorner2 = Position(6469, 2498, 12)
local roomArea = Area(roomCorner1, roomCorner2)

local vesperothSpawnPosition = Position(6461, 2492, 12)
local vesperothHidePosition = Position(6461, 2492, 13)

local minMinionsPerWave = 8
local maxMinionsPerWave = 10
local vesperothMonster = nil

local function clearMinionWaveDelayed(minions)
	addEvent(function()
		for _, monster in pairs(minions:Get()) do
			if not monster:isDead() then
				monster:remove()
			end
		end
	end, 1000 * 60)
end

function VesperothAppearLoop()
	if (not vesperothMonster) or vesperothMonster:isDead() then
		return
	end

	vesperothMonster:teleportTo(vesperothSpawnPosition)

	addEvent(VesperothHideLoop, 20 * 1000)
end

function VesperothHideLoop()
	if (not vesperothMonster) or vesperothMonster:isDead() then
		return
	end
	
	vesperothMonster:teleportTo(vesperothHidePosition)

	local minionsPerWave = math.random(minMinionsPerWave, maxMinionsPerWave)
	local monsters = CreatureList()
	for _ = 1, minionsPerWave do
		local spawnPosition = roomArea:RandomPosition()
		monsters:Add(Game.createMonster("Minion of Versperoth", spawnPosition))
		spawnPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end

	clearMinionWaveDelayed(monsters)
	addEvent(VesperothAppearLoop, 10 * 1000)
end

local spawnLock = SpawnLocks.BigfootsBurden.Warzone3
local bossSpawnPosition = Position(6476, 2524, 12)

local movement = MoveEvent()
function movement.onStepIn(creature, veperothHole, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not (player and veperothHole) then
		return true
	end

	-- should be impossible
	if spawnLock:IsSet() then
		return
	else
		spawnLock:Set(Game.createMonster("abyssador", bossSpawnPosition))
		player:teleportTo(fromPosition)
		vesperothMonster = Game.createMonster("versperoth", vesperothSpawnPosition)
		veperothHole:remove()
		VesperothAppearLoop()
	end
	return true
end
movement:type("stepin")
movement:id(16173)
movement:register()
