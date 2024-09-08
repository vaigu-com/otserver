local storages = {
	[Storage.SynMarnotrawny.Questline] = 23,
	[Storage.SynMarnotrawny.Mission06] = 2,
}

local pol = CreatureEvent("PolDeath")
function pol.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.SynMarnotrawny.Questline)
		if storage_val ~= 22 then
			return true
		end
		player:UpdateStorages(storages)
	end)
	return true
end
pol:register()
