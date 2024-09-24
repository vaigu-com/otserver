	:Script(function(storageToRequiredState)
local config = { ["waterPumpNotReady"] = "Water pump is not ready yet" }

local function drenchNearbyTiles(pos)
	local water = Tile(pos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.water_id)
	if not water then
		return false
	else
		water:transform(DESERT_QUEST_ONE_WATER_FLOW.nothing_special)
		addEvent(function()
			drenchNearbyTiles(Position(pos.x + 1, pos.y + 0, pos.z + 0))
			drenchNearbyTiles(Position(pos.x + 0, pos.y + 1, pos.z + 0))
			drenchNearbyTiles(Position(pos.x - 1, pos.y + 0, pos.z + 0))
			drenchNearbyTiles(Position(pos.x + 0, pos.y - 1, pos.z + 0))
		end, 160 * DESERT_QUEST_ONE_WATER_FLOW.watering_rate)
		return true
	end
end

local function nextTileIsWood(pos)
	local dryPos = Position(pos)
	dryPos.x = dryPos.x - 1
	dryPos.y = dryPos.y - 1
	dryPos.z = dryPos.z + 1

	local dryTile = Tile(dryPos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.dry_id)
	return dryTile
end

local function waterDriedTree(pos)
	local dryPos = Position(pos)
	dryPos.x = dryPos.x - 1
	dryPos.y = dryPos.y - 1
	dryPos.z = dryPos.z + 1
	local dead_tree = Tile(dryPos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.dead_tree_id)
	if dead_tree then
		dead_tree:transform(DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_id)
	end
end

local function waterNearbyTiles(pos)
	local tile = Tile(pos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.nothing_special)
	if not tile then
		return false
	end

	if nextTileIsWood(pos) then
		tile:transform(DESERT_QUEST_ONE_WATER_FLOW.water_id)
		addEvent(function()
			waterNearbyTiles(Position(pos.x + 1, pos.y + 0, pos.z + 0))
			waterNearbyTiles(Position(pos.x + 0, pos.y + 1, pos.z + 0))
			waterNearbyTiles(Position(pos.x - 1, pos.y + 0, pos.z + 0))
			waterNearbyTiles(Position(pos.x + 0, pos.y - 1, pos.z + 0))
		end, 100 * DESERT_QUEST_ONE_WATER_FLOW.watering_rate)
	else
		waterDriedTree(pos)
		return false
	end
end

local valve = Action()

function valve.onUse(creature, item, fromPosition, itemEx, toPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end

	local pipe_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_WATER_FLOW.pipe_pos)
	local pipe_ready = DESERT_QUEST_ONE_WATER_FLOW.pipe_ready
	local cooldown = DESERT_QUEST_ONE_WATER_FLOW.pipe_cooldown

	if Tile(pipe_pos):getItemById(cooldown) then
		player:say(player:Localizer(Storage.DesertQuestOne.Questline):Get(config.text), TALKTYPE_MONSTER_SAY)
		return false
	end

	local pipe = Tile(pipe_pos):getItemById(pipe_ready)
	pipe:transform(cooldown)
	local start_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_WATER_FLOW.start_pos)
	waterNearbyTiles(start_pos)

	addEvent(function()
		drenchNearbyTiles(start_pos)
	end, 1000 * 5)

	addEvent(function()
		pipe:transform(pipe_ready)
	end, 100 * DESERT_QUEST_ONE_WATER_FLOW.watering_rate * 50 + 1000 * 10)
	return true
end

valve:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.PipeValve)
valve:register()
end)
