local storages = { Storage.TeatrTaniejSensacji.Questline, Storage.TeatrTaniejSensacji.Mission11 }

local juerdoDeath = CreatureEvent("JuerdoDeath")
function juerdoDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	Game.setStorageValue(Storage.TeatrTaniejSensacji.Spawns.JuerdoTitsgo, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.TeatrTaniejSensacji.Mission11)
		if storage_val ~= 2 then
			return true
		end
		player:IncrementStorages(storages, 1)
	end)
	return true
end

juerdoDeath:register()
