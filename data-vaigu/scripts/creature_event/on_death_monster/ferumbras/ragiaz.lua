local creatureevent = CreatureEvent("RagiazDeath")

function creatureevent.onDeath(creature)
	if Game.getStorageValueByKey(Storage.Ferumbras.RagiazTp) < os.time() then
		Game.setStorageValueByKey(Storage.Ferumbras.RagiazTp, os.time() + 3 * 60)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:say("Pozostaly ci 3 minuty aby przejsc dalej.", TALKTYPE_MONSTER_SAY)
	end)
end

creatureevent:register()
