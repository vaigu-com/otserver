local renegadeOrcKill = CreatureEvent("RenegadeOrcDeath")

function renegadeOrcKill.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.Quest.U8_54.AnUneasyAlliance.QuestDoor) == 0 then
			player:setStorageValueByKey(Storage.Quest.U8_54.AnUneasyAlliance.QuestDoor, 1)
		end
	end)

	return true
end

renegadeOrcKill:register()
