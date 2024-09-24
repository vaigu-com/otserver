	:Script(function(storageToRequiredState)
local pressure_plate_enter = MoveEvent()

function pressure_plate_enter.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local mwall = DESERT_QUEST_ONE_MS_RP_MWALLS["MWALL"]
	local mwall_pos = DESERT_QUEST_ONE_ANCHOR:Moved(mwall.offPos)
	local mwall_id = mwall.id

	local stone = DESERT_QUEST_ONE_MS_RP_MWALLS["STONE"]
	local stone_pos = DESERT_QUEST_ONE_ANCHOR:Moved(stone.offPos)
	local stone_id = stone.id

	local mwall_tile = Tile(mwall_pos):getItemById(mwall_id)
	if mwall_tile then
		mwall_tile:remove()
	end

	local stone_tile = Tile(stone_pos):getItemById(stone_id)
	if stone_tile then
		stone_tile:remove()
	end

	item:transform(430)
	player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)

	return true
end

pressure_plate_enter:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.MsRpPressure)
pressure_plate_enter:type("stepin")
pressure_plate_enter:register()

local pressure_plate_exit = MoveEvent()

function pressure_plate_exit.onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local mwall_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MS_RP_MWALLS["MWALL"].offPos)
	local mwall_id = DESERT_QUEST_ONE_MS_RP_MWALLS["MWALL"].id
	local origin = Tile(fromPosition)
	local mwall_tile = Tile(mwall_pos):getItemById(mwall_id)

	local stone_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MS_RP_MWALLS["STONE"].offPos)
	local stone_id = DESERT_QUEST_ONE_MS_RP_MWALLS["STONE"].id
	local stone_tile = Tile(stone_pos):getItemById(stone_id)

	if not mwall_tile then
		if not origin:getTopCreature() then
			Game.createItem(mwall_id, 1, mwall_pos)
		end
	end

	if not stone_tile then
		Game.createItem(stone_id, 1, stone_pos)
	end

	item:transform(431)

	return true
end

pressure_plate_exit:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.MsRpPressure)
pressure_plate_exit:type("stepout")
pressure_plate_exit:register()
end)
