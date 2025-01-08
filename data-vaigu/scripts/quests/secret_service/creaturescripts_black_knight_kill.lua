local blackKnightKill = CreatureEvent("BlackKnightDeath")

function blackKnightKill.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.Quest.U8_1.SecretService.AVINMission04) == 1 then
			player:setStorageValueByKey(Storage.Quest.U8_1.SecretService.AVINMission04, 2)
		end
	end)

	return true
end

blackKnightKill:register()
