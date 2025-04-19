local creatureevent = CreatureEvent("PauperizerDeath")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.PauperizerKill) ~= 1 then
			player:setStorageValueByKey(Storage.PauperizerKill, 1)
			player:say("Pokonales naszego Wladce.. Nie mamy juz czego chronic..", TALKTYPE_MONSTER_SAY)
		end
	end)
end

creatureevent:register()
