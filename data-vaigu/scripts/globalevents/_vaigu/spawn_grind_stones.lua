local stoneId = 15824
local startPos = Position(7249, 1378, 12)
local endPos = Position(7324, 1476, 12)

local function stoneSpawn(position)
	local tile = Tile(position)
	if tile then
		local item = tile:getItemById(stoneId)
		if item then
			item:remove()
			local newStone = Game.createItem(stoneId, 1, position)
			if newStone then
				newStone:decay()
			end
		end
	end
end

local function startDecayStones()
	for i = startPos.x, endPos.x do
		for j = startPos.y, endPos.y do
			local pos = Position(i, j, 12)
			local tile = Tile(pos)
			if tile then
				local item = tile:getItemById(stoneId)
				if item then
					addEvent(stoneSpawn, 1000 * math.random(1, 20), pos)
				end
			end
		end
	end
end

local grindStones = GlobalEvent("stone decay")
function grindStones.onStartup()
	startDecayStones()
end

grindStones:register()
