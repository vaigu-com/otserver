local creatureevent = CreatureEvent("FerumbrasMortalDeath")

function creatureevent.onDeath(creature)
	if Game.getStorageValueByKey(Storage.Ferumbras.FerumbrasMortalTp) < os.time() then
		Game.setStorageValueByKey(Storage.Ferumbras.FerumbrasMortalTp, os.time() + 3 * 60)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:say("Pozostaly ci 3 minuty aby przejsc dalej.", TALKTYPE_MONSTER_SAY)
	end)
end

creatureevent:register()
