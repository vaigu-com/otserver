local goblinKill = CreatureEvent("MorrisGoblinDeath")
function goblinKill.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(creature, player)
		local killAmount = player:getStorageValueByKey(Storage.Quest.U10_55.Dawnport.MorrisGoblinCount)
		if player:getStorageValueByKey(Storage.Quest.U10_55.Dawnport.MorrisGoblin) == 1 and killAmount < 20 then
			player:setStorageValueByKey(Storage.Quest.U10_55.Dawnport.MorrisGoblinCount, killAmount + 1)
		end
	end)
	return true
end

goblinKill:register()
