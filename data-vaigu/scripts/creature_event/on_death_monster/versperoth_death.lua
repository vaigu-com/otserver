local teleportPosition = Position(6461, 2492, 12)
local spawnLock = SpawnLocks.BigfootsBurden.Warzone3

local creatureevent = CreatureEvent("VersperothDeath")
function creatureevent.onDeath(creature)
	local tp = Game.createItem(1949, 1, teleportPosition)
	tp:setActionId(45703)
	spawnLock.onReset = function()
		tp:remove()
		Game.createItem(16173, 1, teleportPosition)
	end
	return true
end
creatureevent:register()
