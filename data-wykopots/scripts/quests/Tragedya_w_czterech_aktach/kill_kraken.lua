local updateStorages = {
	[Storage.TragedyaWCzterechAktach.Questline] = 10,
	[Storage.TragedyaWCzterechAktach.Mission03] = 2,
}

local theKraken = CreatureEvent("TheKrakenKill")

function theKraken.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.TragedyaWCzterechAktach.Questline)
		if storage_val ~= 9 then
			return true
		end
		player:UpdateStorages(updateStorages)
	end)
	return true
end

theKraken:register()
