local creatureevent = CreatureEvent("BigfootBurdenWigglerDeath")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local value = player:getStorageValue(Storage.BigfootBurden.ExterminatedCount)
		if value < 10 and player:getStorageValue(Storage.BigfootBurden.MissionExterminators) == 1 then
			player:setStorageValue(Storage.BigfootBurden.ExterminatedCount, value + 1)
		end
	end)
	return true
end

creatureevent:register()
