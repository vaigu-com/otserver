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
	end)
end

deeplingBosses:register()
