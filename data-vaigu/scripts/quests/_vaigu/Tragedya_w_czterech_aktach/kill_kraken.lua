	:Script(function(storageToRequiredState)
	:MonsterEvent(function()
local updateStorages = {
	[Storage.FourActTragedy.Questline] = 10,
	[Storage.FourActTragedy.Mission03] = 2,
}

local theKraken = CreatureEvent("TheKrakenKill")

function theKraken.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.FourActTragedy.Questline)
		if storage_val ~= 9 then
			return true
		end
		player:UpdateStorages(updateStorages)
	end)
	return true
end

theKraken:register()
end)
end)
