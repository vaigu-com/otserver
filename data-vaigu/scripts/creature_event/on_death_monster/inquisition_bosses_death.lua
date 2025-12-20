--[[
local bosses = {
	["ushuriel"] = Storage.ushurielTimer,
	["zugurosh"] = Storage.zuguroshTimer,
	["madareth"] = Storage.madarethTimer,
	["latrivan"] = Storage.latrivanTimer,
	["golgordan"] = Storage.golgordanTimer,
	["annihilon"] = Storage.annihilonTimer,
	["hellgorak"] = Storage.hellgorakTimer,
}

local creatureevent = CreatureEvent("InquisitionBossDeath")

function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local bossName = targetMonster:getName():lower()
	local bossStorage = bosses[bossName]
	if not bossStorage then
		return true
	end

	local newValue = 2
	if bossName == "latrivan" or bossName == "golgordan" then
		newValue = math.max(0, Game.getStorageValueByKey(bossStorage)) + 1
		if newValue > 2 then
			newValue = 2
		end
	end
	Game.setStorageValueByKey(bossStorage, newValue)

	if newValue == 2 then
		onDeathForDamagingPlayers(creature, function(creature, player)
			player:say("Pozostalo ci 10 minut aby przejsc dalej. Teleport przeniesie cie do nastepnego pokoju.", TALKTYPE_MONSTER_SAY)
		end)
		addEvent(Game.setStorageValueByKey, 10 * 60 * 1000, bossStorage, 0)
	end
	return true
end

creatureevent:register()
]]
