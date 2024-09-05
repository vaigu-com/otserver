local eggPositions = {}
local nestId = 14750
local config = {
	startPos = {
		[1] = Position(5803, 1479, 7),
	},
	endPos = {
		[1] = Position(5998, 1604, 7),
	},
}

local function setupPositions()
	local startPos = config.startPos[1]
	local endPos = config.endPos[1]

	eggPositions = {}
	for k = 5, 7 do
		for i = startPos.x, endPos.x do
			for j = startPos.y, endPos.y do
				local pos = Position(i, j, k)
				local tile = Tile(pos)
				if tile then
					if tile:getItemById(nestId) then -- egg nest
						local posTable = { pos = pos }
						table.insert(eggPositions, posTable)
					end
				end
			end
		end
	end
end

local function nestSpawn(position)
	local delay = math.random(30, 60)
	local tile = Tile(position)
	if tile then
		if not tile:getItemById(nestId) then
			if math.random(1, 2) == 1 then
				Game.createItem(nestId, 1, position)
			end
		end
	end
	addEvent(nestSpawn, 1000 * 60 * delay, position)
end

local function runNestsSpawn()
	for _, nestPos in ipairs(eggPositions) do
		local nestSpawnDelay = math.random(1, 5)
		local position = Position(nestPos.pos.x, nestPos.pos.y, nestPos.pos.z)
		local tile = Tile(position)
		if tile then
			position:removeItem(nestId) -- remove nest
			addEvent(nestSpawn, 1000 * 60 * nestSpawnDelay, position)
		end
	end
end

local easterEggs = GlobalEvent("easter eggs")
function easterEggs.onStartup()
	setupPositions()
	runNestsSpawn()
end

easterEggs:register()
