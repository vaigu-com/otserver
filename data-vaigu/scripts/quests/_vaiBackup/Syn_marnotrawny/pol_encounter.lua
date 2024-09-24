local polEncounterConfig = {
	actionid = Storage.ProdigalSon.PolAccess,
	bossName = "Pol",
	timerStorage = Storage.ProdigalSon.PolAccess,
	cooldown = "weekly",

	leverPosition = JANUSZEX_ANCHOR:Moved(54, 9, -1),
	entranceGrid = { topLeft = JANUSZEX_ANCHOR:Moved(54, 10, -1), downRight = JANUSZEX_ANCHOR:Moved(54, 13, -1) },

	bossPos = Position(7742, 1010, 9),
	enterPos = Position(7742, 1016, 9),
	durationMinutes = 10,
	exitTeleportDestination = JANUSZEX_ANCHOR:Moved(45, 9, 1),
	exitTeleportPosition = JANUSZEX_ANCHOR:Moved(51, -5, -1),
	exitTeleportActionid = Storage.ProdigalSon.PortalAfterPol,
	corner1 = JANUSZEX_ANCHOR:Moved(51, -15, -1),
	corner2 = JANUSZEX_ANCHOR:Moved(59, -4, -1),

	scalingConfig = { hpPerPlayer = 1 },

	requiredStorages = { [Storage.ProdigalSon.PolAccess] = 1 },
}
RegisterEncounter(polEncounterConfig)

local lever = Action()
function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if UseEncounterLever(player, item, polEncounterConfig) then
	end
end
lever:aid(polEncounterConfig.actionid)
lever:register()
