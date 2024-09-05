local dreamBossDeath = CreatureEvent("DreamBossDeath")
function dreamBossDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.TheDreamCourts.KilledBosses) <= 0 then
			player:setStorageValue(Storage.TheDreamCourts.KilledBosses, 1)
		elseif (player:getStorageValue(Storage.TheDreamCourts.KilledBosses) > 0) and (player:getStorageValue(Storage.TheDreamCourts.KilledBosses) < 5) then
			player:setStorageValue(Storage.TheDreamCourts.KilledBosses, (player:getStorageValue(Storage.TheDreamCourts.KilledBosses) + 1))
		end
	end)
end

dreamBossDeath:register()

local nightmareBeastDeath = CreatureEvent("NightmareBeastDeath")
function nightmareBeastDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.TheDreamCourts.QuestLine) == 3 then
			player:setStorageValue(Storage.TheDreamCourts.QuestLine, 4)
		end
	end)
end

nightmareBeastDeath:register()
