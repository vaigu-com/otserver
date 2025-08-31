local gnomebaseAlphaPosition = Position(33001, 31900, 9)

local bosses = {
	["deathstrike"] = {
		rewardStorage = Storage.BigfootsBurden.Warzone1Reward,
		cooldownStorage = Storage.BigfootsBurden.Warzone1Cooldown,
		spawnLock = SpawnLocks.BigfootsBurden.Warzone1,
		bossRoomZoneName = Storage.BigfootsBurden.Warzone1BossRoom,
	},
	["gnomevil"] = {
		rewardStorage = Storage.BigfootsBurden.Warzone2Reward,
		cooldownStorage = Storage.BigfootsBurden.Warzone2Cooldown,
		spawnLock = SpawnLocks.BigfootsBurden.Warzone2,
		bossRoomZoneName = Storage.BigfootsBurden.Warzone2BossRoom,
	},
	["abyssador"] = {
		rewardStorage = Storage.BigfootsBurden.Warzone3Reward,
		cooldownStorage = Storage.BigfootsBurden.Warzone3Cooldown,
		spawnLock = SpawnLocks.BigfootsBurden.Warzone3,
		bossRoomZoneName = Storage.BigfootsBurden.Warzone3BossRoom,
	},
}

local creatureevent = CreatureEvent("BossesWarzoneDeath")
function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local bossName = targetMonster:getName():lower()
	local bossConfig = bosses[bossName]
	if not bossConfig then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:setStorageValueByKey(bossConfig.cooldownStorage, NextWednesdayEpochTime())
		player:incrementStorageByKeyClampZero(bossConfig.rewardStorage, 1)
	end)

	local players = CreatureList.FromDamageMap(creature:getDamageMap()):FilterByPlayer():Get()
	addEvent(function()
		for _, player in pairs(players) do
			player:teleportTo(gnomebaseAlphaPosition)
		end
		bossConfig.spawnLock:Reset()
	end, 1000 * 60)
end
creatureevent:register()
