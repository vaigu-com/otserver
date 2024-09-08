local storages = {
	[Storage.BezpieczenstwoIHigienaPracy.Questline] = 13,
	[Storage.BezpieczenstwoIHigienaPracy.Mission06] = 2,
}

local petrusDeath = CreatureEvent("petrusDeath")
function petrusDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	Game.setStorageValue(Storage.BezpieczenstwoIHigienaPracy.Spawns.Petrus, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.BezpieczenstwoIHigienaPracy.Questline)
		if storage_val ~= 12 then
			return true
		end
		player:UpdateStorages(storages)
	end)
	return true
end

petrusDeath:register()
