local storages = {
	[Storage.TheThreeSramatiansAndTheDragon.Questline] = 23,
	[Storage.TheThreeSramatiansAndTheDragon.Mission09] = 2,
}

local hfpx = CreatureEvent("HfpxKill")

function hfpx.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storageVal = player:getStorageValue(Storage.TheThreeSramatiansAndTheDragon.Questline)
		if storageVal ~= 22 then
			return true
		end
		player:UpdateStorages(storages)
	end)
	return true
end

hfpx:register()
