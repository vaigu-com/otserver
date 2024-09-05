local zulSzczurowEncounter = {
	actionid = Storage.TragedyaWCzterechAktach.ZulSzczurowAccess,
	bossName = "Zul Szczurow",
	timerStorage = Storage.TragedyaWCzterechAktach.ZulSzczurowAccess,
	cooldown = "weekly",

	leverPosition = ZUL_SZCZUROW_ANCHOR:Moved(0, -7, 0),
	entranceGrid = { topLeft = ZUL_SZCZUROW_ANCHOR:Moved(0, -6, 0), downRight = ZUL_SZCZUROW_ANCHOR:Moved(0, -3, 0) },

	bossPos = ZUL_SZCZUROW_ANCHOR:Moved(-3, -9, 1),
	enterPos = ZUL_SZCZUROW_ANCHOR:Moved(11, 1, 1),
	durationMinutes = 10,
	exitTeleportDestination = ZUL_SZCZUROW_ANCHOR:Moved(0, 0, 0),
	exitTeleportPosition = ZUL_SZCZUROW_ANCHOR:Moved(-8, 8, 1),
	exitTeleportActionid = Storage.TragedyaWCzterechAktach.Portals.AfterZulSzczurow,
	corner1 = ZUL_SZCZUROW_ANCHOR:Moved(-13, 12, 1),
	corner2 = ZUL_SZCZUROW_ANCHOR:Moved(16, -17, 1),

	scalingConfig = { hpPerPlayer = 1 },

	requiredStorages = { [Storage.TragedyaWCzterechAktach.ZulSzczurowAccess] = 1 },
}
RegisterEncounter(zulSzczurowEncounter)

local function startEncounter()
	Game.createMonster("Zul zulow", ZUL_SZCZUROW_ANCHOR:Moved(1, -8, 1))
end

local zulLever = Action()
function zulLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if UseEncounterLever(player, item, zulSzczurowEncounter) then
		startEncounter()
	end
end
zulLever:aid(zulSzczurowEncounter.actionid)
zulLever:register()
