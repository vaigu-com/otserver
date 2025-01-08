local creatureevent = CreatureEvent("WigglerDeath")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local value = player:getStorageValueByKey(Storage.BigfootBurden.ExterminatedCount)
		if value < 10 and player:getStorageValueByKey(Storage.BigfootBurden.MissionExterminators) == 1 then
			player:setStorageValueByKey(Storage.BigfootBurden.ExterminatedCount, value + 1)
		end
	end)
	return true
end

creatureevent:register()
