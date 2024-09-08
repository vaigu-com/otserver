local creatureevent = CreatureEvent("ZamuloshDeath")

function creatureevent.onDeath(creature)
	if Game.getStorageValue(GlobalStorage.Ferumbras.ZamuloshTp) < os.time() then
		Game.setStorageValue(GlobalStorage.Ferumbras.ZamuloshTp, os.time() + 3 * 60)
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		player:say("Pozostaly ci 3 minuty aby przejsc dalej.", TALKTYPE_MONSTER_SAY)
	end)
end

creatureevent:register()
