local config = {
<<<<<<< HEAD
	centerRoom = Position(33481, 32334, 13),
	BossPosition = Position(33481, 32334, 13),
	newPosition = Position(33482, 32339, 13),
	deathDragons = {
		Position(33476, 32331, 13),
		Position(33476, 32340, 13),
		Position(33487, 32340, 13),
		Position(33488, 32331, 13),
	},
}

local leverRagiaz = Action()

function leverRagiaz.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		if player:getPosition() ~= Position(33456, 32356, 13) then
			item:transform(8912)
			return true
		end
	end

	if item.itemid == 8911 then
		local playersTable = {}
		if player:doCheckBossRoom("Ragiaz", Position(33472, 32323, 13), Position(33493, 32347, 13)) then
			local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
			for i = 1, #specs do
				spec = specs[i]
				if spec:isPlayer() then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Ragiaz.")
					return true
				end
			end
			Game.createMonster("Ragiaz", config.BossPosition, true, true)
			for d = 1, #config.deathDragons do
				Game.createMonster("Death Dragon", config.deathDragons[d], true, true)
			end
			for x = 33456, 33460 do
				local playerTile = Tile(Position(x, 32356, 13)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(config.newPosition)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					playerTile:setStorageValue(Storage.Quest.U10_90.FerumbrasAscension.RagiazTimer, os.time() + 60 * 60 * 2 * 24)
					table.insert(playersTable, playerTile:getId())
				end
			end
			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(33472, 32323, 13), Position(33493, 32347, 13), Position(33319, 32318, 13))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end

	return true
end

leverRagiaz:uid(1023)
leverRagiaz:register()
=======
	boss = {
		name = "Ragiaz",
		position = Position(33481, 32334, 13),
	},

	timeToDefeat = 30 * 60,
	playerPositions = {
		{ pos = Position(33456, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33457, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33458, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33459, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33460, 32356, 13), teleport = Position(33482, 32339, 13), effect = CONST_ME_TELEPORT },
	},
	monsters = {
		{ name = "Death Dragon", pos = Position(33476, 32331, 13) },
		{ name = "Death Dragon", pos = Position(33476, 32340, 13) },
		{ name = "Death Dragon", pos = Position(33487, 32340, 13) },
		{ name = "Death Dragon", pos = Position(33488, 32331, 13) },
	},
	specPos = {
		from = Position(33468, 32319, 13),
		to = Position(33495, 32347, 13),
	},
	exit = Position(33319, 32318, 13),
}

local lever = BossLever(config)
lever:position(Position(33455, 32356, 13))
lever:register()
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
