local rukcaConfig = {
	actionid = Storage.PerIustitiaAdAstra.RukcaAccess,
	bossName = "Ruk'ca Maw",
	timerStorage = Storage.PerIustitiaAdAstra.RukcaAccess,
	cooldown = "weekly",

	leverPosition = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 87, 1),
	entranceGrid = {
		topLeft = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 83, 1),
		downRight = HUGO_BEACH_PLANET_ANCHOR:Moved(60, 86, 1),
	},

	bossPos = RUKCA_ANCHOR:Moved(44, 22, 0),
	enterPos = RUKCA_ANCHOR:Moved(46, 24, 0),
	durationMinutes = 5,
	exitTeleportDestination = RUKCA_ANCHOR:Moved(-21, -11, -1),
	corner1 = RUKCA_ANCHOR:Moved(-37, -17, 0),
	corner2 = RUKCA_ANCHOR:Moved(53, 32, 0),

	requiredStorages = {
		[Storage.PerIustitiaAdAstra.RukcaAccess] = 1,
	},
	cannotEnterDuring = true,
}
RegisterEncounter(rukcaConfig)

local originalSealCage = ItemExList():Area(RUKCA_ANCHOR:Moved(-1, 26, 0), RUKCA_ANCHOR:Moved(0, 27, 0))

local sealCagePositions = {
	RUKCA_ANCHOR:Moved(3, 1, 0),
	RUKCA_ANCHOR:Moved(10, -15, 0),
	RUKCA_ANCHOR:Moved(20, -6, 0),
	RUKCA_ANCHOR:Moved(15, 9, 0),
	RUKCA_ANCHOR:Moved(36, 11, 0),
	RUKCA_ANCHOR:Moved(34, 26, 0),
	RUKCA_ANCHOR:Moved(-6, 12, 0),
	RUKCA_ANCHOR:Moved(-17, 9, 0),
	RUKCA_ANCHOR:Moved(-24, 2, 0),
}

local cages = ItemExList()

local function tryRemoveBabySealCages()
	cages:Remove()
end

local function initializeBabySealCages()
	for _, destination in pairs(sealCagePositions) do
		cages:AddMultiple(originalSealCage:Copied(destination))
	end
end

local function startEncounter()
	tryRemoveBabySealCages()
	initializeBabySealCages()
end
local rukcaLever = Action()

function rukcaLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if UseEncounterLever(player, item, rukcaConfig) then
		startEncounter()
	end
end

rukcaLever:aid(rukcaConfig.actionid)
rukcaLever:register()
