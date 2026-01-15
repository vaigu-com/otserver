local mType = Game.createMonsterType("Damage Test")
local monster = {}

monster.description = "a damage test"
monster.experience = 0
monster.outfit = {
	lookTypeEx = 5787,
}

monster.health = 1000000
monster.maxHealth = monster.health
monster.race = "undead"
monster.corpse = 0
monster.speed = 0

monster.changeTarget = {
	interval = 1000,
	chance = 100,
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 0,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.events = {
	"DamageTestHeal",
}

monster.summons = {}

--[[monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "I hope you are enjoying your sparring Sir or Ma'am!", yell = false },
	{ text = "Threat level rising!", yell = false },
	{ text = "Engaging in hostile interaction!", yell = false },
	{ text = "Rrrtttarrrttarrrtta", yell = false },
	{ text = "Please feel free to hit me Sir or Ma'am!", yell = false },
	{ text = "klonk klonk klonk", yell = false },
	{ text = "Self-diagnosis running.", yell = false },
	{ text = "Battle simulation proceeding.", yell = false },
	{ text = "Repairs initiated!", yell = false },
}]]

monster.loot = {}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = -1, maxDamage = -2, attack = 10 },
	{ name = "melee", interval = 1000, chance = 100, minDamage = -1, maxDamage = -2, attack = 10 },
}

monster.defenses = {
	defense = 0,
	armor = 0,
	{ name = "combat", type = COMBAT_HEALING, chance = 15, interval = 4000, minDamage = 100, maxDamage = 230, effect = CONST_ME_MAGIC_BLUE },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent  = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent  = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent  = 0 },
	{ type = COMBAT_FIREDAMAGE, percent  = 0 },
	{ type = COMBAT_LIFEDRAIN, percent  = 0 },
	{ type = COMBAT_MANADRAIN, percent  = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent  = 0 },
	{ type = COMBAT_ICEDAMAGE, percent  = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent  = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent  = 0 },
}

monster.immunities = {}

mType:register(monster)

local trainingDummyHeal = CreatureEvent("DamageTestHeal")
function trainingDummyHeal.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if (creature:getHealth() / creature:getMaxHealth()) < 0.35 then
		creature:addHealth(creature:getMaxHealth())
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end
trainingDummyHeal:register()
