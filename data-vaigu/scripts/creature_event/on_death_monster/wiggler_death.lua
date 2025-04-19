local creatureevent = CreatureEvent("WigglerDeath")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local value = player:getStorageValueByKey(Storage.BigfootsBurden.ExterminatedCount)
		if value < 10 and player:getStorageValueByKey(Storage.BigfootsBurden.MissionExterminators) == 1 then
			player:setStorageValueByKey(Storage.BigfootsBurden.ExterminatedCount, value + 1)
		end
	end)
	return true
end

creatureevent:register()
