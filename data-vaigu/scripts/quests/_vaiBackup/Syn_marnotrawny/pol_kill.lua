	:MonsterEvent(function()
local storages = {
	[Storage.ProdigalSon.Questline] = 23,
	[Storage.ProdigalSon.Mission06] = 2,
}

local pol = CreatureEvent("PolDeath")
function pol.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.ProdigalSon.Questline)
		if storage_val ~= 22 then
			return true
		end
		player:UpdateStorages(storages)
	end)
	return true
end
pol:register()
end)
