	:Script(function(storageToRequiredState)
local function swapTile(pos)
	local tile = Tile(pos):getGround()
	local anyid = tile.itemid
	local nextid = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.litToUnlit[anyid] or TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.unlitToLit[anyid]

	if tile then
		tile:transform(nextid)
	end
end

local function swapNearby(pos)
	swapTile(Position(pos.x + 0, pos.y + 0, pos.z + 0))
	swapTile(Position(pos.x + 1, pos.y + 0, pos.z + 0))
	swapTile(Position(pos.x + 0, pos.y + 1, pos.z + 0))
	swapTile(Position(pos.x - 1, pos.y + 0, pos.z + 0))
	swapTile(Position(pos.x + 0, pos.y - 1, pos.z + 0))
end

local plus = MoveEvent()

function plus.onAddItem(moveitem, tileitem, toPosition)
	if moveitem.itemid ~= 3031 then
		return false
	end

	moveitem:remove()
	swapNearby(toPosition)
end

plus:aid(Storage.TheaterOfCheapThrills.PlusShapePuzzle.Tile)
plus:type("additem")
plus:register()
end)
