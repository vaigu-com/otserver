local wereBossDeath = CreatureEvent("WereBossDeath")
function wereBossDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		player:setStorageValueByKey(Storage.WereBossKill, NextDayEpochTime())
	end)
end

wereBossDeath:register()
