local creatureevent = CreatureEvent("InquisitionUngreezDeath")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.TheInquisition.Questline) == 18 then
			-- The Inquisition Questlog- 'Mission 6: The Demon Ungreez'
			player:setStorageValueByKey(Storage.TheInquisition.Mission06, 2)
			player:setStorageValueByKey(Storage.TheInquisition.Questline, 19)
		end
	end)
end

creatureevent:register()
