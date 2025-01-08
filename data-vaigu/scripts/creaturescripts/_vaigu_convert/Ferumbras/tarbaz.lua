local creatureevent = CreatureEvent("TarbazDeath")

function creatureevent.onDeath(creature)
	if Game.getStorageValueByKey(Storage.Ferumbras.TarbazTp) < os.time() then
		Game.setStorageValueByKey(Storage.Ferumbras.TarbazTp, os.time() + 3 * 60)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:say("Pozostaly ci 3 minuty aby przejsc dalej.", TALKTYPE_MONSTER_SAY)
	end)
end

creatureevent:register()
