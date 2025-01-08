local flamingOrchidDeath = CreatureEvent("FlamingOrchidDeath")

function flamingOrchidDeath.onDeath(creature)
	if getStorageValueByKey(Storage.FlamingOrchid) >= 1 then
		setStorageValueByKey(Storage.FlamingOrchid, 0)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.FlamingOrchidKilled) <= 0 then
			player:setStorageValueByKey(Storage.FlamingOrchidKilled, 1)
		end
	end)
end

flamingOrchidDeath:register()
