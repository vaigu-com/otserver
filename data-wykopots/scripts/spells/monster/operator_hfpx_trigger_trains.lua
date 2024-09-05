local nextTileId = { wall_vertical = 1451, wall_horizontal = 1450 }

local currentActiveTrains = 0
local maximumActiveTrains = 20
local trainHitDamage = 400
local baseTrainSpeed = 400

local closedToOpen = { [1496] = 16594, [1467] = 16593 }

local verticalGates = {
	HFPX_ANCHOR:Moved(Vector(2, 0, 0)),
	HFPX_ANCHOR:Moved(Vector(4, 0, 0)),
	HFPX_ANCHOR:Moved(Vector(6, 0, 0)),
	HFPX_ANCHOR:Moved(Vector(8, 0, 0)),
	HFPX_ANCHOR:Moved(Vector(10, 0, 0)),
	HFPX_ANCHOR:Moved(Vector(12, 0, 0)),
	HFPX_ANCHOR:Moved(Vector(14, 0, 0)),
}

local horizontalGates = {
	HFPX_ANCHOR:Moved(Vector(0, 2, 0)),
	HFPX_ANCHOR:Moved(Vector(0, 4, 0)),
	HFPX_ANCHOR:Moved(Vector(0, 6, 0)),
	HFPX_ANCHOR:Moved(Vector(0, 8, 0)),
	HFPX_ANCHOR:Moved(Vector(0, 10, 0)),
}

verticalGates = VectorsMovedByAnchor(verticalGates, HFPX_ANCHOR)
horizontalGates = VectorsMovedByAnchor(horizontalGates, HFPX_ANCHOR)

local segmentRight = 7907
local segmentLeft = 7906
local segmentUp = 7908
local segmentDown = 7909

local function openGate(pos)
	local tile = Tile(pos)
	for closedId, openId in pairs(closedToOpen) do
		local gate = tile:getItemById(closedId)
		if gate then
			gate:transform(openId)
			return true
		end
	end
end

local function closeGate(pos)
	local tile = Tile(pos)
	for closedId, openId in pairs(closedToOpen) do
		local gate = tile:getItemById(openId)
		if gate then
			gate:transform(closedId)
			return true
		end
	end
end

local function removePassat(passat)
	for _, value in pairs(passat) do
		if value then
			value:remove()
			currentActiveTrains = currentActiveTrains - 1
		end
	end
end

local function createPassat(orientation, frontPos, passat)
	local backPos = frontPos:Moved(Vector.FromDirection(orientation))

	if orientation == SOUTH then
		passat.front = Game.createItem(segmentDown, 1, frontPos)
		passat.back = Game.createItem(segmentUp, 1, backPos)
	end
	if orientation == EAST then
		passat.front = Game.createItem(segmentRight, 1, frontPos)
		passat.back = Game.createItem(segmentLeft, 1, backPos)
	end
end

local randomSprites = {
	[1] = CONST_ME_FIREATTACK,
	[2] = CONST_ME_FIREATTACK,
	[3] = CONST_ME_FIREWORK_RED,
	[4] = CONST_ME_FIREWORK_RED,
	[5] = CONST_ME_FIREWORK_RED,
	[6] = CONST_ME_FIREAREA,
	[7] = CONST_ME_FIREAREA,
	[8] = CONST_ME_FIREAREA,
	[9] = CONST_ME_FIREAREA,
	[10] = CONST_ME_FIREAREA,
}

local function triggerExplosionSprites(pos)
	pos:sendMagicEffect(randomSprites[math.random(1, #randomSprites)])
end

local function triggerAllExplosions(pos, radius, direction)
	radius = radius or 1
	pos = pos:Moved(Vector.FromDirection(direction))

	IterateBetweenPositions(pos:Moved(radius, radius, 0), pos:Moved(-radius, -radius, 0), function(context)
		local currentPos = context.pos
		triggerExplosionSprites(currentPos)
		local tile = Tile(currentPos)
		local creature = tile:getTopCreature()
		if not creature then
			return
		end

		if creature:isPlayer() then
			doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, -trainHitDamage, -trainHitDamage, CONST_ME_NONE)
		else
			doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, -trainHitDamage * 20, -trainHitDamage * 20, CONST_ME_NONE)
		end
	end)
end

local function passatHitTheWall(nextPos)
	local nextTile = Tile(nextPos)
	if nextTile:getItemById(nextTileId.wall_horizontal) or nextTile:getItemById(nextTileId.wall_vertical) then
		return true
	end
end

local function movePassatParts(passat, direction)
	local nextFront = passat.front:getPosition():Moved(Vector.FromDirection(direction))
	local nextBack = passat.back:getPosition():Moved(Vector.FromDirection(direction))
	passat.front:moveTo(nextFront)
	passat.back:moveTo(nextBack)
end

local function movePassat(direction, frontPos, passatSpeed, i, passat)
	passatSpeed = passatSpeed * 0.95
	i = i - 1
	if i <= 0 then
		removePassat(passat)
		return true
	end

	movePassatParts(passat, direction)
	triggerAllExplosions(frontPos, 1, direction)
	frontPos = frontPos:Moved(Vector.FromDirection(direction))

	local nextPos = frontPos:Moved(Vector.FromDirection(direction))
	if passatHitTheWall(nextPos) then
		removePassat(passat)
		return true
	end

	addEvent(function()
		movePassat(direction, frontPos, passatSpeed, i, passat)
	end, passatSpeed)
end

local function getRandomGatePos(orientation)
	if orientation == EAST then
		return horizontalGates[math.random(1, #horizontalGates)]
	end
	if orientation == SOUTH then
		return verticalGates[math.random(1, #verticalGates)]
	end
	return -1
end

local function tryStartPassat()
	if currentActiveTrains >= maximumActiveTrains then
		return true
	end
	currentActiveTrains = currentActiveTrains + 1

	local orientation = math.random(EAST, SOUTH)
	local chosenGatePos = getRandomGatePos(orientation)
	local offset = Vector.FromDirection(orientation):Scaled(-4)

	local passat = { front = nil, back = nil }
	local i = 30

	if openGate(chosenGatePos) then
		local trainSpawnPos = chosenGatePos:Moved(offset)
		createPassat(orientation, trainSpawnPos, passat)
		movePassat(orientation, trainSpawnPos, baseTrainSpeed, i, passat)
		addEvent(function()
			closeGate(chosenGatePos)
		end, 3000)
	end
	return true
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	tryStartPassat()
	return true
end

spell:name("operator hfpx trigger trains")
spell:words(NextSpellId())
spell:needTarget(false)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(false)
spell:register()
