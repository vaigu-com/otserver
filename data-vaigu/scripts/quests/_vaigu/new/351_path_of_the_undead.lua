local quest = Quest(LOCALIZERS.PathOfTheUndead)

quest
	:Storage(function()
		Storage.PathOfTheUndead = {
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Circles = NextStorage(),
			KonmuldBush = NextStorage(),
			UpperLever = NextStorage(),
			CursedChest = NextStorage(),
			GuardianSkull = NextStorage(),
			GuardianGateTile = NextStorage(),
			RitualLocus = NextStorage(),
			BossBook = NextStorage(),
			BossRoomExit = NextStorage(),
			SkipDoor = NextStorage(),
			GrantSkipDoorAccess = NextStorage(),
		}
		QuestState.PathOfTheUndead = {
			Mission01 = {
				ConsultGandalf = 1,
			},
			Mission02 = {
				VisitMagicalCircles = 1,
			},
			Mission03 = {
				DefeatUndeadKing = 1,
				ReturnToGandalf = 2,
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Path of the Undead",
			missions = {
				[Storage.PathOfTheUndead.Mission01] = {
					name = "Test of Strength",
					states = {
						[QuestState.PathOfTheUndead.Mission01.ConsultGandalf] = "Gandalf told you about the history of Mirkotown. Now, ask him what conditions you need to fulfill to get his help.",
						[MISSION_FINISHED] = "Gandalf promised to bless your cause, but first, you must visit special magical circles.",
					},
				},
				[Storage.PathOfTheUndead.Mission02] = {
					name = "Endurance Test",
					states = {
						[QuestState.PathOfTheUndead.Mission02.VisitMagicalCircles] = "Gandalf promised to bless your cause, but first, you must visit special magical circles.",
						[MISSION_FINISHED] = "Gandalf has blessed you and advised you to go to Konmuld for further instructions.",
					},
				},
				[Storage.PathOfTheUndead.Mission03] = {
					name = "The Final Battle",
					states = {
						[QuestState.PathOfTheUndead.Mission03.DefeatUndeadKing] = "Gather the necessary items, summon, and ultimately defeat the Undead Crypt King.",
						[QuestState.PathOfTheUndead.Mission03.ReturnToGandalf] = "You have defeated the Undead Crypt King. Return to Gandalf for your reward.",
						[MISSION_FINISHED] = "Gandalf misplaced a certain item intended as a reward, but you have received his other gifts.",
					},
				},
			},
		}
	end)
	:Constant(function()
		GUARDIAN_SKULLS_APPEAR_SPOTS_POOL = {
			["Cipociamkacz"] = { x = -12, y = 15, z = 1 },
			["PatriotaPL"] = { x = -11, y = 15, z = 1 },
			["CalaNapszut"] = { x = -10, y = 15, z = 1 },
		}
	end)
	:Monster(function()
		local mType = Game.createMonsterType("CalaNapszut")
		local monster = {}

		monster.description = "a CalaNapszut"
		monster.experience = 5600
		monster.outfit = {
			lookType = 351,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 9500
		monster.maxHealth = 9500
		monster.race = "undead"
		monster.corpse = 10445
		monster.speed = 160
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 5,
		}

		monster.strategiesTarget = {
			nearest = 70,
			health = 10,
			damage = 10,
			random = 10,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 70,
			targetDistance = 1,
			runHealth = 366,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.events = {
			"CalaNapszutDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
			{ text = "EMBRACE MY GIFTS!", yell = true },
		}

		monster.loot = {
			{ id = 10449, chance = 10000 },
			{ id = 3031, chance = 10000, maxCount = 230 },
			{ id = 3035, chance = 10000, maxCount = 15 },
			{ id = 10450, chance = 10000 },
			{ id = 6499, chance = 9700 },
			{ id = 281, chance = 4500 },
			{ id = 282, chance = 4500 },
			{ id = 9057, chance = 9700, maxCount = 10 },
			{ id = 10406, chance = 7600 },
			{ id = 7643, chance = 6000 },
			{ id = 10310, chance = 4500 },
			{ id = 10451, chance = 3700 },
			{ id = 239, chance = 3400, maxCount = 3 },
			{ id = 10386, chance = 3000 },
			{ id = 238, chance = 2600, maxCount = 3 },
			{ id = 7642, chance = 2600, maxCount = 3 },
			{ id = 10438, chance = 2100 },
			{ id = 10387, chance = 1500 },
			{ id = 10384, chance = 1300 },
			{ id = 10385, chance = 1300 },
			{ id = 10389, chance = 1000 },
			{ id = 10388, chance = 870 },
			{ id = 12801, chance = 217 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, skill = 80, attack = 100 },
			{ name = "combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -80, maxDamage = -230, range = 7, effect = CONST_ME_MAGIC_RED, target = true },
			-- poison
			{ name = "condition", type = CONDITION_POISON, interval = 2000, chance = 10, minDamage = -920, maxDamage = -1260, range = 7, shootEffect = CONST_ANI_DEATH, effect = CONST_ME_SMALLCLOUDS, target = false },
			{ name = "combat", interval = 2000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -90, maxDamage = -350, range = 7, effect = CONST_ME_MAGIC_RED, target = true },
			{ name = "combat", interval = 2000, chance = 13, type = COMBAT_DEATHDAMAGE, minDamage = -70, maxDamage = -180, radius = 4, effect = CONST_ME_MORTAREA, target = false },
		}

		monster.defenses = {
			defense = 35,
			armor = 45,
			{ name = "combat", interval = 2000, chance = 9, type = COMBAT_HEALING, minDamage = 70, maxDamage = 300, effect = CONST_ME_MAGIC_GREEN, target = false },
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = -10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 10 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 50 },
			{ type = COMBAT_HOLYDAMAGE, percent = -15 },
			{ type = COMBAT_DEATHDAMAGE, percent = 100 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Cipociamkacz")
		local monster = {}

		monster.description = "a Cipociamkacz"
		monster.experience = 6500
		monster.outfit = {
			lookType = 231,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 6500
		monster.maxHealth = 6500
		monster.race = "undead"
		monster.corpse = 6305
		monster.speed = 140
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 70,
			health = 10,
			damage = 10,
			random = 10,
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
			staticAttackChance = 70,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = true,
		}

		monster.events = {
			"CipociamkaczDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
		}

		monster.loot = {
			{ name = "black pearl", chance = 22780, maxCount = 2 },
			{ name = "small sapphire", chance = 28370, maxCount = 2 },
			{ name = "gold coin", chance = 355000, maxCount = 10 },
			{ name = "gold coin", chance = 55500, maxCount = 98 },
			{ name = "platinum coin", chance = 52000, maxCount = 5 },
			{ name = "life crystal", chance = 2500 },
			{ name = "hardened bone", chance = 14180 },
			{ id = 6299, chance = 1150 },
			{ name = "demonic essence", chance = 12460 },
			{ name = "assassin star", chance = 26650, maxCount = 5 },
			{ name = "dragon slayer", chance = 860 },
			{ name = "dragonbone staff", chance = 4000 },
			{ name = "great mana potion", chance = 21490 },
			{ name = "great health potion", chance = 21200 },
			{ name = "skullcracker armor", chance = 290 },
			{ name = "gold ingot", chance = 570 },
			{ name = "unholy bone", chance = 33380 },
			{ name = "spellweaver's robe", chance = 860 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -480 },
			{ name = "combat", interval = 2000, chance = 5, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -400, range = 7, radius = 4, effect = CONST_ME_HITAREA, target = true },
			{ name = "combat", interval = 2000, chance = 10, type = COMBAT_DEATHDAMAGE, minDamage = -125, maxDamage = -600, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = false },
			{ name = "combat", interval = 2000, chance = 5, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -390, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
			{ name = "combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = 0, maxDamage = -180, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true },
			{ name = "combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -150, maxDamage = -690, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false },
			{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -700, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
			{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -200, radius = 3, effect = CONST_ME_MAGIC_RED, target = false },
			{ name = "undead dragon curse", interval = 2000, chance = 10, target = false },
		}

		monster.defenses = {
			defense = 40,
			armor = 40,
			{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 200, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 5 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 100 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 100 },
			{ type = COMBAT_ICEDAMAGE, percent = 50 },
			{ type = COMBAT_HOLYDAMAGE, percent = -25 },
			{ type = COMBAT_DEATHDAMAGE, percent = 100 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("PatriotaPL")
		local monster = {}

		monster.description = "a PatriotaPL"
		monster.experience = 21000
		monster.outfit = {
			lookType = 1077,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 9000
		monster.maxHealth = 9000
		monster.race = "fire"
		monster.corpse = 28639
		monster.speed = 115
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 0,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = true,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"PatriotaPLDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
		}

		monster.loot = {
			{ id = 9058, chance = 50000, maxCount = 4 },
			{ id = 7741, chance = 5560 },
			{ id = 7377, chance = 5560 },
			{ id = 14112, chance = 50 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -300 },
			{ name = "ice crystal bomb", interval = 2000, chance = 30, minDamage = -600, maxDamage = -700, target = true },
			{ name = "fire wave", interval = 2000, chance = 30, minDamage = -800, maxDamage = -1200, length = 1, spread = 1, effect = CONST_ME_FIREAREA, target = true },
			{ name = "speed", interval = 1000, chance = 12, speedChange = -250, radius = 6, effect = CONST_ME_HITBYFIRE, target = false, duration = 60000 },
			{ name = "firefield", interval = 1000, chance = 10, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, target = true },
		}

		monster.defenses = {
			defense = 40,
			armor = 80,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 100 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 40 },
			{ type = COMBAT_HOLYDAMAGE, percent = 50 },
			{ type = COMBAT_DEATHDAMAGE, percent = 50 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType.onThink = function(monster, interval) end

		mType.onAppear = function(monster, creature) end

		mType.onDisappear = function(monster, creature) end

		mType.onMove = function(monster, creature, fromPosition, toPosition) end

		mType.onSay = function(monster, creature, type, message) end

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Undead Crypt King")
		local monster = {}

		monster.description = "Undead Crypt King"
		monster.experience = 500000
		monster.outfit = {
			lookType = 12,
			lookHead = 1,
			lookBody = 95,
			lookLegs = 90,
			lookFeet = 90,
			lookAddons = 3,
			lookMount = 0,
		}

		monster.health = 60000
		monster.maxHealth = 60000
		monster.race = "undead"
		monster.corpse = 6068
		monster.speed = 300
		monster.manaCost = 0

		monster.changeTarget = {}

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
			illusionable = false,
			canPushItems = true,
			canPushCreatures = false,
			staticAttackChance = 80,
			targetDistance = 1,
			runHealth = 300,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"UndeadCryptKingDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
			{ text = "GRRR", yell = true },
			{ text = "GRROARR", yell = true },
		}

		monster.loot = {
			{ id = 3025, chance = 13500 }, -- ancient amulet
			{ id = 3116, chance = 19000 }, -- big bone
			{ name = "black pearl", chance = 15000, maxCount = 35 },
			{ name = "boots of haste", chance = 14000 },
			{ id = 3076, chance = 22500 }, -- crystal ball
			{ name = "crystal necklace", chance = 21500 },
			{ id = 3007, chance = 15500 }, -- crystal ring
			{ name = "demon shield", chance = 15500 },
			{ name = "devil helmet", chance = 11000 },
			{ name = "dragon hammer", chance = 34500 },
			{ id = 3051, chance = 13500 }, -- energy ring
			{ name = "fire axe", chance = 17000 },
			{ name = "giant sword", chance = 12500 },
			{ name = "platinum coin", chance = 69900, maxCount = 100 },
			{ name = "platinum coin", chance = 68800, maxCount = 100 },
			{ name = "crystal coin", chance = 100000, maxCount = 85 },
			{ name = "gold ring", chance = 28000 },
			{ name = "golden legs", chance = 15000 },
			{ name = "giant ruby", chance = 31500 },
			{ name = "giant sapphire", chance = 31500 },
			{ name = "giant emerald", chance = 31500 },
			{ name = "ice rapier", chance = 27500 },
			{ name = "magic plate armor", chance = 13000 },
			{ name = "mastermind shield", chance = 17500 },
			{ name = "purple tome", chance = 12600 },
			{ name = "ring of the sky", chance = 13500 },
			{ name = "silver dagger", chance = 15500 },
			{ name = "skull staff", chance = 25000 },
			{ name = "talon", chance = 14000, maxCount = 27 },
			{ name = "teddy bear", chance = 10500 },
			{ name = "thunder hammer", chance = 3500 },
			{ id = 3002, chance = 5100 }, -- voodoo doll
			{ name = "white pearl", chance = 12500, maxCount = 35 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -350 },
			{ name = "undead crypt king anti tank stacks", interval = 1000, chance = 1000, range = 7, target = true },
			{
				name = "undead crypt king death lasers",
				interval = 8000,
				chance = 100,
				target = false,
				range = 7,
			},
			{
				name = "undead crypt king soak bomb",
				interval = 15000,
				chance = 100,
				minDamage = 0,
				maxDamage = 0,
				target = false,
			},
			{
				name = "undead crypt king summon laga dyga",
				interval = 8000,
				chance = 100,
				minDamage = 0,
				maxDamage = 0,
				target = false,
			},
		}

		monster.defenses = {
			defense = 40,
			armor = 40,
			{
				name = "combat",
				interval = 2000,
				chance = 15,
				type = COMBAT_HEALING,
				minDamage = 120,
				maxDamage = 225,
				effect = CONST_ME_MAGIC_GREEN,
				target = false,
			},
			{
				name = "speed",
				interval = 2000,
				chance = 15,
				speedChange = 400,
				range = 7,
				effect = CONST_ME_SOUND_PURPLE,
				target = false,
				duration = 5000,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 5 },
			{ type = COMBAT_EARTHDAMAGE, percent = 65 },
			{ type = COMBAT_FIREDAMAGE, percent = -5 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = -5 },
			{ type = COMBAT_HOLYDAMAGE, percent = -5 },
			{ type = COMBAT_DEATHDAMAGE, percent = 50 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Laga Dyga")
		local monster = {}

		monster.description = "a skeleton"
		monster.experience = 35
		monster.outfit = {
			lookType = 33,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 1000
		monster.maxHealth = 1000
		monster.race = "undead"
		monster.corpse = 5972
		monster.speed = 150
		monster.manaCost = 300

		monster.changeTarget = { interval = 4000, chance = 100 }

		monster.strategiesTarget = { random = 100, nearest = 0 }

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = true,
			canPushItems = false,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.events = {
			"LagaDygaDeath",
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = { interval = 5000, chance = 10 }

		monster.loot = {}

		monster.attacks = {
			{
				name = "melee",
				interval = 2000,
				chance = 100,
				minDamage = 0,
				maxDamage = -20,
			},
			{
				name = "combat",
				interval = 2000,
				chance = 100,
				type = COMBAT_LIFEDRAIN,
				minDamage = -7,
				maxDamage = -13,
				range = 1,
				target = false,
			},
			{
				name = "berserk",
				interval = 2000,
				chance = 10,
				minDamage = 0,
				maxDamage = -100,
				range = 1,
				target = false,
			},
		}

		monster.defenses = { defense = 10, armor = 10 }

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 100 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = -5 },
			{ type = COMBAT_DEATHDAMAGE, percent = 100 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = false },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("CalaNapszutDeath")

		function guardian.onDeath(creature)
			local pos = PATH_OF_THE_UNDEAD_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["CalaNapszut"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("CipociamkaczDeath")

		function guardian.onDeath(creature)
			local pos = PATH_OF_THE_UNDEAD_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["Cipociamkacz"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:MonsterEvent(function()
		local kingDeath = CreatureEvent("UndeadCryptKingDeath")

		function kingDeath.onDeath(creature)
			local targetMonster = creature:getMonster()
			if not targetMonster or targetMonster:getMaster() then
				return true
			end

			local pos = targetMonster:getPosition()
			local portal = Game.createItem(27590, 1, pos)
			portal:setActionId(Storage.PathOfTheUndead.BossRoomExit)
		end

		kingDeath:register()
	end)
	:MonsterEvent(function()
		local guardian = CreatureEvent("PatriotaPLDeath")

		function guardian.onDeath(creature)
			local pos = PATH_OF_THE_UNDEAD_ANCHOR:Moved(GUARDIAN_SKULLS_APPEAR_SPOTS_POOL["PatriotaPL"])
			Game.createItem(11965, 1, pos)
		end

		guardian:register()
	end)
	:MonsterEvent(function()
		local smallArea = createCombatArea(AREA_PLUS3)
		local plusShape = Combat()
		plusShape:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		plusShape:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
		plusShape:setArea(smallArea)
		plusShape:setFormula(COMBAT_FORMULA_DAMAGE, -1500, 0, -1500, 0)

		local lagaDygadeath = CreatureEvent("LagaDygaDeath")
		function lagaDygadeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			doCombat(creature, plusShape, { type = 2, pos = creature:getPosition() })
			return true
		end

		lagaDygadeath:register()
	end)
	:MonsterEvent(function()
		local textCharging = "I shall zap you with my beam-inator!"

		local smallLaser = Combat()
		smallLaser:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		smallLaser:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
		local smallArea = createCombatArea(AREA_SIDEBEAMS1)
		smallLaser:setArea(smallArea)
		smallLaser:setFormula(COMBAT_FORMULA_DAMAGE, -300, 0, -300, 0)

		local bigLaser = Combat()
		bigLaser:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		bigLaser:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
		local bigArea = createCombatArea(AREA_SIDEBEAMS2)
		bigLaser:setArea(bigArea)
		bigLaser:setFormula(COMBAT_FORMULA_DAMAGE, -300, 0, -300, 0)

		local spell = Spell("instant")

		function spell.onCastSpell(creature, var)
			local hpPercentage = creature:getHealth() / creature:getMaxHealth()

			local laserSize = nil
			if hpPercentage >= 0.5 then
				laserSize = smallLaser
			else
				laserSize = bigLaser
			end

			creature:say(textCharging, TALKTYPE_MONSTER_SAY)
			local timer = 1500
			local interval = 180

			for _ = 1, 7 do
				addEvent(function()
					doCombat(creature, laserSize, var)
				end, timer)
				timer = timer + interval
			end
			return true
		end

		spell:name("undead crypt king death lasers")
		spell:words(NextSpellId())
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(true)
		spell:needDirection(true)
		spell:register()
	end)
	:MonsterEvent(function()
		local config = { lastTargetId = 0, stacks = 0, damagePerStack = -30, baseDamage = 100 }

		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
		combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

		function onGetFormulaValues(creature, target)
			local targetId = target:getId()
			if targetId ~= config.lastTargetId then
				config.lastTargetId = targetId
				config.stacks = 0
			end

			local damage = math.floor(config.damagePerStack * config.stacks) + config.baseDamage
			if not target:isPlayer() then
				damage = damage * 20
			end
			doTargetCombatHealth(0, target, COMBAT_ENERGYDAMAGE, damage, damage, CONST_ME_NONE)

			config.stacks = config.stacks + 1
			return true
		end

		combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValues")

		local spell = Spell("instant")
		function spell.onCastSpell(creature, var, isHotkey)
			return combat:execute(creature, var)
		end

		spell:name("undead crypt king anti tank stacks")
		spell:words(NextSpellId())
		spell:needTarget(true)
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(false)
		spell:needDirection(true)
		spell:register()
	end)
	:MonsterEvent(function()
		local smallLaser = Combat()
		smallLaser:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		smallLaser:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
		local smallArea = createCombatArea(AREA_SIDEBEAMS1)
		smallLaser:setArea(smallArea)

		local spell = Spell("instant")

		function spell.onCastSpell(creature, var)
			Game.createMonster("Laga Dyga", creature:getPosition(), true, true)
			return true
		end

		spell:name("undead crypt king summon laga dyga")
		spell:words(NextSpellId())
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(true)
		spell:needDirection(true)
		spell:register()
	end)
	:MonsterEvent(function()
		local textOnPlacement = "The Undead King conjured a bomb! Cover it with your bodies!"

		local totalDamage = 5000

		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
		combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE)

		local area = createCombatArea(AREA_BEAM1)
		combat:setArea(area)

		local function sendPositionsWarning(topLeft, downRight, magicEffect)
			IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				pos:sendMagicEffect(magicEffect)
			end)
		end

		local function damageAllPlayers(topLeft, downRight)
			IterateBetweenPositions(topLeft, downRight, function(context)
				local pos = context.pos
				local tile = Tile(pos)
				if not tile then
					return
				end
				local creature = tile:getTopCreature()
				if not creature then
					return
				end
				doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, totalDamage, totalDamage, CONST_ME_NONE)
			end)
		end

		local unsoakedExplosionRadius = 22
		local explosionDelay = 10000
		local soakRadius = 1

		local function trySplitDamageBetweenPlayers(topLeft, downRight)
			if topLeft:PlayerCountBetween(downRight) > 0 then
				sendPositionsWarning(topLeft, downRight, CONST_ME_FIREAREA)
				local creatures = topLeft:PlayersBetween(downRight):Get()
				local splitdmg = totalDamage / #creatures
				for _, value in pairs(creatures) do
					doTargetCombatHealth(0, value, COMBAT_FIREDAMAGE, splitdmg, splitdmg, CONST_ME_NONE)
				end
				return true
			end
			return false
		end

		local function randomBombTarget(bossCid)
			local creatures = CreatureList():RadiusSquare(Creature(bossCid):getPosition(), 7, 5):FilterByPlayer()
			local target = creatures:GetRandom()
			creatures:FilterByVocation(VOCATION.ID.KNIGHT)
			local targetNonKnight = creatures:GetRandom()
			return targetNonKnight or target
		end

		local function sendPlacementWarning(topLeft, downRight, target)
			target:say(textOnPlacement, TALKTYPE_MONSTER_SAY)
			sendPositionsWarning(topLeft, downRight, CONST_ME_FIREAREA)
		end

		local function sendWarningsBeforeExplosion(topLeft, downRight)
			for i = 1, 3 do
				addEvent(function()
					sendPositionsWarning(topLeft, downRight, CONST_ME_HITBYFIRE)
				end, explosionDelay - i * 650)
			end
		end

		local function getNewBombPosition(target)
			local targetPos = target:getPosition()
			local topLeft, downRight = targetPos:GetBoundariesByRadius(1)
			local newPos = IterateBetweenPositions(topLeft, downRight, function(context)
				if context.pos:IsPathable() then
					return context.pos
				end
			end, { stopCondition = STOP_CONDITIONS.isNotNull })
			return Position(newPos)
		end

		local function placeBomb(pos)
			local bomb = Game.createItem(23486, 1, pos)
			bomb:setUniqueId(1000)
			return bomb
		end

		local function createBombTextures(soakTopLeft, soakDownRight, centerPos)
			local textures = {}
			IterateBetweenPositions(soakTopLeft, soakDownRight, function(context)
				local pos = context.pos
				textures[#textures + 1] = Game.createItem(23483, 1, pos)
			end)
			textures[#textures + 1] = placeBomb(centerPos)
			return textures
		end

		local function removeBombTextures(textures)
			for _, texture in pairs(textures) do
				texture:remove()
			end
		end

		local bombTimerSeconds = 10

		local spell = Spell("instant")
		function spell.onCastSpell(casterCid, var)
			local target = randomBombTarget(casterCid)
			if not target then
				return
			end

			local pos = getNewBombPosition(target)
			if not pos then
				return
			end

			local soakTopLeft, soakDownRight = pos:GetBoundariesByRadius(soakRadius)
			local arenaTopLeft, arenaDownRight = pos:GetBoundariesByRadius(unsoakedExplosionRadius)

			local bombTextures = createBombTextures(soakTopLeft, soakDownRight, pos)
			addEvent(function()
				removeBombTextures(bombTextures)
			end, bombTimerSeconds * 1000)

			sendPlacementWarning(soakTopLeft, soakDownRight, target)
			sendWarningsBeforeExplosion(soakTopLeft, soakDownRight)
			Game.startCountdown(pos, bombTimerSeconds)

			addEvent(function()
				if trySplitDamageBetweenPlayers(soakTopLeft, soakDownRight) then
					return
				else
					damageAllPlayers(arenaTopLeft, arenaDownRight)
					sendPositionsWarning(arenaTopLeft, arenaDownRight, CONST_ME_FIREAREA)
					return
				end
			end, explosionDelay)
			return true
		end

		spell:name("undead crypt king soak bomb")
		spell:words(NextSpellId())
		spell:isAggressive(true)
		spell:blockWalls(true)
		spell:needLearn(true)
		spell:needDirection(true)
		spell:register()
	end)
	:Mission(Storage.PathOfTheUndead.Mission01)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Gandalf", {
			[{ "oprocz tego ludzie", "aside from that people" }] = {
				text = "It was many years ago. One day, in Mirkotown, the Undead King of the Crypt appeared, causing havoc among our residents. The city slowly turned into a ruin until 9:37 PM when one of the houses was blown up using dark magic. In that same house, there was a laundry basket, and inside it, a holy relic - socks with John Paul, which flew and landed in the hands of the Crypt King. At that moment, he howled with a demonic voice, 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ' and immediately became paralyzed. Without a second thought, all defenders gathered to seal his soul. On the same day, we locked his soul in the banshee cave. The remains of his body were scattered across the desert to prevent any attempts at reanimation. I thought his spirit would be neutralized in the cave, but as I recently found out, he managed to escape from there. I don't know how strong he is right now, but he will surely try to regenerate. We must ultimately destroy him! It won't be an easy task, and before I entrust it to you, you will need to prove to me that you are worthy of leading this crusade. Return to me when you fulfill all my {conditions}.",
				nextState = {
					[Storage.PathOfTheUndead.Mission01] = QuestState.PathOfTheUndead.Mission01.ConsultGandalf,
				},
				requiredState = {
					[Storage.Finished.AssassinsCreedSquurvaali] = MISSION_FINISHED,
					[Storage.Finished.ImRestingHere] = MISSION_FINISHED,
					[Storage.Finished.SultanPrime] = MISSION_FINISHED,
					[Storage.ChesterTheDwarf.Mission03] = MISSION_FINISHED,
				},
				textNoRequiredState = "It's interesting that you know our password. Nevertheless, I have no task for you or anything to interest you with.",
			},
			[{ "king", "crypt king", "king of the crypt", "krol krypty", "krol" }] = {
				text = "If you really know what danger he is, deal with his ally first - Sultan of Phantasms. Also deal with that swindler, Chester, who tried to fuck me over in Down's Labyrinth.",
			},
		})
	)
	:State(
		QuestState.PathOfTheUndead.Mission01.ConsultGandalf,
		QuestFactory.Dialog("Gandalf", {
			[{ GREET }] = {
				text = "Welcome again. Are you ready to accept my {conditions}?",
			},
			[{ "conditions", "warunki" }] = {
				text = "Allakhazam!!!1. Oh, wait, that's not all. I forgot that you also need to visit the magic circles. Each circle consists of 6 stones in 3 different colors, with a special grid in the middle. Stand on all five grids, and I will be able to bless you. I won't tell you where the circles are because you can ask the owners of magic shops in towns about it. Talk to them, and they will guide you to the circles. Just write 'circle' to them, and they will explain everything to you.",
				nextState = {
					[Storage.PathOfTheUndead.Mission01] = QuestState.PathOfTheUndead.Mission01.Finished,
					[Storage.PathOfTheUndead.Mission02] = QuestState.PathOfTheUndead.Mission02.VisitMagicalCircles,
					[Storage.PathOfTheUndead.Circles] = 0,
				},
				requiredState = {
					[Storage.PitsOfInferno.OneThrone] = { min = 1 },
					[Storage.Finished.ArielsFriend] = { min = 1 },
					[Storage.WayOfTheDruid.CouncilOfDruids] = { min = QuestState.WayOfTheDruid.CouncilOfDruids.HelpedFive },
				},
				textNoRequiredState = "My conditions are to complete the following tasks: Druid Path, Yalahar Quest. While you know the secret password, I also want other druids and elves to vouch for you. Additionally, you must visit at least one poi throne. If you are ready, ask me again about {conditions}.",
			},
		})
	)
	:Mission(Storage.PathOfTheUndead.Mission02)
	:State(
		QuestState.PathOfTheUndead.Mission02.VisitMagicalCircles,
		QuestFactory.Dialog("Gandalf", {
			[{ "mission" }] = {
				text = "Hocus Pocus! Now everything should work. Something very dark lurks in the pyramid's underground. Ask Konmuld for advice, and maybe you will escape from there alive. Oh, I almost forgot: from now on, you can now use the sealed doors in the pyramid.",
				nextState = {
					[Storage.PathOfTheUndead.Mission02] = QuestState.PathOfTheUndead.Mission02.Finished,
					[Storage.PathOfTheUndead.Mission03] = QuestState.PathOfTheUndead.Mission03.DefeatUndeadKing,
				},
				requiredState = {
					[Storage.PathOfTheUndead.Circles] = 31, -- binary 11111 - 1 for each tile
				},
				textNoRequiredState = "Ask the individual owners of magic shops about the locations of the circles.",
			},
		}),
		QuestFactory.StartupItems({
			{ pos = { 5625, 1765, 6 }, id = 596, aid = Storage.PathOfTheUndead.Circles }, --South knurowo
			{ pos = { 6527, 1391, 6 }, id = 597, aid = Storage.PathOfTheUndead.Circles }, --Hurghada
			{ pos = { 6951, 702, 7 }, id = 598, aid = Storage.PathOfTheUndead.Circles }, --Kongo
			{ pos = { 5960, 1466, 4 }, id = 599, aid = Storage.PathOfTheUndead.Circles }, --Mirko north
			{ pos = { 6727, 887, 7 }, id = 924, aid = Storage.PathOfTheUndead.Circles }, --Feral sphinx
		}),
		QuestFactory.Script(function(missionState)
			local idToStorageVal = {
				[596] = 1,
				[597] = 2,
				[598] = 4,
				[599] = 8,
				[924] = 16,
			}

			local step_tile = MoveEvent()

			local function IsFactor(number, factor)
				if (number % (factor * 2)) >= factor then
					return true
				end
				return false
			end

			local questlineStorage = Storage.PathOfTheUndead.Mission01
			local circleStorage = Storage.PathOfTheUndead.Circles

			local function GetUncompletedCirclesCount(player)
				local storageVal = player:getStorageValue(circleStorage)
				local length = 0

				for _, value in pairs(idToStorageVal) do
					if not IsFactor(storageVal, value) then
						length = length + 1
					end
				end
				return length
			end

			function step_tile.onStepIn(player, item, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end

				local questlineStorageVal = player:getStorageValue(questlineStorage)
				if questlineStorageVal ~= 2 then
					return
				end

				local storageVal = player:getStorageValue(circleStorage)
				if storageVal < 0 then
					player:setStorageValue(circleStorage, 0)
				end

				local addend = idToStorageVal[item:getId()]
				if not IsFactor(storageVal, addend) then
					player:setStorageValue(circleStorage, player:getStorageValue(circleStorage) + addend)
					player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
					local firstStepMessage = player:Localizer(Storage.PathOfTheUndead.Mission01):Get("You step on circle number ")
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, firstStepMessage .. math.floor(math.log(addend, 2) + 1))
				end

				local circlesCount = GetUncompletedCirclesCount(player)
				if circlesCount ~= 0 then
					local standOn = player:Localizer(Storage.PathOfTheUndead.Mission01):Get("To fulfill Gandalf's task you need to stand on ")
					local remaining = player:Localizer(Storage.PathOfTheUndead.Mission01):Get(" remaining circles.")

					player:sendTextMessage(MESSAGE_FAILURE, standOn .. circlesCount .. remaining)
				end
			end

			step_tile:aid(Storage.PathOfTheUndead.Circles)
			step_tile:type("stepin")
			step_tile:register()
		end),
		QuestFactory.Dialog("Fstab", {
			[{ "krag", "kregi", "circles", "cromlech" }] = {
				text = "Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is somewhere south of Knurow.",
			},
		}),
		QuestFactory.Dialog("Funfel", {
			[{ "krag", "kregi", "circles", "cromlech" }] = {
				text = "This cromlech is located behind the orc hill in the west of the city. There's also corym village nearby. The other one is to the west, beyond lizard village.",
			},
		}),
		QuestFactory.Dialog("Nadia France", {
			[{ "krag", "kregi", "circles", "cromlech" }] = {
				text = "I understand, the stone cromlech is located on a peninsula to the southwest of here.",
			},
		})
	)
	:Mission(Storage.PathOfTheUndead.Mission03)
	:State(
		QuestState.PathOfTheUndead.Mission03.DefeatUndeadKing,
		QuestFactory.Dialog("Konmuld", {
			{
				[{ "mission", "misja", "krol krypty", "crypt king", "the king of the crypt", "king", "krol" }] = {
					text = "Gandalf sent you here, right? If you want to go to the down pyramid, you need to know that there is an Undead Crypt King waiting, and that {encounter} him will not be easy by any means. To summon him, you will need a few ingredients. Take the most necessary things: wood, cauldron, vial and lighter. For the ritual you will need {bones} so foul that they lower the wavelength of the light around. Plus the {signet ring} of an undead lord, and a {cloak} made of the skin of unbaptized children. If you're going to collect these items, ask me about the {ritual}.",
				},
				[{ "walka", "encounter", "fight" }] = {
					text = "The Crypt King is skilled in many areas, not just magic. In addition to the standard set of spells of a generic villain, such as summoning the undead and shooting lasers, he can use spells from other universes. Apparently his mother had allowed him to play WoW when he was little, and now he has mastered some of the skills available there. He studied the 'sciences' of goblins, so he can quickly construct bombs. If I remember correctly, you'll probably have to cover the bombs with your body so they don't blow up the entire platform. The last thing you need to know is that the Vault King is constantly increasing his damage, so he is unwilling to change his current target.",
				},
				[{ "kosci", "bone", "bones" }] = {
					text = "It's called Unholy Bone.",
				},
				[{ "sygnet", "signet", "pierscien", "seal" }] = {
					text = "This ring has vanished somewhere, maybe {Grave Digger} will tell you more about it.",
				},
				[{ "grave digger" }] = {
					text = "He sells equipment in Mirko, I think you know him.",
				},
				[{ "plaszcz", "cape" }] = {
					text = "Only the one group could create such a thing - PiS cultists from Sybir",
				},
				[{ "rytual", "ritual" }] = {
					text = "Before you start, you must summon three guards whose skeletons are blocking access to the ritual site. You'll probably have to defeat them to get further. To summon each of them, you will show perseverance to people unknown to this world. This will require you to have fourteen different {effects}. Somewhere in the depths of the dungeons you will find a circle made of stones. It is where the ritual of summoning the Crypt King will take place",
				},
				[{ "effects", "efektow", "efekty" }] = {
					text = "I managed to extract this knowledge from the ancient collections in the library of the Lvivversity of Archmages. If you think you can read these notes - I hid the scroll under the bush to the right. And remember, not all of the effects listed there are real - apparently this document was written on the knee.",
				},
			},
		}),
		QuestFactory.Dialog("Grave Digger", {
			[{ "sygnet", "signet", "piescien", "seal" }] = {
				text = "I don't know how you know about this ring, but if you want to find it, listen. It was in the Diremaw caves under the cultist swamp. As I approached the Fire Fucker's cave, he roared so hard that I shit myself and started running away as fast as I could. In this haste, one of the dummy atifacts I used for... never mind, fell out of my backpack. Inside the dummy I had dropped there was a ring. If I remember correctly, this dummy was supposed to imitate a precious miniature of the ship. Coming back to how I escaped, all I remember is waking up in the temple. If you want, you can look for that ring, I don't need it anymore.",
			},
		}),
		QuestFactory.Dialog("Gandalf", {
			[{ "mission" }] = {
				text = "Here is your reward for your effort. Wait, wait... where is my backpack!? It was probably Chester doing. Well, I guess your bonus reward is gone.",
				nextState = {
					[Storage.PathOfTheUndead.Mission03] = QuestState.PathOfTheUndead.Mission03.Finished,
					[Storage.Finished.PathOfTheUndead] = MISSION_FINISHED,
					[Storage.ChesterTheDwarf.Mission04] = QuestState.ChesterTheDwarf.Mission04.FindChester,
				},
				expReward = 25000000,
			},
		}),
		QuestFactory.StartupItems({
			{ pos = { 6221, 1238, 7 }, id = 3698, aid = Storage.PathOfTheUndead.KonmuldBush },
			{ pos = { 6684, 1166, 11 }, id = 5113, aid = Storage.PathOfTheUndead.SkipDoor },
		}),
		QuestFactory.StartupItems({
			{ pos = { -6, 44, -3 }, id = 2773, aid = Storage.PathOfTheUndead.UpperLever },

			{ pos = { -7, 33, -1 }, id = 1660, aid = Storage.PathOfTheUndead.Mission03 }, -- quest door
			{ pos = { -22, 35, 1 }, id = 2472, aid = Storage.PathOfTheUndead.CursedChest },
			{ pos = { -11, 27, 1 }, id = 2472, aid = Storage.PathOfTheUndead.CursedChest },
			{ pos = { 3, 27, 1 }, id = 2472, aid = Storage.PathOfTheUndead.CursedChest },

			{ pos = { -17, 21, 1 }, id = 7575, aid = Storage.PathOfTheUndead.GuardianSkull },
			{ pos = { -11, 19, 1 }, id = 7568, aid = Storage.PathOfTheUndead.GuardianSkull },
			{ pos = { 5, 15, 1 }, id = 7574, aid = Storage.PathOfTheUndead.GuardianSkull },

			{ pos = { -9, 13, 1 }, id = 351, aid = Storage.PathOfTheUndead.GuardianGateTile },
			{ pos = { -8, 13, 1 }, id = 351, aid = Storage.PathOfTheUndead.GuardianGateTile },

			{ pos = { 2, -34, -2 }, id = 470, aid = Storage.PathOfTheUndead.RitualLocus },

			{ pos = { -68, 1, 0 }, id = 11440, aid = Storage.PathOfTheUndead.BossBook },
			{ pos = { -9,	10,	1 }, id = 410, aid = Storage.PathOfTheUndead.GrantSkipDoorAccess },
		}, PATH_OF_THE_UNDEAD_ANCHOR),
		QuestFactory.Script(function(missionState)
			local updateStorages = {
				[Storage.PathOfTheUndead.Mission03] = QuestState.PathOfTheUndead.Mission03.ReturnToGandalf,
			}

			local exitPos = PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = 4, y = -32, z = -2 })
			local portal = MoveEvent()

			function portal.onStepIn(player, item, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end

				if player:HasExactMissionState(missionState) then
					player:NextState(updateStorages)
				end

				player:teleportTo(exitPos)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end

			portal:aid(Storage.PathOfTheUndead.BossRoomExit)
			portal:type("stepin")
			portal:register()
		end),
		QuestFactory.Script(function(missionState)
			local bushMessage =
				"enum ConditionType_t {\nCONDITION_NONE,\n    \nCONDITION_POISON = 1 << 0,\nCONDITION_FIRE = 1 << 1,\nCONDITION_ENERGY = 1 << 2,\nCONDITION_BLEEDING = 1 << 3,\nCONDITION_HASTE = 1 << 4,\nCONDITION_PARALYZE = 1 << 5,\nCONDITION_OUTFIT = 1 << 6,\nCONDITION_INVISIBLE = 1 << 7,\nCONDITION_LIGHT = 1 << 8,\nCONDITION_MANASHIELD = 1 << 9,\nCONDITION_INFIGHT = 1 << 10,\nCONDITION_DRUNK = 1 << 11,\nCONDITION_EXHAUST = 1 << 12, // unused\nCONDITION_REGENERATION = 1 << 13,\nCONDITION_SOUL = 1 << 14,\nCONDITION_DROWN = 1 << 15,\nCONDITION_MUTED = 1 << 16,\nCONDITION_CHANNELMUTEDTICKS = 1 << 17,\nCONDITION_YELLTICKS = 1 << 18,\nCONDITION_ATTRIBUTES = 1 << 19,\nCONDITION_FREEZING = 1 << 20,\nCONDITION_DAZZLED = 1 << 21,\nCONDITION_CURSED = 1 << 22,\nCONDITION_EXHAUST_COMBAT = 1 << 23, // unused\nCONDITION_EXHAUST_HEAL = 1 << 24, // unused\nCONDITION_PACIFIED = 1 << 25,\nCONDITION_SPELLCOOLDOWN = 1 << 26,\nCONDITION_SPELLGROUPCOOLDOWN = 1 << 27,\nCONDITION_ROOTED = 1 << 28,\n"

			local bush = Action()

			function bush.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return true
				end

				local storageval = player:getStorageValue(Storage.PathOfTheUndead.Mission01)
				if storageval < 3 then
					return false
				end

				player:registerEvent("konmuldBushModalWindow")

				local title = "You read the following."
				local message = bushMessage

				local window = ModalWindow(item.actionid, title, message)
				window:addButton(101, "Close")
				window:setDefaultEscapeButton(101)
				window:sendToPlayer(player)
				player:unregisterEvent("konmuldBushModalWindow")
				return true
			end

			bush:aid(Storage.PathOfTheUndead.KonmuldBush)
			bush:register()
		end),
		QuestFactory.Script(function(missionState)
			local doors = {
				{ pos = Position(PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = -8, y = 12, z = 1 })), id = 1564 },
				{ pos = Position(PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = -9, y = 12, z = 1 })), id = 1563 },
			}

			local function eachTileHasItem(top_left, down_right, id, anchor)
				if anchor then
					top_left = anchor:Moved(top_left)
					down_right = anchor:Moved(down_right)
				end

				for i = top_left.x, down_right.x do
					for j = top_left.y, down_right.y do
						local pos = Position(i, j, top_left.z)
						if not pos:hasItem(id) then
							return false
						end
					end
				end
				return true
			end

			local beforeGate = MoveEvent()

			function beforeGate.onStepIn(player, item, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end
				if not eachTileHasItem(Vector(-12, 15, 1), Vector(-10, 15, 1), 12952, PATH_OF_THE_UNDEAD_ANCHOR) then
					return false
				end
				for _, door in pairs(doors) do
					local pos = door.pos
					local id = door.id
					local tile = Tile(pos)
					if tile:getItemById(id) then
						tile:getItemById(id):remove()
						pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
					end
				end
			end

			beforeGate:aid(Storage.PathOfTheUndead.GuardianGateTile)
			beforeGate:type("stepin")
			beforeGate:register()
		end),
		QuestFactory.Script(function()
			local stairsAfterGate = MoveEvent()
			function stairsAfterGate.onStepIn(player, item, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end
				player:setStorageValue(Storage.PathOfTheUndead.SkipDoor, ACCESS_GRANTED)
			end
			stairsAfterGate:aid(Storage.PathOfTheUndead.GrantSkipDoorAccess)
			stairsAfterGate:type("stepin")
			stairsAfterGate:register()
		end),
		QuestFactory.Script(function(missionState)
			local bossRoomPos = PATH_OF_THE_UNDEAD_ANCHOR:Moved({ x = -60, y = -14, z = 0 })

			local workingTeleportId = 23483

			local nextRequiredThrowId = { 5901, 3465, 5467, 10316, 18935, 7993 }

			local ritualStateToNextPotId = { [2] = 1997, [3] = 2002, [4] = 2003 }

			local ritualState = 1

			local ritualPot = nil

			local function openPortal(pos)
				local portal = Game.createItem(workingTeleportId, 1, pos)
				portal:setActionId(Storage.PathOfTheUndead.RitualLocus)
				ritualPot:remove()
			end

			local function tryProgressRitualPot(pos)
				local nextRitualPotId = ritualStateToNextPotId[ritualState]
				if nextRitualPotId then
					ritualPot:transform(nextRitualPotId)
				else
					pos:sendMagicEffect(CONST_ME_WATERSPLASH)
				end
			end

			local ritualLocus = MoveEvent()
			function ritualLocus.onAddItem(moveitem, tileitem, position)
				if not moveitem then
					return false
				end

				if ritualPot == nil then
					ritualPot = Tile(PATH_OF_THE_UNDEAD_ANCHOR:Moved(1, -35, -1)):getItemById(1996)
				end

				local nextThrowId = nextRequiredThrowId[ritualState]
				local moveitemId = moveitem:getId()

				if moveitemId ~= nextThrowId then
					return false
				end

				ritualState = ritualState + 1
				moveitem:remove()
				tryProgressRitualPot(tileitem:getPosition())
				if ritualState > #nextRequiredThrowId then
					openPortal(tileitem:getPosition())
				end
				return true
			end

			ritualLocus:type("additem")
			ritualLocus:aid(Storage.PathOfTheUndead.RitualLocus)
			ritualLocus:register()

			local step_tile = MoveEvent()

			function step_tile.onStepIn(player, stepInItem, toPosition, fromPosition)
				if not player:isPlayer() then
					return false
				end
				local portal = Tile(toPosition):getItemById(workingTeleportId)
				if not portal then
					return
				end
				player:teleportTo(bossRoomPos)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end

			step_tile:aid(Storage.PathOfTheUndead.RitualLocus)
			step_tile:type("stepin")
			step_tile:register()
		end),
		QuestFactory.Script(function(missionState)
			local gatePositions = {
				{ x = -12, y = 37, z = -2 },
				{ x = -11, y = 37, z = -2 },
			}
			local gateId = 2182

			local lever = Action()

			function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				for _, relativePos in pairs(gatePositions) do
					local pos = Position(PATH_OF_THE_UNDEAD_ANCHOR:Moved(relativePos))
					local tile = Tile(pos)
					local gate = tile:getItemById(gateId)
					if gate then
						gate:remove()
					else
						Game.createItem(gateId, 1, pos)
					end
					toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
				end
				return true
			end

			lever:aid(Storage.PathOfTheUndead.UpperLever)
			lever:register()
		end),
		QuestFactory.Script(function(missionState)
			local book = Action()

			function book.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				local pos = item:getPosition()
				pos:sendMagicEffect(CONST_ME_THUNDER)
				pos:sendMagicEffect(CONST_ME_TELEPORT)
				Game.createMonster("Undead Crypt King", pos, true, true)
				item:remove()
				return true
			end

			book:aid(Storage.PathOfTheUndead.BossBook)
			book:register()
		end),
		QuestFactory.Script(function(missionState)
			local conditions = {
				CONDITION_POISON, -- utori pox
				CONDITION_FIRE, -- utori flam
				CONDITION_ENERGY, -- utori vis
				CONDITION_BLEEDING, -- utori kor
				CONDITION_HASTE, -- utani hur
				CONDITION_INVISIBLE, -- utana vid/stealth ring
				CONDITION_MANASHIELD, -- utamo vita/ering
				CONDITION_INFIGHT, -- any attack spell
				CONDITION_DRUNK, -- drink beer
				CONDITION_DROWN, -- special chest
				CONDITION_MUTED, -- spam
				CONDITION_FREEZING, -- special chest
				CONDITION_DAZZLED, -- utori san
				CONDITION_CURSED, -- utori mort
			}

			local lever = Action()

			function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				for _, identifier in pairs(conditions) do
					local condition = Condition(identifier)
					condition:setParameter(CONDITION_PARAM_DELAYED, 1)
					condition:setParameter(CONDITION_PARAM_TICKS, 200000)
					condition:addDamage(5000, 2000, -50)
					player:addCondition(condition)
				end
			end

			lever:aid(44433)
			lever:register()
		end),
		QuestFactory.Script(function(missionState)
			local conditions = {}

			do
				local condition = Condition(CONDITION_FREEZING)
				condition:setParameter(CONDITION_PARAM_DELAYED, 1)
				condition:addDamage(5000, 3000, -50)

				conditions[#conditions + 1] = condition
			end

			do
				local condition = Condition(CONDITION_DROWN)
				condition:setParameter(CONDITION_PARAM_DELAYED, 1)
				condition:addDamage(5000, 2000, -50)

				conditions[#conditions + 1] = condition
			end

			local chest = Action()

			function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return true
				end
				for _, condition in pairs(conditions) do
					player:addCondition(condition)
				end
				player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
				return true
			end

			chest:aid(Storage.PathOfTheUndead.CursedChest)
			chest:register()
		end),
		QuestFactory.Script(function(missionState)
			local conditions = {
				CONDITION_POISON, --utori pox
				CONDITION_FIRE, --utori flam
				CONDITION_ENERGY, --utori vis

				CONDITION_BLEEDING, --utori kor
				CONDITION_HASTE, --utani hur
				CONDITION_INVISIBLE, --utana vid/stealth ring

				CONDITION_MANASHIELD, --utamo vita/ering
				CONDITION_INFIGHT, -- any attack spell
				CONDITION_DRUNK, -- drink beer

				CONDITION_DROWN, -- special chest
				CONDITION_MUTED, -- spam
				CONDITION_FREEZING, -- special chest

				CONDITION_DAZZLED, --utori san
				CONDITION_CURSED, --utori mort
			}

			function Player:CountConditions()
				local counter = 0

				for _, condition in pairs(conditions) do
					if self:hasCondition(condition) then
						counter = counter + 1
					end
				end

				if not self:hasCondition(CONDITION_REGENERATION) then
					counter = counter + 1
				end
				return counter
			end

			local idToCreatureName = {
				[7575] = "Cipociamkacz",
				[7568] = "PatriotaPL",
				[7574] = "CalaNapszut",
			}

			local skull = Action()

			local spawnstates = {
				[7575] = 0,
				[7568] = 0,
				[7574] = 0,
			}

			local requiredCount = #conditions - 1

			function skull.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				local id = item:getId()
				if spawnstates[id] == 1 then
					return false
				end

				local conditionsCount = player:CountConditions()
				if conditionsCount >= requiredCount then
					for _, condition in pairs(conditions) do
						player:removeCondition(condition)
					end
					spawnstates[id] = 1
					Game.createMonster(idToCreatureName[id], player:getPosition(), true, true)
				end
				return false
			end

			skull:aid(Storage.PathOfTheUndead.GuardianSkull)
			skull:register()
		end)
	)
	:Register()
