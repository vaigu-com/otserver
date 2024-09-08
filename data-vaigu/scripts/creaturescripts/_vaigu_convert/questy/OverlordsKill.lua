local overlords = {
	["energy overlord"] = { cStorage = Storage.ElementalSphere.BossStorage, cGlobalStorage = GlobalStorage.ElementalSphere.KnightBoss },
	["fire overlord"] = { cStorage = Storage.ElementalSphere.BossStorage, cGlobalStorage = GlobalStorage.ElementalSphere.SorcererBoss },
	["ice overlord"] = { cStorage = Storage.ElementalSphere.BossStorage, cGlobalStorage = GlobalStorage.ElementalSphere.PaladinBoss },
	["earth overlord"] = { cStorage = Storage.ElementalSphere.BossStorage, cGlobalStorage = GlobalStorage.ElementalSphere.DruidBoss },
	["lord of the elements"] = {},
}

local creatureevent = CreatureEvent("ElementalSpheresOverlordDeath")

function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local bossName = targetMonster:getName()
	local bossConfig = overlords[bossName:lower()]
	if not bossConfig then
		return true
	end

	if bossConfig.cGlobalStorage then
		Game.setStorageValue(bossConfig.cGlobalStorage, 0)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if bossConfig.cStorage and player:getStorageValue(bossConfig.cStorage) < 1 then
			player:setStorageValue(bossConfig.cStorage, 1)
		end
		player:say("Pokonales " .. bossName .. ".", TALKTYPE_MONSTER_SAY)
	end)

	return true
end

creatureevent:register()
