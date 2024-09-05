local globalevent = GlobalEvent("FlamingOrchid")

function globalevent.onThink(...)
	if getGlobalStorageValue(GlobalStorage.FlamingOrchid) >= 1 then
		return false
	end

	Game.createMonster("The Flaming Orchid", Position(6615, 997, 3))
	setGlobalStorageValue(GlobalStorage.FlamingOrchid, 1)
	return true
end

globalevent:interval(30 * 60 * 1000) --30min
globalevent:register()
