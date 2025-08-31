local nightmareMonsters = {
	"enfeebled silencer",
	"weakened frazzlemaw",
	"kroazur",
}
local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams

local deathEvent = CreatureEvent("ThreatenedDreamsNightmareMonstersDeath")
function deathEvent.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	if not table.contains(nightmareMonsters, creature:getName():lower()) then
		return true
	end

	onDeathForParty(creature, mostDamageKiller, function(creature, player)
		local enfeebledKills = player:getStorageValueByKey(ThreatenedDreams.Mission02.EnfeebledCount)
		local frazzlemawsKills = player:getStorageValueByKey(ThreatenedDreams.Mission02.FrazzlemawsCount)
		if player:getStorageValueByKey(ThreatenedDreams.Mission02[1]) == 1 then
			player:setStorageValueByKey(ThreatenedDreams.Mission02[1], 1)
			if creature:getName():lower() == nightmareMonsters[1] then
				player:setStorageValueByKey(ThreatenedDreams.Mission02.EnfeebledCount, enfeebledKills + 1)
			elseif creature:getName():lower() == nightmareMonsters[2] then
				player:setStorageValueByKey(ThreatenedDreams.Mission02.FrazzlemawsCount, frazzlemawsKills + 1)
			elseif creature:getName():lower() == nightmareMonsters[3] then
				player:setStorageValueByKey(ThreatenedDreams.Mission02.KroazurKill, 1)
			end
		end
	end)
	return true
end

deathEvent:register()
