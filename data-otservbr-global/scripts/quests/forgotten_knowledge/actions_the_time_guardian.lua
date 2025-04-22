local config = {
<<<<<<< HEAD
	centerRoom = Position(32977, 31662, 14),
	newPosition = Position(32977, 31667, 14),
}

local bosses = {
	{ bossPosition = Position(32977, 31662, 14), bossName = "The Time Guardian" },
	{ bossPosition = Position(32975, 31664, 13), bossName = "The Freezing Time Guardian" },
	{ bossPosition = Position(32980, 31664, 13), bossName = "The Blazing Time Guardian" },
}

local leverTimeGuardian = Action()

function leverTimeGuardian.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8911 then
		if player:getPosition() ~= Position(33010, 31660, 14) then
			item:transform(8912)
			return true
		end
	end
	if item.itemid == 8911 then
		local playersTable = {}
		if player:doCheckBossRoom("The Time Guardian", Position(32967, 31654, 13), Position(32989, 31677, 14)) then
			for q = 1, #bosses do
				Game.createMonster(bosses[q].bossName, bosses[q].bossPosition, true, true)
			end
			for y = 31660, 31664 do
				local playerTile = Tile(Position(33010, y, 14)):getTopCreature()
				if playerTile and playerTile:isPlayer() then
					playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
					playerTile:teleportTo(config.newPosition)
					playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					playerTile:setStorageValue(Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianTimer, os.time() + 20 * 60 * 60)
					table.insert(playersTable, playerTile:getId())
				end
			end
			addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, Position(32967, 31654, 13), Position(32989, 31677, 14), Position(32870, 32724, 14))
			item:transform(8912)
		end
	elseif item.itemid == 8912 then
		item:transform(8911)
	end
	return true
end

leverTimeGuardian:position(Position(33010, 31659, 14))
leverTimeGuardian:register()
=======
	boss = {
		name = "The Time Guardian",
		position = Position(32977, 31662, 14),
	},
	requiredLevel = 250,
	playerPositions = {
		{ pos = Position(33010, 31660, 14), teleport = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31661, 14), teleport = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31662, 14), teleport = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31663, 14), teleport = Position(32977, 31667, 14) },
		{ pos = Position(33010, 31664, 14), teleport = Position(32977, 31667, 14) },
	},
	monsters = {
		{ name = "The Freezing Time Guardian", pos = Position(32975, 31664, 13) },
		{ name = "The Blazing Time Guardian", pos = Position(32980, 31664, 13) },
	},
	specPos = {
		from = Position(32967, 31654, 14),
		to = Position(32989, 31677, 14),
	},
	exit = Position(32870, 32724, 14),
}

local lever = BossLever(config)
lever:position(Position(33010, 31659, 14))
lever:register()
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
