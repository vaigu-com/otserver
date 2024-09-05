local updateStorages = {
	[Storage.SynMarnotrawny.Questline] = 11,
	[Storage.SynMarnotrawny.Mission03] = 5,
}

local notoriousAreczekDeath = CreatureEvent("NotoriousAreczekDeath")
function notoriousAreczekDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.SynMarnotrawny.Questline) ~= 10 then
			return true
		end
		player:UpdateStorages(updateStorages)
	end)

	Game.setStorageValue(Storage.SynMarnotrawny.AreczekLeaderBed, 0)
	SwapNotoriousAreczekBed()
	return true
end

notoriousAreczekDeath:register()
