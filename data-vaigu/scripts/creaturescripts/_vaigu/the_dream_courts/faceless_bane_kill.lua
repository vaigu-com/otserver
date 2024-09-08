local facelessDeath = CreatureEvent("FacelessDeath")
function facelessDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.TheDreamCourts.FacelessKilled) <= 0 then
			player:setStorageValue(Storage.TheDreamCourts.FacelessKilled, 1)
			player:setStorageValue(Storage.TheDreamCourts.StrickenMission, 4)
		end
	end)
end

facelessDeath:register()
