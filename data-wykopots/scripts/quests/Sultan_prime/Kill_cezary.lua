local cezary = CreatureEvent("CezaryBarykaDeath")

function cezary.onDeath(creature)
	local deathPos = creature:getPosition()
	local corpse = Game.createItem(4240, 1, deathPos)
	corpse:setActionId(Storage.SultanPrime.RewardsScripted.Necklace)

	addEvent(function()
		Game.createMonster("Cezary Baryka", deathPos)
	end, 1000 * 2 * 60)
	return true
end

cezary:register()
