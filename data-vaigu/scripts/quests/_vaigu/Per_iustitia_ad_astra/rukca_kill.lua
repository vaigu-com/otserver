	:Script(function(storageToRequiredState)
	:MonsterEvent(function()
local updateStorages = {
	[Storage.PerIustitiaAdAstra.Questline] = 26,
	[Storage.PerIustitiaAdAstra.Mission06] = 2,
}

local rukca = CreatureEvent("RukcaKill")

function rukca.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.PerIustitiaAdAstra.Questline)
		if storage_val ~= 25 then
			return true
		end
		player:UpdateStorages(updateStorages)
	end)
	return true
end

rukca:register()
end)
end)
