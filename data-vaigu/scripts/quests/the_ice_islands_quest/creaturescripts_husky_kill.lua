local huskyKill = CreatureEvent("HuskyDeath")

function huskyKill.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local value = player:getStorageValueByKey(Storage.Quest.U8_0.TheIceIslands.HuskyKill) or 0
		player:setStorageValueByKey(Storage.Quest.U8_0.TheIceIslands.HuskyKill, value + 1)
	end)
	return true
end

huskyKill:register()
