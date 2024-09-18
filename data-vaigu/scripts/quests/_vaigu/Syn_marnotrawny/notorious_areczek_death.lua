local updateStorages = {
	[Storage.ProdigalSon.Questline] = 11,
	[Storage.ProdigalSon.Mission03] = 5,
}

local notoriousAreczekDeath = CreatureEvent("NotoriousAreczekDeath")
function notoriousAreczekDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.ProdigalSon.Questline) ~= 10 then
			return true
		end
		player:UpdateStorages(updateStorages)
	end)

	Game.setStorageValue(Storage.ProdigalSon.AreczekLeaderBed, 0)
	SwapNotoriousAreczekBed()
	return true
end

notoriousAreczekDeath:register()
