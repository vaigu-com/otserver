local teleportPosition = Position(7488, 1378, 11)

local function transformTeleport()
	local teleportItem = Tile(teleportPosition):getItemById(1949)
	if not teleportItem then
		return
	end

	teleportItem:transform(16173)
end

local function clearArena() -- jak przez 30min nie padnie, to zostanie wyczyszczone
	local spectators = Game.getSpectators(Position(7501, 1411, 11), false, false, 12, 12, 12, 12)
	local exitPosition = Position(7406, 1412, 11)
	for i = 1, #spectators do
		local spectator = spectators[i]
		if spectator:isPlayer() then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
			spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zostales teleportowany przez systemy bezpieczenstwa.")
		else
			spectator:remove()
		end
	end
end

local creatureevent = CreatureEvent("BigfootBurdenVersperothDeath")

function creatureevent.onDeath(creature)
	Game.setStorageValue(GlobalStorage.Versperoth.Battle, 2)
	addEvent(Game.setStorageValue, 30 * 60 * 1000, GlobalStorage.Versperoth.Battle, 0)

	local tp = Game.createItem(1949, 1, teleportPosition) --na koordach
	tp:setActionId(45701) --zmienia aid

	addEvent(transformTeleport, 5 * 60 * 1000)
	addEvent(clearArena, 30 * 60 * 1000)
	return true
end

creatureevent:register()
