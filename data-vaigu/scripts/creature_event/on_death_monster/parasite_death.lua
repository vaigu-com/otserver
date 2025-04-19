local wallId = 16170
local wallPos = Position(6484, 2592, 11)

local spawnLock = SpawnLocks.BigfootsBurden.Warzone2
local bossSpawnPosition = Position(6505, 2570, 11)

local creatureevent = CreatureEvent("ParasiteDeath")
function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster then
		return true
	end

	local targetPosition = targetMonster:getPosition()
	local distance = targetPosition:EuclideanDistance(wallPos)
	if distance > 1.5 then
		return true
	end

	local wall = wallPos:GetItemById(wallId)
	if wall then
		wall:remove()

		if not spawnLock:IsSet() then
			spawnLock:Set(Game.createMonster("Gnomevil", bossSpawnPosition))
		end

		spawnLock.onReset = function()
			local oldWall = wallPos:GetItemById(wallId)
			if not oldWall then
				Game.createItem(16170, 1, wallPos)
			end
		end
	end

	return true
end
creatureevent:register()
