local chargingOutDeath = CreatureEvent("ChargingOutDeath")
function chargingOutDeath.onDeath(creature)
	if chargingOutKilled == false then
		local monster = Game.createMonster("outburst", { x = 5467, y = 1413, z = 14 }, false, true)
		monster:addHealth(-monster:getHealth() + outburstHealth, false)
	end
	return true
end
chargingOutDeath:register()
