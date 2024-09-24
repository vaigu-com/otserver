	:MonsterEvent(function()
local storages = {
	[Storage.SafetyAndOccupationalHygiene.Questline] = 14,
	[Storage.SafetyAndOccupationalHygiene.Mission06] = 2,
}

local petrusDeath = CreatureEvent("petrusDeath")
function petrusDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	Game.setStorageValue(Storage.SafetyAndOccupationalHygiene.Spawns.Petrus, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.SafetyAndOccupationalHygiene.Questline)
		if storage_val ~= 13 then
			return true
		end
		player:UpdateStorages(storages)
	end)
	return true
end

petrusDeath:register()
end)
