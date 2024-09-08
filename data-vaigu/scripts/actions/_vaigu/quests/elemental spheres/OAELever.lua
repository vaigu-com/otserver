local config = {
	exitPosition = Position(6227, 1014, 10), --{x = 6227, y = 1014, z = 10}
	area = {
		from = Position(6198, 980, 11), --{x = 6198, y = 980, z = 11}
		to = Position(6260, 1042, 11), --{x = 6260, y = 1042, z = 11}
	},
	positions = {
		Position(6233, 1015, 11), --{x = 6233, y = 1015, z = 11}
		Position(6224, 1015, 11), --{x = 6224, y = 1015, z = 11}
		Position(6224, 1006, 11), --{x = 6224, y = 1006, z = 11}
		Position(6233, 1006, 11), --{x = 6233, y = 1006, z = 11}
	},
	leverPositions = {
		Position(6234, 1006, 11), --{x = 6234, y = 1006, z = 11}
		Position(6234, 1015, 11), --{x = 6234, y = 1015, z = 11}
		Position(6223, 1015, 11), --{x = 6223, y = 1015, z = 11}
		Position(6223, 1006, 11), --{x = 6223, y = 1006, z = 11}
	},
	walls = {
		{ from = Position(6236, 1009, 11), to = Position(6236, 1013, 11), wallId = 5072, soundPosition = Position(6236, 1011, 11) },
		{ from = Position(6227, 1018, 11), to = Position(6231, 1018, 11), wallId = 5071, soundPosition = Position(6229, 1018, 11) },
		{ from = Position(6221, 1009, 11), to = Position(6221, 1013, 11), wallId = 5072, soundPosition = Position(6221, 1011, 11) },
		{ from = Position(6227, 1003, 11), to = Position(6231, 1003, 11), wallId = 5071, soundPosition = Position(6229, 1003, 11) },
	},
	roomArea = {
		from = Position(6222, 1004, 11), --{x = 6222, y = 1004, z = 11}
		to = Position(6235, 1017, 11), --{x = 6235, y = 1017, z = 11}
	},
	machineStorages = { GlobalStorage.ElementalSphere.Machine1, GlobalStorage.ElementalSphere.Machine2, GlobalStorage.ElementalSphere.Machine3, GlobalStorage.ElementalSphere.Machine4 },
	centerPosition = Position(6228, 1011, 11), --{x = 6228, y = 1011, z = 11}
	effectPositions = {
		Position(6222, 1004, 11),
		Position(6223, 1005, 11),
		Position(6224, 1006, 11),
		Position(6225, 1007, 11),
		Position(6226, 1008, 11),
		Position(6227, 1009, 11),
		Position(6228, 1010, 11),
		Position(6229, 1011, 11),
		Position(6230, 1012, 11),
		Position(6231, 1013, 11),
		Position(6232, 1014, 11),
		Position(6233, 1015, 11),
		Position(6234, 1016, 11),
		Position(6235, 1017, 11),
		Position(5235, 1017, 11),
		Position(6234, 1016, 11),
		Position(6233, 1015, 11),
		Position(6232, 1014, 11),
		Position(6231, 1013, 11),
		Position(6230, 1012, 11),
		Position(6229, 1011, 11),
		Position(6228, 1010, 11),
		Position(6227, 1009, 11),
		Position(6226, 1008, 11),
		Position(6225, 1007, 11),
		Position(6224, 1006, 11),
		Position(6223, 1005, 11),
		Position(6222, 1004, 11),
	},
}

local function resetRoom(players)
	for i = 1, #players do
		local player = Player(players[i])
		if player and isInRange(player:getPosition(), config.area.from, config.area.to) then
			player:teleportTo(config.exitPosition)
			config.exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end

	for i = 1, #config.walls do
		local wall = config.walls[i]
		for x = wall.from.x, wall.to.x do
			for y = wall.from.y, wall.to.y do
				local wallItem = Tile(Position(x, y, wall.from.z)):getItemById(wall.wallId)
				if wallItem then
					wallItem:remove()
				end
			end
		end
	end

	local creature = Creature("lord of the elements")
	if creature then
		creature:remove()
	end

	for i = 1, #config.leverPositions do
		local leverItem = Tile(config.leverPositions[i]):getItemById(2773)
		if leverItem then
			leverItem:transform(2772)
		end
	end

	Game.setStorageValue(GlobalStorage.ElementalSphere.BossRoom, -1)
	for i = 1, #config.machineStorages do
		Game.setStorageValue(config.machineStorages[i], -1)
	end
	return true
end

local function warnPlayers(players)
	local player
	for i = 1, #players do
		player = Player(players[i])
		if player and isInRange(player:getPosition(), config.roomArea.from, config.roomArea.to) then
			break
		end
		player = nil
	end

	if not player then
		return
	end

	player:say("Pozostalo ci 5 minut nim zostaniesz teleportowany na zewnatrz.", TALKTYPE_MONSTER_YELL, false, 0, Position(6227, 1011, 12))
end

local function areMachinesCharged()
	for i = 1, #config.machineStorages do
		if Game.getStorageValue(config.machineStorages[i]) <= 0 then
			return false
		end
	end
	return true
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid ~= 2772 then
		return true
	end

	for i = 1, #config.machineStorages do
		Game.setStorageValue(config.machineStorages[i], 1)
	end

	if not areMachinesCharged() then
		return false
	end

	local index = table.find(config.positions, player:getPosition())
	if not index then
		return false
	end

	item:transform(2773)
	local leverCount = 0
	for i = 1, #config.leverPositions do
		if Tile(config.leverPositions[i]):getItemById(2773) then
			leverCount = leverCount + 1
		end
	end

	local walls = config.walls[index]
	for x = walls.from.x, walls.to.x do
		for y = walls.from.y, walls.to.y do
			Game.createItem(walls.wallId, 1, Position(x, y, walls.from.z))
		end
	end
	player:say("ZOOOOOOOOM", TALKTYPE_MONSTER_SAY, false, 0, walls.soundPosition)

	if leverCount ~= #config.leverPositions then
		return true
	end

	local players = {}
	for i = 1, #config.positions do
		local creature = Tile(config.positions[i]):getTopCreature()
		if creature then
			players[#players + 1] = creature.uid
		end
	end

	Game.setStorageValue(GlobalStorage.ElementalSphere.BossRoom, 1)
	Game.createMonster("Lord of the Elements", config.centerPosition)
	player:say("Pozostalo ci 10 minut nim zostaniesz teleportowany na zewnatrz.", TALKTYPE_MONSTER_YELL, false, 0, config.centerPosition)
	addEvent(warnPlayers, 5 * 60 * 1000, players)
	addEvent(resetRoom, 10 * 60 * 1000, players)

	for i = 1, #config.effectPositions do
		config.effectPositions[i]:sendMagicEffect(CONST_ME_ENERGYHIT)
	end
	return true
end

action:uid(9025, 9026, 9027, 9028)
action:register()
