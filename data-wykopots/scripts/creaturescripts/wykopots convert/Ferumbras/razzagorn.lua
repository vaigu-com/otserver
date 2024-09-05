local creatureevent = CreatureEvent("RazzagornDeath")

function creatureevent.onDeath(creature)
	if Game.getStorageValue(GlobalStorage.Ferumbras.RazzagornTp) < os.time() then
		Game.setStorageValue(GlobalStorage.Ferumbras.RazzagornTp, os.time() + 3 * 60)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:say("Pozostaly ci 3 minuty aby przejsc dalej.", TALKTYPE_MONSTER_SAY)
	end)
end

creatureevent:register()
