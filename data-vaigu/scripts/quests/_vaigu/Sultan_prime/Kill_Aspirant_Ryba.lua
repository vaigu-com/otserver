local ryba = CreatureEvent("RybaKill")

function ryba.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.SultanPrime.Questline)
		if storage_val ~= 11 then
			return true
		end
		player:setStorageValue(Storage.SultanPrime.Questline, 12)
		player:setStorageValue(Storage.SultanPrime.Mission03, 4)
		player:setStorageValue(Storage.SultanPrime.DoorAfterRyba, 1)
	end)
	return true
end

ryba:register()
