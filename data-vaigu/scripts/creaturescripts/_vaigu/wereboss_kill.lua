local wereBossDeath = CreatureEvent("WereBossDeath")
function wereBossDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.WereBossKill) <= 0 then
			player:setStorageValue(Storage.WereBossKill, 1)
		end
	end)
end

wereBossDeath:register()
