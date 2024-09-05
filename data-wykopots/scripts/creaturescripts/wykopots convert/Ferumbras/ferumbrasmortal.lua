local creatureevent = CreatureEvent("FerumbrasMortalDeath")

function creatureevent.onDeath(creature)
	if Game.getStorageValue(GlobalStorage.Ferumbras.FerumbrasMortalTp) < os.time() then
		Game.setStorageValue(GlobalStorage.Ferumbras.FerumbrasMortalTp, os.time() + 3 * 60)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:say("Pozostaly ci 3 minuty aby przejsc dalej.", TALKTYPE_MONSTER_SAY)
	end)
end

creatureevent:register()
