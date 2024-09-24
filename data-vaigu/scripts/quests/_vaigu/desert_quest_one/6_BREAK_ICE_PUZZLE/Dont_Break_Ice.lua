	:Script(function(storageToRequiredState)
local corner1 = DESERT_QUEST_ONE_ANCHOR:Moved(2, 42, 2)
local corner2 = DESERT_QUEST_ONE_ANCHOR:Moved(-8, 8, 2)

local iceId = { [800] = true }
function LoadDesertQuestBreakIce()
	IterateBetweenPositions(corner1, corner2, function(context)
		local tile = Tile(context.pos)
		if not tile then
			return
		end
		local ground = tile:getGround()
		if not ground then
			return
		end

		local groundId = ground:getId()
		if iceId[groundId] then
			ground:setActionId(Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.IceTile)
		end
	end)
end

local function allIceHasCracks(top_left, down_right, scan_id, ground_id)
	for i = top_left.x, down_right.x do
		for j = top_left.y, down_right.y do
			local pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = i, y = j, z = top_left.z })
			local cracks = Tile(pos):getItemById(scan_id)
			local ice = Tile(pos):getItemById(ground_id)

			if cracks == nil and ice ~= nil then
				return false
			end
		end
	end
	return true
end

local function removeAllCracks(top_left, down_right, scan_id, ground_id)
	for i = top_left.x, down_right.x do
		for j = top_left.y, down_right.y do
			local pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = i, y = j, z = top_left.z })
			local cracks = Tile(pos):getItemById(scan_id)
			local ice = Tile(pos):getItemById(ground_id)

			if cracks and ice ~= nil then
				cracks:remove()
			end
		end
	end
	return true
end

local teleportTile = MoveEvent()
function teleportTile.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end

	local id = item.itemid
	local top_left = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.top_left[id]
	local down_right = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.down_right[id]
	local cracks_id = 6298
	local ice_id = 800

	if allIceHasCracks(top_left, down_right, cracks_id, ice_id) == true then
		local pos = player:getPosition()
		pos.y = pos.y - 2
		player:teleportTo(pos)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_DONT_BREAK_ICE.start_pos))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	removeAllCracks(top_left, down_right, cracks_id, ice_id)
	return true
end

teleportTile:aid(Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.TeleportTile)
teleportTile:type("stepin")
teleportTile:register()

local iceTile = MoveEvent()
function iceTile.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end

	local cracks_id = 6298
	local tile = Tile(item:getPosition())

	if not tile:getItemById(cracks_id) then
		Game.createItem(cracks_id, 1, item:getPosition())
	else
		player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_DONT_BREAK_ICE.start_pos))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		local id = DESERT_QUEST_ONE_DONT_BREAK_ICE.ice_y_to_board[toPosition.y - DESERT_QUEST_ONE_ANCHOR.y]
		local top_left = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.top_left[id]
		local down_right = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.down_right[id]
		local cracks_id = 6298
		local ice_id = 800
		removeAllCracks(top_left, down_right, cracks_id, ice_id)
	end
end

iceTile:aid(Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.IceTile)
iceTile:type("stepin")
iceTile:register()
end)
