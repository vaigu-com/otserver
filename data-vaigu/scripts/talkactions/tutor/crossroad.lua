--TODO factor might be nonliear
local cobbledSpeedFactor = 1.5
local disappearAtMovesCount = 30
local function teleportToLoopCart(monster, delayBetweenMoving, dir, movesCount)
	addEvent(function()
		monster:move(dir)
		if movesCount >= disappearAtMovesCount then
			monster:remove()
			return
		end
		teleportToLoopCart(monster, delayBetweenMoving, dir, movesCount + 1)
	end, delayBetweenMoving)
end

local blockageId = 2187
local elevationId = 25602
local function tryUnlock(log)
	local blockagePos = log.first:getPosition():Move(0, 1, -1)
	blockagePos:sendMagicEffect(CONST_ME_STUN)

	local blockage = blockagePos:GetItemById(blockageId)
	if blockage then
		blockage:transform(elevationId)
	end
end
local function splashPlayers(pos)
	local players = Tile(pos):getCreatures()
	local penatlyPos = pos:Move(0, 1, 0)
	for _, player in pairs(players) do
		player:addHealth(-0.2 * player:getMaxHealth() + 1)
		player:teleportTo(penatlyPos)
	end
	pos:sendMagicEffect(CONST_ME_WATERSPLASH)
end
local function tryLock(log)
	local elevationPos = log.last:getPosition():Move(-1, 1, -1)
	elevationPos:sendMagicEffect(CONST_ME_POFF)
	local elevation = elevationPos:GetItemById(elevationId)
	if elevation then
		elevation:transform(blockageId)
		splashPlayers(elevationPos)
	end
end

local function teleportToLoopLog(log, delayBetweenMoving, dir, movesCount)
	addEvent(function()
		for _, part in pairs(log.parts) do
			part:move(dir)
		end
		if movesCount >= disappearAtMovesCount then
			for _, value in pairs(log.parts) do
				value:remove()
			end
			return
		end
		tryUnlock(log)
		tryLock(log)
		teleportToLoopLog(log, delayBetweenMoving, dir, movesCount + 1)
	end, delayBetweenMoving)
end

local bufferPos = Position(6012, 2364, 7)

local westId = 3922
local centerId = 3923
local eastId = 3929
local function generateLogMovingEast(length, endPos, speed)
	local log = { parts = {} }

	local east = Game.createMonster(CROSSROAD_MONSTER_BASE.DAMAGING.ANY, endPos:Moved(length, 0, 0), false, true)
	east:setOutfit({ lookTypeEx = eastId })
	table.insert(log.parts, east)
	for i = length - 1, 2, -1 do
		local part = Game.createMonster(CROSSROAD_MONSTER_BASE.DAMAGING.ANY, endPos:Moved(i, 0, 0), false, true)
		part:setOutfit({ lookTypeEx = centerId })
		table.insert(log.parts, part)
	end
	local west = Game.createMonster(CROSSROAD_MONSTER_BASE.DAMAGING.ANY, endPos:Moved(1, 0, 0), false, true)
	west:setOutfit({ lookTypeEx = westId })
	table.insert(log.parts, west)

	for _, part in pairs(log.parts) do
		part:changeSpeed(speed)
	end
	log.first = east
	log.last = west
	return log
end

local function logSpawner(position, dir, speed)
	local logSegments = math.random(2, 8)

	--local speed = 150 + math.random(-5, 5) * 10

	local delayBetweenMoving = 100 / (speed * cobbledSpeedFactor) * 1000
	local log = generateLogMovingEast(logSegments, position:Moved(8 - logSegments, 0, 0), speed)
	teleportToLoopLog(log, delayBetweenMoving, dir, 1)

	--TODO
	--lower to 2? later
	-- nextLog^2 may be good too?
	local tillNextSpawn = logSegments * speed
	addEvent(logSpawner, 80 * tillNextSpawn, position, dir, speed)
end

local function cartSpawner(position, dir, speed)

	--local speed = 150 + math.random(-5, 5) * 10

	local delayBetweenMoving = 100 / (speed * cobbledSpeedFactor) * 1000
	local cart = Game.createMonster(CROSSROAD_MONSTER_BASE.DAMAGING.ANY, bufferPos, false, true)
	cart:teleportTo(position)
	cart:setOutfit({ lookTypeEx = 7131 })
	cart:changeSpeed(speed)
	teleportToLoopCart(cart, delayBetweenMoving, dir, 1)

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

local pos1Log = Position(5993, 2355, 7)
local pos2 = Position(5998, 2360, 6)
local pos3 = Position(5998, 2361, 6)
local talkactionLog = TalkAction("!cross_log1")
function talkactionLog.onSay(player, words, param)
	local speed = 40
	logSpawner(pos1Log, DIRECTION_EAST, speed)
	--spawnLogLoop(pos2, DIRECTION_WEST, speed + 5)
	--spawnLogLoop(pos3, DIRECTION_EAST, speed)
	return false
end
talkactionLog:separator(" ")
talkactionLog:groupType("tutor")
talkactionLog:register()

local crossroadMonsterDamagingScope = Scope("Crossroad", "Monster", "Damaging")
CROSSROAD_MONSTER_BASE = {
	DAMAGING = {
		ANY = crossroadMonsterDamagingScope:Get("Slow"),
	},
}

local mType = Game.createMonsterType(CROSSROAD_MONSTER_BASE.DAMAGING.ANY)
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
monster.speed = 1
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
