local bosses = {
	["jaul"] = { storage = Storage.DeeplingBosses.Jaul },
	["tanjis"] = { storage = Storage.DeeplingBosses.Tanjis },
	["obujos"] = { storage = Storage.DeeplingBosses.Obujos },
}

local deeplingBosses = CreatureEvent("DeeplingBossDeath")
function deeplingBosses.onDeath(creature)
	local bossConfig = bosses[creature:getName():lower()]
	if not bossConfig then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:incrementStorageByKeyClampZero(bossConfig.storage, 1)
		player:setLockoutExpiry(Storage.DeeplingBosses.DailyBossLockout, LOCKOUT_EXPIRY_TIME.DAILY)
	end)
end

deeplingBosses:register()
