KRAKEN_ENCOUNTER_DATA = {
	actionid = Storage.FourActTragedy.KrakenAccess,
	bossName = "The Kraken",
	timerStorage = Storage.FourActTragedy.KrakenAccess,
	cooldown = "weekly",

	leverPosition = KRAKEN_ANCHOR:Moved(-5, 0, 0),
	leverId = 938,
	entranceGrid = { topLeft = KRAKEN_ANCHOR:Moved(-4, -1, 0), downRight = KRAKEN_ANCHOR:Moved(-3, 1, 0) },

	bossPos = KRAKEN_ANCHOR:Moved(-47, -19, 0),
	enterPos = KRAKEN_ANCHOR:Moved(-46, 0, 0),
	durationMinutes = 10,
	exitTeleportDestination = KRAKEN_ANCHOR:Moved(-297, -51, 2),
	exitTeleportPosition = KRAKEN_ANCHOR:Moved(-53, -23, 0),
	exitTeleportActionid = Storage.FourActTragedy.Portals.AfterKraken,
	corner1 = KRAKEN_ANCHOR:Moved(-58, -30, 0),
	corner2 = KRAKEN_ANCHOR:Moved(-33, 3, 0),

	scalingConfig = { hpPerPlayer = 1 },

	requiredStorages = { [Storage.FourActTragedy.KrakenAccess] = 1 },

	fightningPlatformPositions = {
		topLeft = KRAKEN_ANCHOR:Moved(-58, -30, 0),
		downRight = KRAKEN_ANCHOR:Moved(-33, -8, 0),
		entrance = KRAKEN_ANCHOR:Moved(-47, -15, 0),	
	},
	fightingShipPositions = {
		topLeft = KRAKEN_ANCHOR:Moved(-52, -1, 0),
		downRight = KRAKEN_ANCHOR:Moved(-45, 1, 0),
	},
}
RegisterEncounter(KRAKEN_ENCOUNTER_DATA)

local function startEncounter()
	Game.createMonster("Ship health", KRAKEN_ANCHOR:Moved(-49, 0, 0))
	Game.createMonster("Kraken tentacles", KRAKEN_ANCHOR:Moved(-52, -1, 0))
	Game.createMonster("Kraken tentacles", KRAKEN_ANCHOR:Moved(-44, 0, 0))
end

local krakenLever = Action()
function krakenLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if UseEncounterLever(player, item, KRAKEN_ENCOUNTER_DATA) then
		startEncounter()
	end
end
krakenLever:aid(KRAKEN_ENCOUNTER_DATA.actionid)
krakenLever:register()
