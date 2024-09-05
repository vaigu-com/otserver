local updateStorages = {
	[Storage.TragedyaWCzterechAktach.Questline] = 18,
	[Storage.TragedyaWCzterechAktach.Mission06] = 4,
}

local zulSzczurowDeath = CreatureEvent("ZulSzczurowDeath")

function zulSzczurowDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.TragedyaWCzterechAktach.Questline)
		if storage_val ~= 17 then
			return true
		end
		player:UpdateStorages(updateStorages)
	end)

	return true
end

zulSzczurowDeath:register()
