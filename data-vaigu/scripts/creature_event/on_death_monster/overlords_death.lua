local overlords = {
	["energy overlord"] = { cStorage = Storage.ElementalSphere.KnightBoss },
	["fire overlord"] = { cStorage = Storage.ElementalSphere.SorcererBoss },
	["ice overlord"] = { cStorage = Storage.ElementalSphere.PaladinBoss },
	["earth overlord"] = { cStorage = Storage.ElementalSphere.DruidBoss },
	["lord of the elements"] = {},
}

local creatureevent = CreatureEvent("ElementalOverlordDeath")

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

	if bossConfig.cStorage then
		Game.setStorageValueByKey(bossConfig.cStorage, 0)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if bossConfig.cStorage and player:getStorageValueByKey(bossConfig.cStorage) < 1 then
			player:setStorageValueByKey(bossConfig.cStorage, 1)
		end
		player:say("Pokonales " .. bossName .. ".", TALKTYPE_MONSTER_SAY)
	end)

	return true
end

creatureevent:register()
