local wereBossDeath = CreatureEvent("WereBossDeath")
function wereBossDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		player:setStorageValueByKey(Storage.WereBossKill, os.time() + 6 * 60 * 60)
	end)
end

wereBossDeath:register()
