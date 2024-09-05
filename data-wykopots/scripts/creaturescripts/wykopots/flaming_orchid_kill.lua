local flamingOrchidDeath = CreatureEvent("FlamingOrchidDeath")

function flamingOrchidDeath.onDeath(creature)
	if getGlobalStorageValue(GlobalStorage.FlamingOrchid) >= 1 then
		setGlobalStorageValue(GlobalStorage.FlamingOrchid, 0)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.FlamingOrchidKilled) <= 0 then
			player:setStorageValue(Storage.FlamingOrchidKilled, 1)
		end
	end)
end

flamingOrchidDeath:register()
