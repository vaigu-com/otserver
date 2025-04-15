local dreamBossDeath = CreatureEvent("DreamBossDeath")
function dreamBossDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.TheDreamCourts.KilledBosses) <= 0 then
			player:setStorageValueByKey(Storage.TheDreamCourts.KilledBosses, 1)
		elseif (player:getStorageValueByKey(Storage.TheDreamCourts.KilledBosses) > 0) and (player:getStorageValueByKey(Storage.TheDreamCourts.KilledBosses) < 5) then
			player:setStorageValueByKey(Storage.TheDreamCourts.KilledBosses, (player:getStorageValueByKey(Storage.TheDreamCourts.KilledBosses) + 1))
		end
	end)
end

dreamBossDeath:register()

local nightmareBeastDeath = CreatureEvent("NightmareBeastDeath")
function nightmareBeastDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.TheDreamCourts.QuestLine) == 3 then
			player:setStorageValueByKey(Storage.TheDreamCourts.QuestLine, 4)
		end
	end)
end

nightmareBeastDeath:register()
