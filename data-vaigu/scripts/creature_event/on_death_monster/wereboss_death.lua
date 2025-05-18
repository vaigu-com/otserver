local wereBossDeathStartup = GlobalEvent("WereBossDeathStartup")
function wereBossDeathStartup.onStartup()
	for _, bossData in pairs(WEREBOSS_DATA) do
		local monsterType = MonsterType(bossData.bossName)
		if monsterType then
			monsterType:registerEvent("WereBossDeath")
		end
	end
end
wereBossDeathStartup:register()

local wereBossDeath = CreatureEvent("WereBossDeath")
function wereBossDeath.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		player:setStorageValueByKey(Storage.WereBossKill, os.time() + 6 * 60 * 60)
	end)
end
wereBossDeath:register()
