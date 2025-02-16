local scopes = {
	crossroadMonster = Scope("Crossroad", "Monster"),
	generateCrossroadMonsters = Scope("Crossroad", "GenerateCrossroadMonsters"),
	teleportEastToWest = Scope("Crossroad", "TeleporWest"),
	teleportWestToEast = Scope("Crossroad", "TeleporEast"),
}

CrossroadOrchestrator = {}
CrossroadOrchestrator.__index = CrossroadOrchestrator
function CrossroadOrchestrator.New(...)
	local newObj = {}
	setmetatable(newObj, CrossroadOrchestrator)
end
setmetatable(CrossroadOrchestrator, {
	__call = function(_, ...)
		return CrossroadOrchestrator.New(...)
	end,
})
function CrossroadOrchestrator.GetMonsterNameBySpeed(speed)
	return scopes.crossroadMonster:Get(speed)
end

--TODO factor might be nonliear
local disappearAtMovesCount = 30
local function teleportToLoopCart(monster, delayBetweenMoving, dir, moves)
	moves = moves or 1
	addEvent(function()
		monster:move(dir)
		if moves >= disappearAtMovesCount then
			monster:remove()
			return
		end
		teleportToLoopCart(monster, delayBetweenMoving, dir, moves)
	end, delayBetweenMoving)
end

local blockageId = 2187
local elevationId = 25602
local function tryUnlockEast(log)
	local blockagePos = log:getPosition():Move(1, 1, -1)
	blockagePos:sendMagicEffect(CONST_ME_STUN)

	local blockage = blockagePos:GetItemById(blockageId)
	if blockage then
		blockage:transform(elevationId)
	end
end
local function splashPlayers(pos)
	local players = Tile(pos):getCreatures()
	local penaltyPos = pos:Move(0, 1, 0)
	for _, player in pairs(players) do
		player:addHealth(-0.2 * player:getMaxHealth() + 1)
		player:teleportTo(penaltyPos)
	end
	pos:sendMagicEffect(CONST_ME_WATERSPLASH)
end
local function tryLockEast(log)
	local elevationPos = log:getPosition():Move(0, 1, -1)
	elevationPos:sendMagicEffect(CONST_ME_POFF)
	local elevation = elevationPos:GetItemById(elevationId)
	if elevation then
		elevation:transform(blockageId)
		splashPlayers(elevationPos)
	end
end
ACTIVE_CROSS = false
local function logTeleportLoopEast(logs, delayBetweenMoving)
	addEvent(function()
		if not ACTIVE_CROSS then
			return
		end
		for _, log in pairs(logs) do
			for _, part in pairs(log.parts) do
				part:move(DIRECTION_EAST)
			end
			tryUnlockEast(log)
			tryLockEast(log)
		end

		logTeleportLoopEast(logs, delayBetweenMoving)
	end, delayBetweenMoving)
end

local function tryUnlockWest(log)
	local blockagePos = log:getPosition():Move(1, 1, -1)
	blockagePos:sendMagicEffect(CONST_ME_STUN)

	local blockage = blockagePos:GetItemById(blockageId)
	if blockage then
		blockage:transform(elevationId)
	end
end
local function tryLockWest(log)
	local elevationPos = log:getPosition():Move(2, 1, -1)
	elevationPos:sendMagicEffect(CONST_ME_POFF)
	local elevation = elevationPos:GetItemById(elevationId)
	if elevation then
		elevation:transform(blockageId)
		splashPlayers(elevationPos)
	end
end
local function logTeleportLoopWest(logs, delayBetweenMoving)
	addEvent(function()
		if not ACTIVE_CROSS then
			return
		end
		for _, log in pairs(logs) do
			for _, part in pairs(log.parts) do
				part:move(DIRECTION_WEST)
			end
			tryUnlockWest(log)
			tryLockWest(log)
		end

		logTeleportLoopWest(logs, delayBetweenMoving)
	end, delayBetweenMoving)
end

local bufferPos = Position(6012, 2364, 7)

local westId = 3922
local centerId = 3923
local eastId = 3929
local function generateLogMovingEast(length, leftmostPosition, speed)
	local log = { parts = {} }

	local east = Game.createMonster(CROSSROAD_MONSTER_BASE.NON_DAMAGING.ANY, leftmostPosition:Moved(length - 1, 0, 0), false, true)
	if not east then
		PrintPosition(leftmostPosition:Moved(length - 1, 0, 0))
	end
	east:setOutfit({ lookTypeEx = eastId })
	table.insert(log.parts, east)
	for i = length - 1, 2, -1 do
		local part = Game.createMonster(CROSSROAD_MONSTER_BASE.NON_DAMAGING.ANY, leftmostPosition:Moved(i - 1, 0, 0), false, true)
		part:setOutfit({ lookTypeEx = centerId })
		table.insert(log.parts, part)
	end
	local west = Game.createMonster(CROSSROAD_MONSTER_BASE.NON_DAMAGING.ANY, leftmostPosition:Moved(1 - 1, 0, 0), false, true)
	west:setOutfit({ lookTypeEx = westId })
	table.insert(log.parts, west)

	for _, part in pairs(log.parts) do
		part:changeSpeed(speed)
	end
	log.first = east
	log.last = west
	return log
end
local function generateLogMovingWest(length, rightmostPosition, speed)
	local log = { parts = {} }

	local west = Game.createMonster(CROSSROAD_MONSTER_BASE.NON_DAMAGING.ANY, rightmostPosition:Moved(-(length - 1), 0, 0), false, true)
	west:setOutfit({ lookTypeEx = westId })
	table.insert(log.parts, west)
	for i = 2, length - 1 do
		local part = Game.createMonster(CROSSROAD_MONSTER_BASE.NON_DAMAGING.ANY, rightmostPosition:Moved(-(i - 1), 0, 0), false, true)
		part:setOutfit({ lookTypeEx = centerId })
		table.insert(log.parts, part)
	end
	local east = Game.createMonster(CROSSROAD_MONSTER_BASE.NON_DAMAGING.ANY, rightmostPosition:Moved(-(1 - 1), 0, 0), false, true)
	east:setOutfit({ lookTypeEx = eastId })
	table.insert(log.parts, east)

	for _, part in pairs(log.parts) do
		part:changeSpeed(speed)
	end
	log.first = west
	log.last = east
	return log
end

local laneWidth = 107
local maxLogLength = 8
local minLogLength = 2
local minGapLength = 2
local maxGapLength = 6
local dirToLogGenerator = {
	[DIRECTION_WEST] = generateLogMovingWest,
	[DIRECTION_EAST] = generateLogMovingEast,
}
local dirToSign = {
	[DIRECTION_WEST] = -1,
	[DIRECTION_EAST] = 1,
}
local function preSpawnLogs(edgePosition, dir, speed)
	local allocableWidth = laneWidth - 1
	edgePosition:Move(dirToSign[dir] * 1)
	local logs = {}
	while true do
		local gapToNext = math.random(minGapLength, maxGapLength)
		if allocableWidth < (minLogLength + gapToNext) then
			break
		end
		local allocableLogWidth = allocableWidth - gapToNext
		if allocableLogWidth < minLogLength then
			break
		end

		local logLength = math.random(minLogLength, math.min(allocableLogWidth, maxLogLength))
		if not Tile(edgePosition:Moved(logLength - 1, 0, 0)) then
			_ = _
		end
		local log = dirToLogGenerator[dir](logLength, edgePosition, speed)
		table.insert(logs, log)
		edgePosition:Move(dirToSign[dir] * (logLength + gapToNext), 0, 0)
		allocableWidth = allocableWidth - logLength - gapToNext
	end
	return logs
end

local dirToMinecartGenerator = {
	[DIRECTION_WEST] = generateMinecartMovingWest,
}
local maxMinecartLength = 3
local function preSpawnMinecarts(edgePosition, dir, speed)
	--TODO
	local allocableWidth = laneWidth - 1
	edgePosition:Move(dirToSign[dir] * 1)
	local minecarts = {}
	while true do
		local gapToNext = math.random(minGapLength, maxGapLength)
		if allocableWidth < (minLogLength + gapToNext) then
			break
		end
		local allocableLogWidth = allocableWidth - gapToNext
		if allocableLogWidth < minLogLength then
			break
		end

		local logLength = math.random(minLogLength, math.min(allocableLogWidth, maxMinecartLength))
		if not Tile(edgePosition:Moved(logLength - 1, 0, 0)) then
			_ = _
		end
		local log = dirToMinecartGenerator[dir](logLength, edgePosition, speed)
		table.insert(logs, log)
		edgePosition:Move(dirToSign[dir] * (logLength + gapToNext), 0, 0)
		allocableWidth = allocableWidth - logLength - gapToNext
	end
end

---@class AnimationNames

local animationNames = {
	minecart = "minecart",
	horseWagon = "horseWagon",
	log = "log",
}

---@class MonsterStripe
---@field westSegment table
---@field eastSegment table
---@field centerSegments table[]
---@field dir number
---@field builtMonsters table
---@field westMostMonster Monster
---@field eastMostMonster Monster
MonsterStripe = {}
MonsterStripe.__index = MonsterStripe
function MonsterStripe.New(...)
	local newObj = {}
	newObj.westSegment = {}
	newObj.eastSegment = {}
	newObj.centerSegments = {}
	newObj.builtMonsters = {}
	setmetatable(newObj, MonsterStripe)
	return newObj
end
setmetatable(MonsterStripe, {
	__call = function(_, ...)
		return MonsterStripe.New(...)
	end,
})
function MonsterStripe:GetSize()
	return self.size
end
function MonsterStripe:Build()
	if self:GetDirection() == DIRECTION_EAST then
		self:FlipSegmentsInsides()
		self.eastMostMonster = self.eastSegment[1] or self.centerSegments[1]
		for _, monster in pairs(self.eastSegment) do
			table.insert(self.builtMonsters, monster)
		end
		for _, monster in pairs(self.centerSegments) do
			table.insert(self.builtMonsters, monster)
		end
		for _, monster in pairs(self.westSegment) do
			table.insert(self.builtMonsters, monster)
		end
		self.westMostMonster = self.westSegment[#self.westSegment] or self.centerSegments[#self.centerSegments]
	else
		self.westMostMonster = self.westSegment[1] or self.centerSegments[1]
		for _, monster in pairs(self.westSegment) do
			table.insert(self.builtMonsters, monster)
		end
		for _, monster in pairs(self.centerSegments) do
			table.insert(self.builtMonsters, monster)
		end
		for _, monster in pairs(self.eastSegment) do
			table.insert(self.builtMonsters, monster)
		end
		self.eastMostMonster = self.eastSegment[#self.eastSegment] or self.centerSegments[#self.centerSegments]
	end
	self.size = #self.builtMonsters
	self.built = true
	return self
end
function MonsterStripe:GetWestMost()
	return self.westMostMonster
end
function MonsterStripe:GetEastMost()
	return self.eastMostMonster
end
function MonsterStripe:Move()
	for _, monster in pairs(self.builtMonsters) do
		monster:move(self:GetDirection())
	end
end
function MonsterStripe:FlipSegmentsInsides()
	TryReverseTable(self.westSegment)
	TryReverseTable(self.eastSegment)
	TryReverseTable(self.centerSegments)
	return self
end
function MonsterStripe:SetWestSegment(stripePart)
	self.westSegment = stripePart
	return self
end
function MonsterStripe:SetEastSegment(stripePart)
	self.eastSegment = stripePart
	return self
end
function MonsterStripe:AddCenterSegment(stripePart)
	table.insert(self.centerSegments, stripePart)
	return self
end
function MonsterStripe:SetDirection(dir)
	self.dir = dir
end
function MonsterStripe:GetDirection()
	return self.dir
end
MonsterStripeFactory = {}
MonsterStripeFactory.__index = MonsterStripeFactory
function MonsterStripeFactory.New(...)
	local newObj = {}
	setmetatable(newObj, MonsterStripeFactory)
	return newObj
end
setmetatable(MonsterStripeFactory, {
	__call = function(_, ...)
		return MonsterStripeFactory.New(...)
	end,
})

AnimationRegistry = {}
AnimationRegistry.__index = AnimationRegistry
AnimationRegistry.registry = {}
function AnimationRegistry:Register(animation)
	self.registry[animation:GetName()] = animation
end
function AnimationRegistry:Get(id)
	return self.registry[id]
end
---@class Animation
---@field name number
Animation = {}
Animation.__index = Animation
function Animation.New(name)
	local newObj = {}
	newObj.name = name
	newObj.westStripes = {}
	newObj.eastStripes = {}
	newObj.centerStripes = {}
	newObj.isOneHeaded = false
	setmetatable(newObj, Animation)
	return newObj
end
setmetatable(Animation, {
	__call = function(_, ...)
		return Animation.New(...)
	end,
})
function Animation:GetName()
	return self.name
end
---@param ... AnimationStripe[]
function Animation:AddWestStripes(...)
	for _, animationStripe in pairs({ ... }) do
		table.insert(self.westStripes, animationStripe)
	end
end
---@param ... AnimationStripe[]
function Animation:AddEastStripes(...)
	for _, animationStripe in pairs({ ... }) do
		table.insert(self.eastStripes, animationStripe)
	end
end
---@param ... AnimationStripe[]
function Animation:AddCenterStripes(...)
	for _, animationStripe in pairs({ ... }) do
		table.insert(self.centerStripes, animationStripe)
	end
end
function Animation:SetIsOneHeaded(isOneHeaded)
	self.isOneHeaded = isOneHeaded
end
function Animation:GetRandomWestStripe()
	return table.random(self.westStripes)
end
function Animation:GetRandomEastStripe()
	return table.random(self.eastStripes)
end
function Animation:GetRandomCenterStripe()
	return table.random(self.centerStripes)
end

---@class AnimationStripe
---@field textureIds number[]
---@field isLookTypeEx boolean true means item id; false means appearance id
---@field size number
AnimationStripe = {}
AnimationStripe.__index = AnimationStripe
function AnimationStripe.New(...)
	local newObj = {}
	newObj.textureIds = {}
	newObj.isLookTypeEx = false
	for _, textureId in pairs({ ... }) do
		table.insert(newObj.textureIds, textureId)
	end
	newObj.size = #newObj.textureIds
	setmetatable(newObj, AnimationStripe)
	return newObj
end
setmetatable(AnimationStripe, {
	__call = function(_, ...)
		return AnimationStripe.New(...)
	end,
})
function AnimationStripe:GetSize()
	return self.size
end
AnimationStripeEx = {}
AnimationStripeEx.__index = AnimationStripeEx
function AnimationStripeEx.New(...)
	local animationStripeEx = AnimationStripe(...)
	animationStripeEx.isLookTypeEx = true
	return animationStripeEx
end
setmetatable(AnimationStripeEx, {
	__call = function(_, ...)
		return AnimationStripeEx.New(...)
	end,
})
function AnimationStripe:Get()
	return self.textureIds
end
function AnimationStripe:IsLookTypeEx()
	return self.isLookTypeEx
end

--TODO add return newObj

local horseWagonAnimation = Animation(animationNames.horseWagon)
horseWagonAnimation:AddWestStripes(AnimationStripe(434), AnimationStripe(435), AnimationStripe(436))
horseWagonAnimation:AddCenterStripes(AnimationStripeEx(7954, 7953), AnimationStripeEx(7901, 7900), AnimationStripeEx(7907, 7906))
horseWagonAnimation:AddEastStripes(AnimationStripe(434), AnimationStripe(435), AnimationStripe(436))
horseWagonAnimation:SetIsOneHeaded(true)
AnimationRegistry:Register(horseWagonAnimation)

local logAnimation = Animation(animationNames.log)
logAnimation:AddWestStripes(AnimationStripeEx(3922))
logAnimation:AddCenterStripes(AnimationStripeEx(3923), AnimationStripeEx(3924), AnimationStripeEx(3925), AnimationStripeEx(3926), AnimationStripeEx(3927))
logAnimation:AddEastStripes(AnimationStripeEx(3929))
logAnimation:SetIsOneHeaded(false)
AnimationRegistry:Register(logAnimation)

local minecartAnimation = Animation(animationNames.minecart)
minecartAnimation:AddWestStripes(AnimationStripeEx(7131))
minecartAnimation:AddCenterStripes(AnimationStripeEx(7131))
minecartAnimation:AddEastStripes(AnimationStripeEx(7131))
minecartAnimation:SetIsOneHeaded(true)
AnimationRegistry:Register(minecartAnimation)

function MonsterStripeFactory.CreateStripeSegments(animation, leftmostPosition, speed, centerSegmentsCount)
	local westSegment = {}
	local westAnimationStripe = animation:GetRandomWestStripe()
	local reservedTiles = 0
	for _, id in pairs(westAnimationStripe:Get()) do
		local monster = Game.createMonster(CrossroadOrchestrator.GetMonsterNameBySpeed(speed), leftmostPosition:Moved(reservedTiles, 0, 0))
		if westAnimationStripe:IsLookTypeEx() then
			monster:setOutfit({ lookTypeEx = id })
		else
			monster:setOutfit({ lookType = id })
		end
		table.insert(westSegment, monster)
		reservedTiles = reservedTiles + 1
	end
	local centerSegments = {}
	local cemterAnimationStripe = animation:GetRandomCenterStripe()
	for _ = 1, centerSegmentsCount do
		for _, id in pairs(cemterAnimationStripe:Get()) do
			local monster = Game.createMonster(CrossroadOrchestrator.GetMonsterNameBySpeed(speed), leftmostPosition:Moved(reservedTiles, 0, 0))
			if cemterAnimationStripe:IsLookTypeEx() then
				monster:setOutfit({ lookTypeEx = id })
			else
				monster:setOutfit({ lookType = id })
			end
			table.insert(centerSegments, monster)
			reservedTiles = reservedTiles + 1
		end
	end
	local eastSegment = {}
	local eastAnimationStripe = animation:GetRandomEastStripe()
	for _, id in pairs(eastAnimationStripe:Get()) do
		local monster = Game.createMonster(CrossroadOrchestrator.GetMonsterNameBySpeed(speed), leftmostPosition:Moved(reservedTiles, 0, 0))
		if eastAnimationStripe:IsLookTypeEx() then
			monster:setOutfit({ lookTypeEx = id })
		else
			monster:setOutfit({ lookType = id })
		end
		table.insert(eastSegment, monster)
		reservedTiles = reservedTiles + 1
	end
	return westSegment, centerSegments, eastSegment
end
function MonsterStripeFactory.CreateMonsterStripe(animation, leftmostPosition, speed, dir, centerStripesCount)
	local monsterStripe = MonsterStripe()
	monsterStripe:SetDirection(dir)

	local westSegment, centerSegments, eastSegment = MonsterStripeFactory.CreateStripeSegments(animation, leftmostPosition, speed, centerStripesCount)
	monsterStripe:SetWestSegment(westSegment)
	monsterStripe:SetEastSegment(eastSegment)
	for _, centerSegment in pairs(centerSegments) do
		monsterStripe:AddCenterSegment(centerSegment)
	end
	monsterStripe:Build()
	return monsterStripe
end

local cobbledSpeedFactor = 1.5
local function cartSpawner(position, dir, speed)
	--local speed = 150 + math.random(-5, 5) * 10

	local delayBetweenMoving = 100 / (speed * cobbledSpeedFactor) * 1000
	local cart = Game.createMonster(CROSSROAD_MONSTER_BASE.NON_DAMAGING.ANY, bufferPos, false, true)
	cart:teleportTo(position)
	cart:setOutfit({ lookTypeEx = 7131 })
	cart:changeSpeed(speed)
	teleportToLoopCart(cart, delayBetweenMoving, dir)

	local tillNextSpawn = math.random(1, 10) * speed + 10
	addEvent(cartSpawner, tillNextSpawn, position, dir, speed)
end

local cross = MinigameData({
	minigameName = "Crossroad",
	competitionType = MINIGAME_COMPETITION_TYPE.SPEEDRUN,
})

local startEvent = TalkAction("!cross")
function startEvent.onSay(player, words, param)
	cross:TryStartLobbyFast()
	return false
end
startEvent:separator(" ")
startEvent:groupType("tutor")
startEvent:register()

local pos1 = Position(5998, 2359, 6)
local pos2 = Position(5998, 2360, 6)
local pos3 = Position(5998, 2361, 6)
local talkactionCart = TalkAction("!cross_cart1")
function talkactionCart.onSay(player, words, param)
	local speed = 150
	cartSpawner(pos1, DIRECTION_EAST, speed)
	cartSpawner(pos2, DIRECTION_WEST, speed + 30)
	cartSpawner(pos3, DIRECTION_EAST, speed)
	return false
end
talkactionCart:separator(" ")
talkactionCart:groupType("tutor")
talkactionCart:register()

local dirToLoop = {
	[DIRECTION_WEST] = logTeleportLoopWest,
	[DIRECTION_EAST] = logTeleportLoopEast,
}

local dirToNextDir = {
	[DIRECTION_WEST] = DIRECTION_EAST,
	[DIRECTION_EAST] = DIRECTION_WEST,
}

local topItems = {
	log = 3922,
	minecart = 7131,
	horseWagon = 7906,
}
local topItemToAnimation = {
	[topItems.log] = AnimationRegistry:Get(animationNames.log),
	[topItems.minecart] = AnimationRegistry:Get(animationNames.minecart),
	[topItems.horseWagon] = AnimationRegistry:Get(animationNames.horseWagon),
}
local topItemToMaxStripes = {
	[topItems.log] = 6,
	[topItems.minecart] = 2,
	[topItems.horseWagon] = 2,
}

---@param logStripe MonsterStripe
---@param delayBetweenMoving number
local function logLooperEast(logStripe, delayBetweenMoving)
	addEvent(function()
		if not ACTIVE_CROSS then
			return
		end
		logStripe:Move()
		local westMost = logStripe:GetWestMost()
		local eastMost = logStripe:GetEastMost()
		tryUnlockEast(eastMost)
		tryLockEast(westMost)
		logLooperEast(logStripe, delayBetweenMoving)
	end, delayBetweenMoving)
end
---@param logStripe MonsterStripe
---@param delayBetweenMoving number
local function logLooperWest(logStripe, delayBetweenMoving)
	addEvent(function()
		if not ACTIVE_CROSS then
			return
		end
		logStripe:Move()
		local westMost = logStripe:GetWestMost()
		local eastMost = logStripe:GetEastMost()
		tryUnlockWest(westMost)
		tryLockWest(eastMost)
		logLooperWest(logStripe, delayBetweenMoving)
	end, delayBetweenMoving)
end

---@param monsterStripe MonsterStripe
---@param delayBetweenMoving number
local function damagingLooperWest(monsterStripe, delayBetweenMoving)
	addEvent(function()
		if not ACTIVE_CROSS then
			return
		end
		monsterStripe:Move()
		logLooperWest(monsterStripe, delayBetweenMoving)
	end, delayBetweenMoving)
end
---@param monsterStripe MonsterStripe
---@param delayBetweenMoving number
local function damagingLooperEast(monsterStripe, delayBetweenMoving)
	addEvent(function()
		if not ACTIVE_CROSS then
			return
		end
		monsterStripe:Move()
		logLooperEast(monsterStripe, delayBetweenMoving)
	end, delayBetweenMoving)
end
local topItemToDirToLooper = {
	[topItems.log] = {
		[DIRECTION_WEST] = logLooperWest,
		[DIRECTION_EAST] = logLooperEast,
	},
	[topItems.minecart] = {
		[DIRECTION_WEST] = damagingLooperWest,
		[DIRECTION_EAST] = damagingLooperEast,
	},
	[topItems.horseWagon] = {
		[DIRECTION_WEST] = damagingLooperWest,
		[DIRECTION_EAST] = damagingLooperEast,
	},
}

local talkactionLog = TalkAction("!cross_log1")
function talkactionLog.onSay(player, words, param)
	ACTIVE_CROSS = true

	local const_start_position = Position(5935, 2368, 7)
	local lastPos = const_start_position:Moved(0, -250, -1)
	local const_speed = 100
	local nextDir = DIRECTION_EAST
	local skipToLine = 2
	local skipTeleport = 1
	--TODO orchestrator
    IterateBetweenPositions(const_start_position, lastPos, function(context)
		local edgePos = context.pos
		local tile = Tile(edgePos)
		if not tile then
			return
		end
		local topItem = tile:getTopTopItem()
		if not topItem then
			return
		end
		local topItemId = topItem:getId()

		edgePos:Move(skipToLine, 0, 0)
		--TODO create once, at server startup
		local eastToWest = edgePos:Moved(laneWidth - 1, 0, 0)
		Tile(eastToWest):getGround():setKey(scopes.teleportEastToWest:Get())
		local westToEast = edgePos:Moved(0, 0, 0)
		Tile(westToEast):getGround():setKey(scopes.teleportWestToEast:Get())

		local animation = topItemToAnimation[topItemId]
		local centerStripesCount = math.random(1, topItemToMaxStripes[topItemId])
		local monsterStripe = MonsterStripeFactory.CreateMonsterStripe(animation, edgePos:Moved(skipTeleport, 0, 0), const_speed, nextDir, centerStripesCount)
		local reservedTilesCount = monsterStripe:GetSize()
		local looper = topItemToDirToLooper[topItemId][nextDir]
		looper(monsterStripe, 100 / const_speed * 1000 / math.log(const_speed, 25)) --TODO
		nextDir = dirToNextDir[nextDir]
	end)
	return false
end
talkactionLog:separator(" ")
talkactionLog:groupType("tutor")
talkactionLog:register()

local talkactionStopCrossroad = TalkAction("!cross_stop")
function talkactionStopCrossroad.onSay(player, words, param)
	ACTIVE_CROSS = false
end
talkactionStopCrossroad:separator(" ")
talkactionStopCrossroad:groupType("tutor")
talkactionStopCrossroad:register()

local teleportWest = MoveEvent()
function teleportWest.onStepIn(creature, item, toPosition, fromPosition)
	creature:teleportTo(toPosition:Move(-(laneWidth - 2), 0, 0))
	return true
end
teleportWest:key(scopes.teleportEastToWest:Get())
teleportWest:register()
local teleportEast = MoveEvent()
function teleportEast.onStepIn(creature, item, toPosition, fromPosition)
	creature:teleportTo(toPosition:Move((laneWidth - 2), 0, 0))
	return true
end
teleportEast:key(scopes.teleportWestToEast:Get())
teleportEast:register()

local function generateMonsterDefinition(speed)
	local mType = Game.createMonsterType(CrossroadOrchestrator.GetMonsterNameBySpeed(speed))
	local monster = {}

	monster.description = "nothing special"
	monster.experience = 0
	monster.outfit = {
		lookType = 1668,
		lookHead = 0,
		lookBody = 0,
		lookLegs = 0,
		lookFeet = 0,
		lookAddons = 0,
		lookMount = 0,
	}

	monster.health = 100
	monster.maxHealth = 100
	monster.race = "undead"
	monster.speed = speed
	monster.manaCost = 0

	monster.flags = {
		summonable = false,
		attackable = false,
		hostile = false,
		convinceable = false,
		pushable = false,
		rewardBoss = false,
		illusionable = false,
		canPushItems = false,
		canPushCreatures = false,
		staticAttackChance = 98,
		targetDistance = 1,
		runHealth = 0,
		healthHidden = true,
		isBlockable = false,
		canWalkOnEnergy = true,
		canWalkOnFire = true,
		canWalkOnPoison = true,
		ignoreCreatures = true,
	}

	monster.light = {
		level = 0,
		color = 0,
	}

	monster.faction = FACTION_PLAYER

	monster.loot = {}

	monster.attacks = {}

	monster.defenses = {
		defense = 105,
		armor = 105,
	}

	monster.elements = {
		{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
		{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
		{ type = COMBAT_EARTHDAMAGE, percent = 100 },
		{ type = COMBAT_FIREDAMAGE, percent = 100 },
		{ type = COMBAT_LIFEDRAIN, percent = 100 },
		{ type = COMBAT_MANADRAIN, percent = 100 },
		{ type = COMBAT_DROWNDAMAGE, percent = 100 },
		{ type = COMBAT_ICEDAMAGE, percent = 100 },
		{ type = COMBAT_HOLYDAMAGE, percent = 100 },
		{ type = COMBAT_DEATHDAMAGE, percent = 100 },
	}

	monster.immunities = {
		{ type = "paralyze", condition = true },
		{ type = "outfit", condition = true },
		{ type = "invisible", condition = true },
		{ type = "bleed", condition = true },
	}

	mType:register(monster)
end
local speeds = {
	75,
	100,
	175,
	200,
	250,
	300,
}
local generateCrossroadMonsters = GlobalEvent(scopes.generateCrossroadMonsters:Get())
function generateCrossroadMonsters.onStartup()
	for _, speed in pairs(speeds) do
		generateMonsterDefinition(speed)
	end
end
generateCrossroadMonsters:register()
