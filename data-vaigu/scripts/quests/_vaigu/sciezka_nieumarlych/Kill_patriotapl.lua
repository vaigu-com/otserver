	:Script(function(storageToRequiredState)
	:MonsterEvent(function()
local guardian = CreatureEvent("PatriotaPLKill")

function guardian.onDeath(creature)
	local pos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["PatriotaPL"])
	Game.createItem(11965, 1, pos)
end

guardian:register()
end)
end)
