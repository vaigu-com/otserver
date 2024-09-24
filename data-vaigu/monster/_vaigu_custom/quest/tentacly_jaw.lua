local mType = Game.createMonsterType("Tentacly Jaw")
local monster = {}

monster.description = "a Tentacly Jaw"
monster.experience = 0
monster.outfit = {
	lookType = 305,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 500
monster.maxHealth = 500
monster.race = "undead"
monster.speed = 10
monster.manaCost = 0

monster.changeTarget = { interval = 4000, chance = 10 }

monster.strategiesTarget = { random = 100 }

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

local insidePos = USHAYAAN_FORGE_ANCHOR:Moved(0, 18, -1)
local outsidePos = USHAYAAN_FORGE_ANCHOR:Moved(0, 20, -1)

local function isPlayerOnTeleportableTile(playerPos)
	return playerPos == insidePos or playerPos == outsidePos
end

mType.onSay = function(listener, talker, type, message)
	if message:lower() == "ali baba" then
		local listenerPos = listener:getPosition()
		local talkerPos = talker:getPosition()

		if not isPlayerOnTeleportableTile(talkerPos) then
			return
		end

		if talkerPos.y < listenerPos.y then
			talker:teleportTo(outsidePos)
			outsidePos:sendMagicEffect(CONST_ME_TELEPORT)
		elseif talkerPos.y > listenerPos.y then
			talker:teleportTo(insidePos)
			insidePos:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
end

mType.onAppear = function(monster, creature)
	-- ToDo: change to correct sprite
	monster:setOutfit({ lookTypeEx = 470 })
end
mType:register(monster)
