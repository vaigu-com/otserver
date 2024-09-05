local guardian = CreatureEvent("CalaNapszutKill")

function guardian.onDeath(creature)
	local pos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["CalaNapszut"])
	Game.createItem(11965, 1, pos)
end

guardian:register()
