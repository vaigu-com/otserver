	:Script(function(missionState)
	:MonsterEvent(function()
local storages = {
	[Storage.ThreeSramatiansAndTheDragon.State] = 23,
	[Storage.ThreeSramatiansAndTheDragon.Mission09] = 2,
}

local hfpx = CreatureEvent("HfpxKill")

function hfpx.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storageVal = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.State)
		if storageVal ~= 22 then
			return true
		end
		player:UpdateStorages(storages)
	end)
	return true
end

hfpx:register()
end)
end)
