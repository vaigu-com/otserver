local bosses = {
	["preceptor lazare"] = { storage = Storage.TheSecretLibrary.TheOrderOfTheFalcon.PreceptorKilled },
	["grand chaplain gaunder"] = { storage = Storage.TheSecretLibrary.TheOrderOfTheFalcon.GaunderKilled },
	["grand canon dominus"] = { storage = Storage.TheSecretLibrary.TheOrderOfTheFalcon.DominusKilled },
	["grand commander soeren"] = { storage = Storage.TheSecretLibrary.TheOrderOfTheFalcon.SoerenKilled },
	["grand master oberon"] = { storage = Storage.TheSecretLibrary.TheOrderOfTheFalcon.OberonKilled },
}

local falconBossDeath = CreatureEvent("FalconBossDeath")
function falconBossDeath.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local bossConfig = bosses[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(bossConfig.storage) <= 0 then
			player:setStorageValue(bossConfig.storage, 1)
		end
	end)
end

falconBossDeath:register()
