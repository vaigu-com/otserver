local creatureevent = CreatureEvent("InquisitionUngreezDeath")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.TheInquisition.Questline) == 18 then
			-- The Inquisition Questlog- 'Mission 6: The Demon Ungreez'
			player:setStorageValue(Storage.TheInquisition.Mission06, 2)
			player:setStorageValue(Storage.TheInquisition.Questline, 19)
		end
	end)
end

creatureevent:register()
