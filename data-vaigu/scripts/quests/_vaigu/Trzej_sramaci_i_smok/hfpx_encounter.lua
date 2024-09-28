local hfpxConfig = {
	actionid = Storage.TrzejSramaciISmok.HfpxAccess,
	bossName = "Operator HF-P/X",
	timerStorage = Storage.TrzejSramaciISmok.HfpxAccess,
	cooldown = "weekly",

	leverPosition = Position(6799, 552, 12),
	entranceGrid = {
		topLeft = Position(6795, 552, 12),
		downRight = Position(6798, 552, 12),
	},
	exitTeleportDestination = Position(6796, 554, 12),
	exitTeleportPosition = Position(6789, 548, 13),
	exitTeleportActionid = Storage.TrzejSramaciISmok.Portals.AfterHfpx,

	bossPos = Position(6791, 550, 13),
	enterPos = Position(6801, 556, 13),
	durationMinutes = 10,
	corner1 = ANCHOR:Moved(0, 0, 0),
	corner2 = ANCHOR:Moved(15, 11, 0),

	requiredStorages = {
		[Storage.TrzejSramaciISmok.HfpxAccess] = 1,
	},
}
RegisterEncounter(hfpxConfig)

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return UseEncounterLever(player, item, hfpxConfig)
end

lever:aid(hfpxConfig.actionid)
lever:register()
