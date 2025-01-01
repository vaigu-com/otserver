--40f
local mType = Game.createMonsterType("FakeMonsterTest")
local monster = {}

monster.description = "a stone"
monster.experience = 0
monster.outfit = { lookTypeEx = 1150, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

monster.health = 500
monster.maxHealth = 500
monster.race = "undead"
monster.speed = 10
monster.manaCost = 0

monster.changeTarget = { interval = 3717, chance = 10 }

monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = false,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 20,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = true,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = { level = 0, color = 0 }

monster.voices = { interval = 4999, chance = 10 }

monster.loot = {}

monster.attacks = {}

monster.defenses = { defense = 25, armor = 25 }

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
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

local function isShout(message)
	if #message < 5 then
		return false
	end
	if message ~= message:upper() then
		return false
	end
	return true
end

SpawnLocks.Steppes = {
	TestNpc = SpawnLock(),
}

local npcLock = SpawnLocks.Steppes.TestNpc

local hammock1
local hammock2
npcLock:Context({
	onSet = function()
		hammock1:transform(2503)
		hammock2:transform(2504)
	end,
	onReset = function()
		hammock1:transform(2507)
		hammock2:transform(2508)
	end,
})

local fakeMonsterStartup = GlobalEvent("FakeMonsterTestStartup")
function fakeMonsterStartup.onStartup()
	hammock1 = Tile(6238, 1027, 5):getItemById(2507)
	hammock2 = Tile(6238, 1028, 5):getItemById(2508)
	Game.createMonster("FakeMonsterTest", Position(6239, 1025, 5))
	return true
end
fakeMonsterStartup:register()

mType.onSay = function(listener, talker, type, message)
	if not isShout(message) then
		return
	end

	if npcLock:IsSet() then
		return
	end

	local npc = Game.createNpc("Test Npc", Position(6237, 1027, 5))
	npcLock:Set(npc)
end

mType.onAppear = function(monster, creature) end
mType:register(monster)
