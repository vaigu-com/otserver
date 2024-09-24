	:Script(function(storageToRequiredState)
local item = Action()

local function moveGround(from_pos, to_pos)
	if Tile(from_pos):getGround() then
		Tile(from_pos):getGround():moveTo(to_pos)
	end
end

local function moveCreature(from_pos, to_pos)
	if Tile(from_pos):getTopCreature() then
		Tile(from_pos):getTopCreature():teleportTo(to_pos)
	end
end

local function moveTiles(start_pos, count, dir)
	local from_pos
	local to_pos

	if dir == "+x" then
		for i = 1, count do
			from_pos = Position(start_pos.x + count - i + 1, start_pos.y, start_pos.z)
			to_pos = Position(start_pos.x + count - i + 2, start_pos.y, start_pos.z)
			moveCreature(from_pos, to_pos)
			moveGround(from_pos, to_pos)
		end
	elseif dir == "-x" then
		for i = 1, count do
			from_pos = Position(start_pos.x - count + i - 1, start_pos.y, start_pos.z)
			to_pos = Position(start_pos.x - count + i - 2, start_pos.y, start_pos.z)
			moveCreature(from_pos, to_pos)
			moveGround(from_pos, to_pos)
		end
	elseif dir == "+y" then
		for i = 1, count do
			from_pos = Position(start_pos.x, start_pos.y + count - i + 1, start_pos.z)
			to_pos = Position(start_pos.x, start_pos.y + count - i + 2, start_pos.z)
			moveCreature(from_pos, to_pos)
			moveGround(from_pos, to_pos)
		end
	elseif dir == "-y" then
		for i = 1, count do
			from_pos = Position(start_pos.x, start_pos.y - count + i - 1, start_pos.z)
			to_pos = Position(start_pos.x, start_pos.y - count + i - 2, start_pos.z)
			moveCreature(from_pos, to_pos)
			moveGround(from_pos, to_pos)
		end
	end
end

function item.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local pos = item:getPosition()
	local x = pos.x
	local y = pos.y
	local z = pos.z

	if Tile(Position(x + 1, y, z)) and Tile(Position(x + 1, y, z)):getItemById(1127) then
		moveTiles(pos, 6, "+x")
	elseif Tile(Position(x - 1, y, z)) and Tile(Position(x - 1, y, z)):getItemById(1127) then
		moveTiles(pos, 6, "-x")
	elseif Tile(Position(x, y + 1, z)) and Tile(Position(x, y + 1, z)):getItemById(1127) then
		moveTiles(pos, 13, "+y")
	elseif Tile(Position(x, y - 1, z)) and Tile(Position(x, y - 1, z)):getItemById(1127) then
		moveTiles(pos, 13, "-y")
	end

	return true
end

item:aid(Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever)
item:register()
end)
