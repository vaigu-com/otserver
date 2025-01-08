local bosses = {
	["deathstrike"] = {
		status = 2,
		rewardStorage = Storage.BigfootBurden.Warzone1Reward,
		timerStorage = Storage.BigfootBurden.DeathstrikeTimer,
		SpawnedStorage = Storage.DeathstrikeSpawned,
	},
	["gnomevil"] = {
		status = 3,
		rewardStorage = Storage.BigfootBurden.Warzone2Reward,
		timerStorage = Storage.BigfootBurden.GnomevilTimer,
		SpawnedStorage = Storage.GnomevilSpawned,
	},
	["abyssador"] = {
		status = 4,
		rewardStorage = Storage.BigfootBurden.Warzone3Reward,
		timerStorage = Storage.BigfootBurden.AbyssadorTimer,
		SpawnedStorage = Storage.AbyssadorSpawned,
	},
}

local creatureevent = CreatureEvent("BigfootBurdenBossDeath")

function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local bossConfig = bosses[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.BigfootBurden.WarzoneStatus) < bossConfig.status then
			player:setStorageValueByKey(Storage.BigfootBurden.WarzoneStatus, bossConfig.status)
		end
		player:setStorageValueByKey(bossConfig.timerStorage, os.time() + 20 * 3600)
		player:setStorageValueByKey(bossConfig.rewardStorage, 1)
	end)

	Game.setStorageValueByKey(bossConfig.SpawnedStorage, 0)
end

creatureevent:register()
