local wallId = 16170
local wallToBeRemovedPos = Position(33098, 31978, 11)

local spawnLock = SpawnLocks.BigfootsBurden.Warzone2
local gnomevilSpawnPosition = Position(33114, 31959, 11)

local creatureevent = CreatureEvent("ParasiteDeath")
function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster then
		return true
	end

	local targetPosition = targetMonster:getPosition()
	local distance = targetPosition:EuclideanDistance(wallToBeRemovedPos)
	if distance > 1.5 then
		return true
	end

	local wall = wallToBeRemovedPos:GetItemById(wallId)
	if wall then
		wall:remove()

		if not spawnLock:IsSet() then
			spawnLock:Set(Game.createMonster("Gnomevil", gnomevilSpawnPosition))
		end

		spawnLock.onReset = function()
			local oldWall = wallToBeRemovedPos:GetItemById(wallId)
			if not oldWall then
				Game.createItem(16170, 1, wallToBeRemovedPos)
			end
		end
	end

	return true
end
creatureevent:register()
