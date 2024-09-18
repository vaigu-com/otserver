local wawelDragon = CreatureEvent("WawelDragonDeath")

function wawelDragon.onDeath(creature)
	local deathPos = creature:getPosition()
	local corpse = Game.createItem(31649, 1, deathPos)
	corpse:setActionId(Storage.FourActTragedy.Rewards.TimmyBag)
	return true
end

wawelDragon:register()
