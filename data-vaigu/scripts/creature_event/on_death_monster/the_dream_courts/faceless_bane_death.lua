local facelessDeath = CreatureEvent("FacelessDeath")
function facelessDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.TheDreamCourts.FacelessKilled) <= 0 then
			player:setStorageValueByKey(Storage.TheDreamCourts.FacelessKilled, 1)
			player:setStorageValueByKey(Storage.TheDreamCourts.StrickenMission, 4)
		end
	end)
end

facelessDeath:register()
