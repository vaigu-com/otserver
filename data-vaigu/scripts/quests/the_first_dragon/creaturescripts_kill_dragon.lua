local killDragon = CreatureEvent("TheFirstDragonDragonTaskDeath")

function killDragon.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForParty(creature, mostDamageKiller, function(creature, player)
		local storage = player:getStorageValueByKey(Storage.Quest.U11_02.TheFirstDragon.DragonCounter)
		if storage >= 0 and storage < 200 then
			player:setStorageValueByKey(Storage.Quest.U11_02.TheFirstDragon.DragonCounter, player:getStorageValueByKey(Storage.Quest.U11_02.TheFirstDragon.DragonCounter) + 1)
		end
	end)
	return true
end

killDragon:register()
