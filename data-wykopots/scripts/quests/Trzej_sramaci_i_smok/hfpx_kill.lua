local storages = {
	[Storage.TrzejSramaciISmok.Questline] = 23,
	[Storage.TrzejSramaciISmok.Mission09] = 2,
}

local hfpx = CreatureEvent("HfpxKill")

function hfpx.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storageVal = player:getStorageValue(Storage.TrzejSramaciISmok.Questline)
		if storageVal ~= 22 then
			return true
		end
		player:UpdateStorages(storages)
	end)
	return true
end

hfpx:register()
