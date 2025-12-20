local nomadKill = CreatureEvent("NomadDeath")
function nomadKill.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(creature, player)
		if player:getStorageValueByKey(Storage.Quest.U8_2.TheThievesGuildQuest.Mission04) == 3 then
			player:setStorageValueByKey(Storage.Quest.U8_2.TheThievesGuildQuest.Mission04, 4)
		end
	end)
	return true
end

nomadKill:register()
