local creatureevent = CreatureEvent("PauperizerDeath")

function creatureevent.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.PauperizerKill) ~= 1 then
			player:setStorageValue(Storage.PauperizerKill, 1)
			player:say("Pokonales naszego Wladce.. Nie mamy juz czego chronic..", TALKTYPE_MONSTER_SAY)
		end
	end)
end

creatureevent:register()
