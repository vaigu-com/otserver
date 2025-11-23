local ungreezKill = CreatureEvent("UngreezDeath")
function ungreezKill.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	local player = Player(mostDamageKiller)
	if not player then
		return true
	end
	if player:getStorageValueByKey(Storage.TheInquisition.Questline) == 18 then
		-- The Inquisition Questlog- 'Mission 6: The Demon Ungreez'
		player:setStorageValueByKey(Storage.TheInquisition.Mission06, 2)
		player:setStorageValueByKey(Storage.TheInquisition.Questline, 19)
	end
	return true
end

ungreezKill:register()
