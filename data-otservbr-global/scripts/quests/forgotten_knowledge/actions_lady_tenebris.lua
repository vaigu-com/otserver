local config = {
<<<<<<< HEAD
	centerRoom = Position(32912, 31599, 14),
	bossPosition = Position(32912, 31599, 14),
	newPosition = Position(32911, 31603, 14),
}

local leverLadyTenebris = Action()

function leverLadyTenebris.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		if player:getPosition() ~= Position(32902, 31623, 14) then
			return true
		end
	end
	if item.itemid == 8911 then
		local playersTable = {}
		if player:doCheckBossRoom("Lady Tenebris", Position(32902, 31589, 14), Position(32924, 31610, 14)) then
			for d = 1, 6 do
				Game.createMonster("shadow tentacle", Position(math.random(32909, 32914), math.random(31596, 31601), 14), true, true)
			end
			Game.createMonster("lady tenebris", config.bossPosition, true, true)
			for y = 31623, 31627 do
				local playerTile = Tile(Position(32902, y, 14)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(config.newPosition)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.LadyTenebrisTimer, os.time() + 20 * 60 * 60)
					table.insert(playersTable, playerTile:getId())
				end
			end
			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(32902, 31589, 14), Position(32924, 31610, 14), Position(32919, 31639, 14))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end

	return true
end

leverLadyTenebris:position(Position(32902, 31622, 14))
leverLadyTenebris:register()
=======
	boss = {
		name = "Lady Tenebris",
		position = Position(32912, 31599, 14),
	},
	requiredLevel = 250,
	playerPositions = {
		{ pos = Position(32902, 31623, 14), teleport = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31624, 14), teleport = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31625, 14), teleport = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31626, 14), teleport = Position(32911, 31603, 14) },
		{ pos = Position(32902, 31627, 14), teleport = Position(32911, 31603, 14) },
	},
	monsters = {
		{ name = "shadow tentacle", pos = Position(32910, 31599, 14) },
		{ name = "shadow tentacle", pos = Position(32912, 31597, 14) },
		{ name = "shadow tentacle", pos = Position(32914, 31599, 14) },
	},
	specPos = {
		from = Position(32899, 31587, 14),
		to = Position(32923, 31612, 14),
	},
	exit = Position(32902, 31629, 14),
}

local lever = BossLever(config)
lever:position(Position(32902, 31622, 14))
lever:register()
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
