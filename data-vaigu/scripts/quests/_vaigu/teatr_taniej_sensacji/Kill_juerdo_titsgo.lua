local storages = { Storage.TheaterOfCheapThrills.Questline, Storage.TheaterOfCheapThrills.Mission11 }

local juerdoDeath = CreatureEvent("JuerdoDeath")
function juerdoDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	Game.setStorageValue(Storage.TheaterOfCheapThrills.Spawns.JuerdoTitsgo, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.TheaterOfCheapThrills.Mission11)
		if storage_val ~= 2 then
			return true
		end
		player:IncrementStorages(storages, 1)
	end)
	return true
end

juerdoDeath:register()
