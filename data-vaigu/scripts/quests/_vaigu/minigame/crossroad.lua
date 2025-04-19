local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest:NoQuestlog():Script(function()
	local scopes = {
		crossroadMonster = Scope("Crossroad", "Monster"),
		generateCrossroadMonsters = Scope("Crossroad", "GenerateCrossroadMonsters"),
		teleportEastToWest = Scope("Crossroad", "TeleporWest"),
		teleportWestToEast = Scope("Crossroad", "TeleporEast"),
		edgePositions = Scope("Minigames", "Crossroad", "EdgePositions"),
		initializeCrossroad = Scope("Minigames", "Crossroad", "InitializeCrossroad"),
		initializeAnimations = Scope("Minigames", "Crossroad", "InitializeAnimations"),
	}

	--#region EDITABLE
	local animationNames = {
		minecart = "minecart",
		horseWagon = "horseWagon",
		log = "log",
	}
	local sharedLobbyAppearPositionStartup = GlobalEvent(scopes.initializeAnimations:Get())
	function sharedLobbyAppearPositionStartup.onStartup()
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
	end
	sharedLobbyAppearPositionStartup:register()

	local speeds = {
		150,
		200,
		350,
		400,
		500,
		600,
		700,
	}
	--Requies changes in otbm
	local topItems = {
		log = 3922,
		minecart = 7131,
		horseWagon = 7906,
	}
	local topItemToMaxStripes = {
		[topItems.log] = 4,
		[topItems.minecart] = 2,
		[topItems.horseWagon] = 2,
	}
	local minGapLength = 2
	local maxGapLength = 5

	--Requires changes in otbm
	local gameHeight = 260
	local laneWidth = 107

	local speedsPerDifficulty = 2
	--#endegion EDITABLE

	local difficultiesCount = math.floor(gameHeight / #speeds)

	local blockageId = 2187
	local elevationId = 25602

	local skipGap = 2
	local skipTeleportTile = 1

	---@param pos Position
	local function trySplashPlayers(pos, logSpeed)
		addEvent(function()
			local players = Tile(pos):getCreatures()
			for _, player in ipairs(players) do
				player:addHealth(-0.2 * player:getMaxHealth() + 1)
				pos:sendMagicEffect(CONST_ME_WATERSPLASH)
				player:move(DIRECTION_SOUTH)
			end
		end, logSpeed / 2)
	end

	local function tryUnlockEast(log)
		local blockagePos = log:getPosition():Move(1, 1, -1)
		local blockage = blockagePos:GetItemById(blockageId)
		if blockage then
			blockage:transform(elevationId)
		end
	end
	local function tryLockEast(log, logSpeed)
		local elevationPos = log:getPosition():Move(0, 1, -1)
		local elevation = elevationPos:GetItemById(elevationId)
		if elevation then
			elevation:transform(blockageId)
			trySplashPlayers(elevationPos, logSpeed)
		end
	end
	local function tryUnlockWest(log)
		local blockagePos = log:getPosition():Move(1, 1, -1)
		local blockage = blockagePos:GetItemById(blockageId)
		if blockage then
			blockage:transform(elevationId)
		end
	end
	local function tryLockWest(log, logSpeed)
		local elevationPos = log:getPosition():Move(2, 1, -1)
		local elevation = elevationPos:GetItemById(elevationId)
		if elevation then
			trySplashPlayers(elevationPos, logSpeed)
			elevation:transform(blockageId)
		end
	end

	---@param logStripes MonsterStripe
	local function logMoveEast(logStripes, logSpeed)
		for _, logStripe in ipairs(logStripes) do
			logStripe:Move()
			local westMost = logStripe:GetWestmost()
			local eastMost = logStripe:GetEastmost()
			tryUnlockEast(eastMost)
			tryLockEast(westMost, logSpeed)
		end
	end
	---@param logStripes MonsterStripe
	local function logMoveWest(logStripes, logSpeed)
		for _, logStripe in ipairs(logStripes) do
			logStripe:Move()

			local westMost = logStripe:GetWestmost()
			local eastMost = logStripe:GetEastmost()
			tryUnlockWest(westMost)
			tryLockWest(eastMost, logSpeed)
		end
	end

	local function runPlayersOverWest(pos)
		for _, player in ipairs(pos:GetPlayers()) do
			player:addHealth(-0.4 * player:getMaxHealth() + 1)
		end
		for _, player in ipairs(pos:Moved(1, 0, 0):GetPlayers()) do
			player:addHealth(-0.4 * player:getMaxHealth() + 1)
		end
	end

	local function runPlayersOverEast(pos)
		for _, player in ipairs(pos:GetPlayers()) do
			player:addHealth(-0.4 * player:getMaxHealth() + 1)
		end
		for _, player in ipairs(pos:Moved(-1, 0, 0):GetPlayers()) do
			player:addHealth(-0.4 * player:getMaxHealth() + 1)
		end
	end

	---@param monsterStripes MonsterStripe
	local function damagingMoveWest(monsterStripes)
		for _, monsterStripe in ipairs(monsterStripes) do
			monsterStripe:Move()
			local westMost = monsterStripe:GetWestmost():getPosition()
			runPlayersOverWest(westMost)
		end
	end
	---@param monsterStripes MonsterStripe
	local function damagingLooperEast(monsterStripes)
		for _, monsterStripe in ipairs(monsterStripes) do
			monsterStripe:Move()
			local eastMost = monsterStripe:GetEastmost():getPosition()
			runPlayersOverEast(eastMost)
		end
	end
	local animationNameToDirToCallback = {
		[animationNames.log] = {
			[DIRECTION_EAST] = logMoveEast,
			[DIRECTION_WEST] = logMoveWest,
		},
		[animationNames.horseWagon] = {
			[DIRECTION_EAST] = damagingLooperEast,
			[DIRECTION_WEST] = damagingMoveWest,
		},
		[animationNames.minecart] = {
			[DIRECTION_EAST] = damagingLooperEast,
			[DIRECTION_WEST] = damagingMoveWest,
		},
	}

	local animationToTileFriction = {
		[870] = 100,
		[4809] = 170,
	}

	CrossroadOrchestrator = {}
	CrossroadOrchestrator.__index = CrossroadOrchestrator
	CrossroadOrchestrator.edgePositions = {}
	CrossroadOrchestrator.moveLoopers = {}
	function CrossroadOrchestrator.InitializeCrossroadEdgePositions()
		CrossroadOrchestrator.edgePositions = Zone(scopes.edgePositions:Get()):getPositions()
	end
	function CrossroadOrchestrator.IsMinigameOngoing()
		return CrossroadOrchestrator.isMinigameOngoing
	end
	function CrossroadOrchestrator.SetIsMinigameOngoing(bool)
		CrossroadOrchestrator.isMinigameOngoing = bool
	end
	function CrossroadOrchestrator.InitializeInstanceCreatureTeleport(edgePosition)
		local lastPos = edgePosition:Moved(1, -gameHeight, -1)
		IterateBetweenPositions(edgePosition, lastPos, function(context)
			local currentPos = context.pos
			local westToEastTpPos = currentPos:Moved(skipGap, 0, 0)
			local eastToWestTpPos = currentPos:Moved(skipGap + laneWidth - 1, 0, 0)
			local eastTile = Tile(eastToWestTpPos)
			local westTile = Tile(westToEastTpPos)
			if not (eastTile and westTile) then
				return
			end
			eastTile:getGround():setKey(scopes.teleportEastToWest:Get())
			westTile:getGround():setKey(scopes.teleportWestToEast:Get())
		end)
	end
	function CrossroadOrchestrator.InitializeAllCreatureTeleports()
		for _, edgePosition in ipairs(CrossroadOrchestrator.edgePositions) do
			CrossroadOrchestrator.InitializeInstanceCreatureTeleport(edgePosition)
		end
	end
	function CrossroadOrchestrator.GetMonsterName()
		return scopes.crossroadMonster:Get()
	end
	function CrossroadOrchestrator.MoveLooperName(animationName, dir, speed)
		return Scope(animationName, dir, speed):Get()
	end
	function CrossroadOrchestrator.MoveLooperByName(animationName, dir, speed)
		return CrossroadOrchestrator.moveLoopers[CrossroadOrchestrator.MoveLooperName(animationName, dir, speed)]
	end
	function CrossroadOrchestrator.InitializeMoveLoopers()
		for _, animationName in pairs(animationNames) do
			for _, dir in ipairs({ DIRECTION_EAST, DIRECTION_WEST }) do
				for _, speed in ipairs(speeds) do
					local moveLooper = MoveLooper()
					moveLooper:SetSpeed(speed)
					moveLooper:SetCallback(animationNameToDirToCallback[animationName][dir])
					CrossroadOrchestrator.moveLoopers[CrossroadOrchestrator.MoveLooperName(animationName, dir, speed)] = moveLooper
				end
			end
		end
		return CrossroadOrchestrator
	end

	local function getDifficulty(startY, currentY)
		local distFromStart = math.abs(startY - currentY)
		return math.floor(distFromStart / difficultiesCount) + 1
	end

	local function getTopItemId(pos)
		local tile = Tile(pos)
		if not tile then
			return
		end
		local topItem = tile:getTopTopItem()
		if not topItem then
			return
		end
		local topItemId = topItem:getId()
		return topItemId
	end

	local function getTileFriction(pos)
		local tile = Tile(pos)
		if not tile then
			return
		end
		return animationToTileFriction[tile:getGround():getId()]
	end

	local dirs = { DIRECTION_EAST, DIRECTION_WEST }
	local function randomDir()
		return table.random(dirs)
	end

	function CrossroadOrchestrator.PopulateMoveLooper(edgePosition, currentPos)
		local topItemId = getTopItemId(currentPos)
		local animation = AnimationRegistry:Get(topItemId)
		local tileFriction = getTileFriction(currentPos)

		if not (animation and tileFriction) then
			return
		end

		currentPos:Move(skipGap, 0, 0)

		local difficulty = getDifficulty(edgePosition.y, currentPos.y)

		local randomSpeed = math.random(difficulty, difficulty + speedsPerDifficulty - 1)

		local chosenSpeed = speeds[math.min(randomSpeed, #speeds)]
		local monsterSpeed = chosenSpeed * tileFriction / 100 / 2.7
		local dir = randomDir()
		local reservableLength = laneWidth - 2
		local reservedTilesCount = 0
		local leftmostPosition = currentPos:Moved(skipTeleportTile)
		local moveLooper = CrossroadOrchestrator.MoveLooperByName(animation:GetName(), dir, chosenSpeed)
		while true do
			local centerStripesCount = math.random(1, topItemToMaxStripes[topItemId])
			local randomGapLength = math.random(minGapLength, maxGapLength)

			local newReservedTilesCount = randomGapLength + animation:GetPredictedLength(centerStripesCount)
			if (reservedTilesCount + newReservedTilesCount) > reservableLength then
				break
			end

			local monsterStripe = MonsterStripeFactory.CreateMonsterStripe(animation, leftmostPosition:Moved(reservedTilesCount, 0, 0), monsterSpeed, dir, centerStripesCount)
			moveLooper:AddStripe(monsterStripe)
			reservedTilesCount = reservedTilesCount + newReservedTilesCount
		end
	end

	function CrossroadOrchestrator.PopulateMoveLoopers()
		local edgePosition = CrossroadOrchestrator.chosenEdgePosition
		local lastPos = edgePosition:Moved(1, -gameHeight, -1)
		IterateBetweenPositions(edgePosition, lastPos, function(context)
			CrossroadOrchestrator.PopulateMoveLooper(edgePosition, context.pos)
		end)
		return CrossroadOrchestrator
	end
	function CrossroadOrchestrator.StartMoveLoopers()
		for _, moveLooper in pairs(CrossroadOrchestrator.moveLoopers) do
			moveLooper:Start()
		end
	end

	function CrossroadOrchestrator.StopMoveLoopers()
		for _, moveLooper in pairs(CrossroadOrchestrator.moveLoopers) do
			moveLooper:Stop()
		end
	end
	function CrossroadOrchestrator.FlushMoveLoopersStripes()
		for _, moveLooper in pairs(CrossroadOrchestrator.moveLoopers) do
			moveLooper:FlushStripes()
		end
		return CrossroadOrchestrator
	end
	function CrossroadOrchestrator.BufferPosition()
		return CrossroadOrchestrator.chosenEdgePosition
	end
	function CrossroadOrchestrator.SetEdgePosition(index)
		index = index or math.random(1, #CrossroadOrchestrator.edgePositions)
		CrossroadOrchestrator.chosenEdgePosition = CrossroadOrchestrator.edgePositions[index]
		if not CrossroadOrchestrator.chosenEdgePosition then
			logger.warn(T("[CrossroadOrchestrator.SetEdgePosition] No edge position on index :index:.", { index = index }))
		end
		return CrossroadOrchestrator
	end

	function CrossroadOrchestrator._10MinutesBeforeStart()
		CrossroadOrchestrator.SetEdgePosition()
		CrossroadOrchestrator.PopulateMoveLoopers()
		CrossroadOrchestrator.SetIsMinigameOngoing(true)
		CrossroadOrchestrator.StartMoveLoopers()
	end

	function CrossroadOrchestrator.AfterFinished()
		CrossroadOrchestrator.SetIsMinigameOngoing(false)
		CrossroadOrchestrator.StopMoveLoopers()
		CrossroadOrchestrator.FlushMoveLoopersStripes()
	end

	---@class MonsterStripe
	---@field westSegment table
	---@field eastSegment table
	---@field centerSegments table[]
	---@field dir number
	---@field builtMonsters table
	---@field westmostMonster Monster
	---@field eastmostMonster Monster
	---@field size number
	MonsterStripe = {}
	MonsterStripe.__index = MonsterStripe
	function MonsterStripe.New(...)
		local newObj = {}
		newObj.westSegment = {}
		newObj.eastSegment = {}
		newObj.centerSegments = {}
		newObj.builtMonsters = {}
		newObj.size = 0
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
			self.eastmostMonster = self.eastSegment[1] or self.centerSegments[1]
			for _, monster in ipairs(self.eastSegment) do
				table.insert(self.builtMonsters, monster)
			end
			for _, monster in ipairs(self.centerSegments) do
				table.insert(self.builtMonsters, monster)
			end
			for _, monster in ipairs(self.westSegment) do
				table.insert(self.builtMonsters, monster)
			end
			self.westmostMonster = self.westSegment[#self.westSegment] or self.centerSegments[#self.centerSegments]
		else
			self.westmostMonster = self.westSegment[1] or self.centerSegments[1]
			for _, monster in ipairs(self.westSegment) do
				table.insert(self.builtMonsters, monster)
			end
			for _, monster in ipairs(self.centerSegments) do
				table.insert(self.builtMonsters, monster)
			end
			for _, monster in ipairs(self.eastSegment) do
				table.insert(self.builtMonsters, monster)
			end
			self.eastmostMonster = self.eastSegment[#self.eastSegment] or self.centerSegments[#self.centerSegments]
		end
		self.size = #self.builtMonsters
		self.built = true
		return self
	end
	function MonsterStripe:GetWestmost()
		return self.westmostMonster
	end
	function MonsterStripe:GetEastmost()
		return self.eastmostMonster
	end
	function MonsterStripe:Move()
		local dir = self:GetDirection()
		for _, monster in ipairs(self.builtMonsters) do
			monster:move(dir)
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
	function MonsterStripe:Flush()
		for _, value in ipairs(self.builtMonsters) do
			value:remove()
		end
		self.builtMonsters = {}
		return self
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
		self.registry[topItems[animation:GetName()]] = animation
	end
	function AnimationRegistry:Get(id)
		return self.registry[id]
	end
	---@class Animation
	---@field name number required
	---@field westStripes AnimationStripe
	---@field eastStripes AnimationStripe
	---@field centerStripes AnimationStripe
	---@field isOneHeaded bool required
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
	function Animation:GetPredictedLength(centerStripesCount)
		local length = 0
		if self:IsOneHeaded() then
			length = length + self:GetRandomWestStripe():GetSize()
		else
			length = length + self:GetRandomWestStripe():GetSize() * 2
		end
		length = length + self:GetRandomCenterStripe():GetSize() * centerStripesCount
		return length
	end
	function Animation:GetName()
		return self.name
	end
	---@param ... AnimationStripe[]
	function Animation:AddWestStripes(...)
		for _, animationStripe in ipairs({ ... }) do
			table.insert(self.westStripes, animationStripe)
		end
	end
	---@param ... AnimationStripe[]
	function Animation:AddEastStripes(...)
		for _, animationStripe in ipairs({ ... }) do
			table.insert(self.eastStripes, animationStripe)
		end
	end
	---@param ... AnimationStripe[]
	function Animation:AddCenterStripes(...)
		for _, animationStripe in ipairs({ ... }) do
			table.insert(self.centerStripes, animationStripe)
		end
	end
	function Animation:SetIsOneHeaded(isOneHeaded)
		self.isOneHeaded = isOneHeaded
		return self
	end
	function Animation:IsOneHeaded()
		return self.isOneHeaded
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
		for _, textureId in ipairs({ ... }) do
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

	local monsterName = CrossroadOrchestrator.GetMonsterName()
	local function createMonsterBuffered(pos)
		local bufferPos = CrossroadOrchestrator.BufferPosition()
		local monster = Game.createMonster(monsterName, bufferPos)
		monster:teleportTo(pos)
		return monster
	end

	function MonsterStripeFactory.CreateStripeSegments(animation, leftmostPosition, speed, centerSegmentsCount, dir)
		local reservedTiles = 0
		local oneHeaded = animation:IsOneHeaded()

		local westSegment = {}
		if dir == DIRECTION_WEST or not oneHeaded then
			local westAnimationStripe = animation:GetRandomWestStripe()
			for _, id in ipairs(westAnimationStripe:Get()) do
				local monster = createMonsterBuffered(leftmostPosition:Moved(reservedTiles, 0, 0))
				if westAnimationStripe:IsLookTypeEx() then
					monster:setOutfit({ lookTypeEx = id })
				else
					monster:setOutfit({ lookType = id })
				end
				monster:setSpeed(speed)
				table.insert(westSegment, monster)
				reservedTiles = reservedTiles + 1
			end
		end
		local centerSegments = {}
		for _ = 1, centerSegmentsCount do
			local centerAnimationStripe = animation:GetRandomCenterStripe()
			for _, id in ipairs(centerAnimationStripe:Get()) do
				local monster = createMonsterBuffered(leftmostPosition:Moved(reservedTiles, 0, 0))
				if centerAnimationStripe:IsLookTypeEx() then
					monster:setOutfit({ lookTypeEx = id })
				else
					monster:setOutfit({ lookType = id })
				end
				monster:setSpeed(speed)
				table.insert(centerSegments, monster)
				reservedTiles = reservedTiles + 1
			end
		end
		local eastSegment = {}
		if dir == DIRECTION_EAST or not oneHeaded then
			local eastAnimationStripe = animation:GetRandomEastStripe()
			for _, id in ipairs(eastAnimationStripe:Get()) do
				local monster = createMonsterBuffered(leftmostPosition:Moved(reservedTiles, 0, 0))
				if eastAnimationStripe:IsLookTypeEx() then
					monster:setOutfit({ lookTypeEx = id })
				else
					monster:setOutfit({ lookType = id })
				end
				monster:setSpeed(speed)
				table.insert(eastSegment, monster)
				reservedTiles = reservedTiles + 1
			end
		end
		return westSegment, centerSegments, eastSegment
	end
	---@return MonsterStripe monsterStripe
	function MonsterStripeFactory.CreateMonsterStripe(animation, leftmostPosition, speed, dir, centerStripesCount)
		local monsterStripe = MonsterStripe()
		monsterStripe:SetDirection(dir)

		local westSegment, centerSegments, eastSegment = MonsterStripeFactory.CreateStripeSegments(animation, leftmostPosition, speed, centerStripesCount, dir)
		local oneHeaded = animation:IsOneHeaded()
		if not oneHeaded or dir == DIRECTION_WEST then
			monsterStripe:SetWestSegment(westSegment)
		end
		if not oneHeaded or dir == DIRECTION_EAST then
			monsterStripe:SetEastSegment(eastSegment)
		end
		for _, centerSegment in ipairs(centerSegments) do
			monsterStripe:AddCenterSegment(centerSegment)
		end
		monsterStripe:Build()
		return monsterStripe
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

	MoveLooper = {}
	MoveLooper.__index = MoveLooper
	function MoveLooper.New(...)
		local newObj = {}
		newObj.stripes = {}
		setmetatable(newObj, MoveLooper)
		return newObj
	end
	setmetatable(MoveLooper, {
		__call = function(_, ...)
			return MoveLooper.New(...)
		end,
	})
	function MoveLooper:SetCallback(callback)
		self.callback = callback
		return self
	end
	function MoveLooper:SetContext(context)
		self.context = context
		return self
	end
	function MoveLooper:Start()
		self.event = addEvent(function(callback, stripes)
			callback(stripes, self.delay)
			self:Start()
		end, self.delay, self.callback, self.stripes)
		return self
	end
	function MoveLooper:Stop()
		stopEvent(self.event)
		return self
	end
	function MoveLooper:UpdateDelay()
		local speed = self:GetSpeed()
		self.delay = 100 / speed * 1000
		return self
	end
	function MoveLooper:SetTileFriction(tileFriction)
		self.tileFriction = tileFriction
		return self
	end
	function MoveLooper:SetSpeed(speed)
		self.speed = speed
		self:UpdateDelay()
		return self
	end
	function MoveLooper:GetSpeed()
		return self.speed
	end
	function MoveLooper:SetLooper(looper)
		self.looper = looper
		return self
	end
	function MoveLooper:AddStripe(stripe)
		table.insert(self.stripes, stripe)
		return self
	end
	function MoveLooper:FlushStripes()
		for _, monsterStripe in ipairs(self.stripes) do
			monsterStripe:Flush()
		end
		self.stripes = {}
		return self
	end

	local crossroadStart = TalkAction("!cross_start")
	function crossroadStart.onSay(player, words, param)
		CrossroadOrchestrator._10MinutesBeforeStart()
		return false
	end
	crossroadStart:separator(" ")
	crossroadStart:groupType("tutor")
	crossroadStart:register()

	local crossroadStop = TalkAction("!cross_stop")
	function crossroadStop.onSay(player, words, param)
		CrossroadOrchestrator.AfterFinished()
	end
	crossroadStop:separator(" ")
	crossroadStop:groupType("tutor")
	crossroadStop:register()

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

	local function generateMonsterDefinition()
		local mType = Game.createMonsterType(CrossroadOrchestrator.GetMonsterName())
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
		monster.speed = 100
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

	local initializeCrossroad = GlobalEvent(scopes.initializeCrossroad:Get())
	function initializeCrossroad.onStartup()
		generateMonsterDefinition()
		CrossroadOrchestrator.InitializeCrossroadEdgePositions()
		CrossroadOrchestrator.InitializeAllCreatureTeleports()
		CrossroadOrchestrator.InitializeMoveLoopers()
	end
	initializeCrossroad:register()
end)
:Register()