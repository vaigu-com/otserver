local trollKill = CreatureEvent("MorrisTrollDeath")
function trollKill.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(creature, player)
		local killAmount = player:getStorageValueByKey(Storage.Quest.U10_55.Dawnport.MorrisTrollCount)
		if player:getStorageValueByKey(Storage.Quest.U10_55.Dawnport.MorriskTroll) == 1 and killAmount < 20 then
			player:setStorageValueByKey(Storage.Quest.U10_55.Dawnport.MorrisTrollCount, killAmount + 1)
		end
	end)
	return true
end

trollKill:register()
