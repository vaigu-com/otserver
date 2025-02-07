local quest = Quest(LOCALIZERS.SultanPrime)

quest
	:Storage(function()
		Storage.SultanPrime = {
			Necklace = {},

			Mission01 = {},
			MagicianFountain = {},

			Mission02 = {},
			FarmerChair = {},
			DromedaryCount = {},

			Mission03 = {},
			Coffin = {},
			CoffinCount = {},
			CorpseCount = {},
			Jaw = {},
			DoorAfterRyba = {},
			RetroLever = {},

			RewardsScripted = { Necklace = {} },
		}
		QuestState.SultanPrime = {
			Mission01 = {
				ConsultSultanAboutAmulet = 1,
				TradeAmuletWithSultan = 2,
			},
			Mission02 = {
				AskSultanForFirstTask = 1,
				PoisonMagiciansWell = 2,
				AskSultanForCamelTask = 3,
				KillCamels = 4,
				ProvideDampreeferWithRope = 5,
				ReportToSultan = 6,
			},
			Mission03 = {
				OpenCoffins = 1,
				ThrowBodies = 2,
				GetRidOfAspirantRyba = 3,
				ReportToSultan = 4,
				AskNatanekForHelp = 5,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.SultanPrime = {
			Bottle = { id = 10183, key = Storage.SultanPrime.MagicianFountain },
			Amulet = { id = 3015, key = Storage.SultanPrime.Necklace },
			CezaryCorpse = { id = 4240 },
		}
		SULTAN_PRIME_CAMEL_FARM = { topLeft = { -37, -25, 0 }, downRight = { 12, 22, 0 }, requiredDromedaryCount = 6 }
		SULTAN_PRIME_RETRO_MIRKO = {
			requiredCoffinCount = 5,
			corpseId = {
				[18134] = 1, -- hero
				[18034] = 1, -- adventurer
				[18138] = 1, -- hunter
			},
			requiredCorpseCount = 10,
		}
	end)
	:Questlog(function()
		table.insert(Quests, {
			name = "Sultan Prime",
			missions = {
				{
					name = "What Is Mafia? Is It Good?",
					storage = Storage.SultanPrime.Mission01,
					states = {
						[QuestState.SultanPrime.Mission01.ConsultSultanAboutAmulet] = "You found the cursed amulet of power. Return it to the King of Phantasms so he can begin his world destruction plan.",
						[QuestState.SultanPrime.Mission01.TradeAmuletWithSultan] = "Sultan made you an offer. Give the neclace to him to begin your mission.",
						[MISSION_FINISHED] = "You returned the amulet to the Sultan and agreed to help him.",
					},
				},
				{
					name = "Unlucky Surveyors",
					storage = Storage.SultanPrime.Mission02,
					states = {
						[QuestState.SultanPrime.Mission02.AskSultanForFirstTask] = "Go to Sultan of Phantasms for another task.",
						[QuestState.SultanPrime.Mission02.PoisonMagiciansWell] = "Sultan of Phantasms assigned you a task worthy of a novice villain. Poison the fountain in the town of Magicians using the poisoned flask.",
						[QuestState.SultanPrime.Mission02.AskSultanForCamelTask] = "You've successfully completed the first task for Sultan of Phantasms. Return to him now.",
						[QuestState.SultanPrime.Mission02.KillCamels] = "CAMELS_KILLED_STATUS",
						[QuestState.SultanPrime.Mission02.ProvideDampreeferWithRope] = "You wiped out the camel farm. Leave the rope on the table - he'll know what to do with it.",
						[QuestState.SultanPrime.Mission02.ReportToSultan] = "Sultan will be pleased with your actions. Return to him for your reward.",
						[MISSION_FINISHED] = "Sultan rewarded you for your cooperation.",
					},
				},
				{
					name = "Sultan's Last Plague",
					storage = Storage.SultanPrime.Mission03,
					states = {
						[QuestState.SultanPrime.Mission03.OpenCoffins] = "OPENED_COFFINS_STATUS",
						[QuestState.SultanPrime.Mission03.ThrowBodies] = "BODIES_THROWN_STATUS",
						[QuestState.SultanPrime.Mission03.GetRidOfAspirantRyba] = "~Sultan69: It's time to get rid of Aspirant Ryba. After work, you can leave the barracks through the northern doors and use the shortcut.",
						[QuestState.SultanPrime.Mission03.ReportToSultan] = "~Sultan69: How did Ryba escape? The Crypt King also fell in battle. Come back immediately so I can chew you out!",
						[QuestState.SultanPrime.Mission03.AskNatanekForHelp] = "Sultan ordered you to.. You can go to Father Natanek and ask him for redemption.",
						[MISSION_FINISHED] = "Father Natank gave you today's offering from today's Mass in exchange for your silence.",
					},
				},
			},
		})
	end)
	:MonsterEvent(function()
		local cezary = CreatureEvent("CezaryBarykaDeath")

		function cezary.onDeath(creature)
			local deathPos = creature:getPosition()
			local corpse = Game.createItem(QuestKeyItems.SultanPrime.CezaryCorpse.id, 1, deathPos)
			corpse:setActionId(Storage.SultanPrime.Necklace)

			addEvent(function()
				Game.createMonster("Cezary Baryka", deathPos)
			end, 1000 * 2 * 60)
			return true
		end

		cezary:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Aspirant Ryba")
		local monster = {}

		monster.description = "an aspirant ryba"
		monster.experience = 16000
		monster.outfit = {
			lookType = 970,
			lookHead = 95,
			lookBody = 38,
			lookLegs = 57,
			lookFeet = 95,
			lookAddons = 3,
			lookMount = 0,
		}

		monster.health = 16000
		monster.maxHealth = 17000
		monster.race = "blood"
		monster.corpse = 18250
		monster.speed = 125
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 10,
		}

		monster.strategiesTarget = {
			nearest = 80,
			health = 10,
			damage = 10,
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
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
			pet = false,
		}

		monster.events = {
			"RybaKill",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
			{ text = "MINE!", yell = true },
			{ text = "No prisoners!", yell = true },
			{ text = "NO MERCY!", yell = true },
			{ text = "You're no match for me!", yell = false },
		}

		monster.loot = {
			{ name = "gold coin", chance = 49000, maxCount = 133 },
			{ id = 3277, chance = 30800, maxCount = 3 },
			{ id = 3602, chance = 21600, maxCount = 2 },
			{ id = 3372, chance = 12200 },
			{ id = 3003, chance = 16020 },
			{ id = 3269, chance = 11850 },
			{ id = 3357, chance = 10370 },
			{ id = 3351, chance = 11220 },
			{ id = 3265, chance = 8470 },
			{ id = 3369, chance = 6210 },
			{ id = 3305, chance = 6980 },
			{ id = 3318, chance = 1980 },
			{ id = 3370, chance = 1000 },
			{ id = 3383, chance = 1900 },
			{ id = 3384, chance = 2330 },
			{ id = 3371, chance = 1350 },
			{ id = 3016, chance = 740 },
			{ id = 3302, chance = 310 },
			{ id = 822, chance = 650 },
			{ id = 2995, chance = 210 },
			{ id = 3079, chance = 520 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, skill = 90, attack = 60 },
			{
				name = "combat",
				interval = 2000,
				chance = 22,
				type = COMBAT_PHYSICALDAMAGE,
				minDamage = 0,
				maxDamage = -200,
				range = 7,
				shootEffect = CONST_ANI_SPEAR,
				target = false,
			},
		}

		monster.defenses = {
			defense = 60,
			armor = 42,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 80 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 95 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 100 },
			{ type = COMBAT_HOLYDAMAGE, percent = -10 },
			{ type = COMBAT_DEATHDAMAGE, percent = 20 },
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

		mType.onSay = function(listener, talker, type, message) end

		mType.onAppear = function(monster, creature) end
		
		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Cezary Baryka")
		local monster = {}

		monster.description = "Cezary Baryka"
		monster.experience = 5000
		monster.outfit = {
			lookType = 128,
			lookHead = 60,
			lookBody = 0,
			lookLegs = 112,
			lookFeet = 114,
			lookAddons = 2,
			lookMount = 0,
		}

		monster.health = 3000
		monster.maxHealth = 15000
		monster.race = "undead"
		monster.corpse = 0
		monster.speed = 50
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 5000,
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
			illusionable = false,
			canPushItems = true,
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
			"CezaryBarykaDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -370 },
			{
				name = "combat",
				interval = 500,
				chance = 60,
				type = COMBAT_LIFEDRAIN,
				minDamage = -15,
				maxDamage = -50,
				range = 1,
				radius = 1,
				effect = CONST_ME_SMALLCLOUDS,
				target = true,
			},
		}

		monster.defenses = {
			defense = 15,
			armor = 15,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 15 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 15 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 15 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Mission(Storage.SultanPrime.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.StartupItems({
				{ id = QuestKeyItems.SultanPrime.CezaryCorpse.id, key = Storage.SultanPrime.Necklace, nextState = { [Storage.SultanPrime.Mission01] = 1 }, rewards = { QuestKeyItems.SultanPrime.Amulet }, requiredState = { [Storage.SultanPrime.Mission01] = MISSION_NOT_STARTED } },
			}),
			QuestFactory.Script(function(missionState)
				local neckUpdateStorages = {
					[Storage.SultanPrime.Mission01] = 1,
				}
				local questStorage = Storage.SultanPrime.Mission01

				local corpse = Action()
				function corpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if player:getStorageValueByKey(questStorage) ~= MISSION_NOT_STARTED then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
						return
					end

					player:AddItems({ QuestKeyItems.SultanPrime.Amulet })
					player:NextState(neckUpdateStorages)
					return true
				end
				corpse:key(Storage.SultanPrime.Necklace)
				corpse:register()
			end)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission01.ConsultSultanAboutAmulet,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Adventurer |PLAYERNAME|... I was watching you proceed through that dungeon and beat all the deadly traps. You might have something that I value. Precisely that {amulet} that u took from Cezary Baryka.",
					nextState = {
						[Storage.SultanPrime.Mission01] = QuestState.SultanPrime.Mission01.TradeAmuletWithSultan,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SultanPrime.Mission01.TradeAmuletWithSultan,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Adventurer |PLAYERNAME|... I was watching you proceed through that dungeon and beat all the deadly traps. You might have something that I value. Precisely that {amulet} that u took from Cezary Baryka.",
				},
				[{ "mission", "amulet", "naszyjnik" }] = {
					text = "Thanks for your cooperation. Now if you don't mind, i have a {mission} for you.",
					requiredItems = { QuestKeyItems.SultanPrime.Amulet },
					textNoRequiredItems = "Ehh, you lost it? Guess Imma take over the world in next season.",
					nextState = {
						[Storage.SultanPrime.Mission01] = QuestState.SultanPrime.Mission01.Finished,
						[Storage.SultanPrime.Mission02] = QuestState.SultanPrime.Mission02.AskSultanForFirstTask,
					},
				},
			})
	end)
	:Mission(Storage.SultanPrime.Mission02)
	:State(function()
		return QuestState.SultanPrime.Mission02.AskSultanForFirstTask,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "My favorite follower, |PLAYERNAME|. You came for new {mission}?",
				},
				[{ "mission", "yes", "tak" }] = {
					text = "I don't think I told you about this, but I have a plan to take over and rule the world. That amulet will surely help me, but I still would not mind gaining new allies. I'm currently trying to convince mages, warriors, animals and other inferior beings. Your first task will be to poison magicians' water source. They rejected my will and ridiculed my proposal for an alliance.",
					nextState = {
						[Storage.SultanPrime.Mission02] = QuestState.SultanPrime.Mission02.PoisonMagiciansWell,
					},
					rewards = { QuestKeyItems.SultanPrime.Bottle },
				},
			})
	end)
	:State(function()
		return QuestState.SultanPrime.Mission02.PoisonMagiciansWell,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Hi again, |PLAYERNAME|. Did you complete the mission?",
				},
			}),
			QuestFactory.Script(function(missionState)
				local function isUsingBottleOnFountain(target)
					if not target then
						return false
					end
					if not (target:getActionId() == Storage.SultanPrime.MagicianFountain) then
						return
					end
					if target:getId() == QuestKeyItems.SultanPrime.Bottle.id then
						return
					end
				end

				local taintBottle = Action()
				function taintBottle.onUse(player, bottle, fromPosition, target, toPosition, isHotkey)
					local storage_val = player:getStorageValueByKey(Storage.SultanPrime.Mission02)
					if storage_val ~= 2 then
						return false
					end

					if not isUsingBottleOnFountain(target) then
						return false
					end

					player:RemoveItems({ QuestKeyItems.SultanPrime.Bottle })
					player:setStorageValueByKey(Storage.SultanPrime.Mission02, QuestState.SultanPrime.Mission02.AskSultanForCamelTask)
					player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
					target:getPosition():sendMagicEffect(CONST_ME_PLANTATTACK)
					return true
				end

				taintBottle:key(Storage.SultanPrime.MagicianFountain)
				taintBottle:register()
			end)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission02.AskSultanForCamelTask,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Hi, |PLAYERNAME|. Did you manage to compelte your first task?",
				},
				[{ "mission", "yes", "tak" }] = {
					text = "Good job. Now we will take care of a certain farmer from the steppes. Dampreefer is a hermit. I offered for him to join me, but he refused. Go to his farm and cull his farm animals. This should make him commit a suicide. Dampreefer is very poor, so you might need to help him with that. Maybe Leroy Merlin rope $6.99/meter?",
					nextState = {
						[Storage.SultanPrime.Mission02] = QuestState.SultanPrime.Mission02.KillCamels,
						[Storage.SultanPrime.DromedaryCount] = 0,
					},
				},
			})
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Dampreefer Dromedary")
		local monster = {}

		monster.description = "a dromedary"
		monster.experience = 0
		monster.outfit = {
			lookType = 404,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.raceId = 733
		monster.Bestiary = {
			class = "Mammal",
			race = BESTY_RACE_MAMMAL,
			toKill = 250,
			FirstUnlock = 10,
			SecondUnlock = 100,
			CharmsPoints = 5,
			Stars = 1,
			Occurrence = 0,
			Locations = "Ankrahmun near the way to Darashia, Ankrahmun near sea, around Darashia, Issavi.",
		}

		monster.health = 45
		monster.maxHealth = 45
		monster.race = "blood"
		monster.corpse = 12539
		monster.speed = 57
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4000,
			chance = 20,
		}

		monster.strategiesTarget = {
			nearest = 100,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = false,
			convinceable = false,
			pushable = true,
			rewardBoss = false,
			illusionable = true,
			canPushItems = false,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 4,
			runHealth = 45,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.events = {
			"DampreeferDromedaryDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
			{ text = "Snort", yell = false },
			{ text = "Grunt!", yell = false },
		}

		monster.loot = {
			{ name = "meat", chance = 36000, maxCount = 2 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -8 },
			{ name = "drunk", interval = 4000, chance = 5, range = 1, shootEffect = CONST_ANI_EXPLOSION, effect = CONST_ME_STUN, target = true, duration = 6000 },
		}

		monster.defenses = {
			defense = 5,
			armor = 4,
			mitigation = 0.15,
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = false },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission02.KillCamels,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Dampreefer farm is located near pirates' yard on the steppes.",
				},
			}),
			QuestFactory.Dialog("Dampreefer", {
				[{ GREET }] = {
					text = "Hello stranger. Its been a moment since the last time i had a visitors. My farm is self-sufficient, so i cant complain about food shortage. Thanks to my {dromedaries}, i dont lack entertainment either.",
				},
				[{ "wielbladom", "dromedaries" }] = {
					text = "I found them when i was on a espionage in Kansas. When i was diving through one of the local villages, i saw a {herd} of eight dromedaries being sold. I decreatureed to stop by and check on them. Without further hesitation i decreatureed to buy all of them when i'm done with my mission. Around that time i retired and settled {here}.",
				},
				[{ "miejscu", "here" }] = {
					text = "Given my visa was temporary i didnt expect for it to be extended. I decreatureed to take it from there and live in this place, not Kansas.",
				},
				[{ "stado", "herd" }] = {
					text = "Now its just six of them. {Date} and {Guci} aren't there anymore. Long time ago, a wield creature appeared on my farm. It resembled some weird amalgamation of flowers and vines floating above ground. This thing demanded me to comply to his will and {join} his quest to take over the world.",
				},
				[{ "pomogl", "join" }] = {
					text = "He didnt tolerate my refusal and with one swing it killed {Date} and {Gucci}",
				},
				[{ "gucia", "gucci" }] = {
					text = "Gucci was my favorite one. He was exceptionally intelligenc and he was capable of painting with brush by holding between it's teeth. With his experience he could fill children coloring books.",
				},
				[{ "daktyl", "date" }] = {
					text = "If i recall correctly, Date was the fastest dromedary i ever saw. I think that i was to compete in equestrian competition, i would pick him.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local updateStorages = {
					[Storage.SultanPrime.Mission02] = QuestState.SultanPrime.Mission02.ProvideDampreeferWithRope,
				}
				local requiredCamelKills = 6

				local DampreeferDromedaryDeath = CreatureEvent("DampreeferDromedaryDeath")
				function DampreeferDromedaryDeath.onDeath(creature)
					local targetMonster = creature:getMonster()
					if not targetMonster or targetMonster:getMaster() then
						return true
					end

					onDeathForDamagingPlayers(creature, function(creature, player)
						local storage_val = player:getStorageValueByKey(Storage.SultanPrime.Mission02)
						if storage_val ~= QuestState.SultanPrime.Mission02.KillCamels then
							return true
						end

						player:IncrementStorage(Storage.SultanPrime.DromedaryCount, 1)
						player:RefreshStorage(Storage.SultanPrime.Mission02)

						if player:getStorageValueByKey(Storage.SultanPrime.DromedaryCount) >= requiredCamelKills then
							player:NextState(updateStorages)
						end
					end)
					return true
				end
				DampreeferDromedaryDeath:register()
			end)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission02.ProvideDampreeferWithRope,
			QuestFactory.Dialog("Dampreefer", {
				[{ GREET }] = {
					text = "What in damnation!? What did you do. I dont {feel} like.",
				},
				[{ "chce", "feel" }] = {
					text = "Just put the rope on the table. I will serve myself.",
				},
			}),
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Dampreefer farm is located near pirates' yard on the steppes.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local chair = MoveEvent()
				function chair.onAddItem(maybeRope, tileitem, position)
					if not maybeRope then
						return false
					end
					local id = maybeRope:getId()
					if id ~= 3003 then
						return false
					end

					maybeRope:remove()

					local players = CreatureList():RadiusSquare(position, 5, 5):FilterByPlayer()
					for _, player in pairs(players) do
						if player:HasExactMissionState(missionState) then
							player:setStorageValueByKey(Storage.SultanPrime.Mission02, QuestState.SultanPrime.Mission02.ReportToSultan)
						end
					end

					Game.createItem(18114, 1, position)
					return true
				end
				chair:type("additem")
				chair:key(Storage.SultanPrime.FarmerChair)
				chair:register()
			end)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission02.ReportToSultan,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Welcome again, |PLAYERNAME|. Have you succeeded in the last task I entrusted to you?",
				},
				[{ "mission", "yes", "tak" }] = {
					text = "Great, he got exactly what he deserved. Now a new mission - go back in time to the mirkotown 20 years ago. In the meantime, I'm gonna do my business on the other battlefront, and I will leave my hologram here. I will provide details to your mission in your quest log.",
					nextState = {
						[Storage.SultanPrime.Mission02] = QuestState.SultanPrime.Mission02.Finished,
						[Storage.SultanPrime.Mission03] = QuestState.SultanPrime.Mission03.OpenCoffins,
						[Storage.SultanPrime.CoffinCount] = 0,
					},
				},
			})
	end)
	:Mission(Storage.SultanPrime.Mission03)
	:State(function()
		return QuestState.SultanPrime.Mission03.OpenCoffins,
			QuestFactory.Script(function(missionState)
				local retroMirkoPos = RETRO_MIRKO_ANCHOR:Moved({ x = -46, y = -68, z = -2 })

				local lever = Action()
				function lever.onUse(creature, item, fromPosition, itemEx, toPosition)
					local player = creature:getPlayer()
					if not player:isPlayer() then
						return false
					end
					if player:getStorageValueByKey(Storage.SultanPrime.Mission03) == MISSION_NOT_STARTED then
						return true
					end

					player:teleportTo(retroMirkoPos)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end
				lever:key(Storage.SultanPrime.RetroLever)
				lever:register()
			end),
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local coffin = Action()
				function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not target then
						return false
					end
					if not player:HasExactMissionState(missionState) then
						return
					end

					Game.createItem(2121, 1, toPosition)
					player:IncrementStorage(Storage.SultanPrime.CoffinCount, 1)
					player:RefreshStorage(Storage.SultanPrime.Mission03)

					if (player:getStorageValueByKey(Storage.SultanPrime.CoffinCount)) == SULTAN_PRIME_RETRO_MIRKO.requiredCoffinCount then
						player:setStorageValueByKey(Storage.SultanPrime.CorpseCount, 0)
						player:setStorageValueByKey(Storage.SultanPrime.Mission03, QuestState.SultanPrime.Mission03.ThrowBodies)
					end
					return true
				end
				coffin:key(Storage.SultanPrime.Coffin)
				coffin:register()
			end)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission03.ThrowBodies,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local successMessages = {
					"Om nom nom",
					"Smack smack",
					"Mmmmm",
				}
				local failMessages = {
					"Ewwww",
					"Urgh",
					"Nnghhhh",
				}
				local function randomMessageOnSuccess()
					return successMessages[math.random(1, #successMessages)]
				end
				local function randomMessageOnFail()
					return failMessages[math.random(1, #failMessages)]
				end
				local tentacleMonster = nil

				local eatingJaw = MoveEvent()
				function eatingJaw.onAddItem(corpse, tile, position)
					if not corpse then
						return
					end

					local threwBody = SULTAN_PRIME_RETRO_MIRKO.corpseId[corpse:getId()]
					if not threwBody then
						tentacleMonster:say(randomMessageOnFail())
					end

					tentacleMonster:say(randomMessageOnSuccess())

					local playerPos = tile:getPosition():Moved(2, 0, -1)
					local player = Tile(playerPos):getTopCreature()
					if not player then
						return
					end

					if not player:HasExactMissionState(missionState) then
						return false
					end

					player:IncrementStorage(Storage.SultanPrime.CorpseCount)
					player:RefreshStorage(Storage.SultanPrime.Mission03)

					if player:getStorageValueByKey(Storage.SultanPrime.CorpseCount) >= SULTAN_PRIME_RETRO_MIRKO.requiredCorpseCount then
						player:setStorageValueByKey(Storage.SultanPrime.Mission03, QuestState.SultanPrime.Mission03.GetRidOfAspirantRyba)
					end
					return true
				end

				eatingJaw:type("additem")
				eatingJaw:key(Storage.SultanPrime.Jaw)
				eatingJaw:register()

				local tentaclyJawPos = RETRO_MIRKO_ANCHOR:Moved({ -9, -11, 0 })
				
				local tentacleSpawn = GlobalEvent("SultanPrimeTentacle")
				function tentacleSpawn.onStartup()
					tentacleMonster = Tile(tentaclyJawPos):getTopCreature()
					tentacleMonster:setInvulnerable()
				end
				tentacleSpawn:register()
			end)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission03.GetRidOfAspirantRyba,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local ryba = CreatureEvent("RybaKill")

				function ryba.onDeath(creature)
					onDeathForDamagingPlayers(creature, function(creature, player)
						local storage_val = player:getStorageValueByKey(Storage.SultanPrime.Mission03)
						if storage_val ~= QuestState.SultanPrime.Mission03.GetRidOfAspirantRyba then
							return true
						end
						player:setStorageValueByKey(Storage.SultanPrime.Mission03, QuestState.SultanPrime.Mission03.ReportToSultan)
						player:setStorageValueByKey(Storage.SultanPrime.DoorAfterRyba, ACCESS_GRANTED)
					end)
					return true
				end

				ryba:register()
			end)
	end)
	:State(function()
		return QuestState.SultanPrime.Mission03.ReportToSultan,
			QuestFactory.Dialog("Sultan of Phantasms", {
				[{ GREET }] = {
					text = "Whaaat, Ryba escaped? Undead king perished? What kind of villain are you?",
				},
				[{ "mission" }] = {
					text = "What else? Take this amulet and stick it up in your ass.",
					nextState = {
						[Storage.SultanPrime.Mission03] = QuestState.SultanPrime.Mission03.AskNatanekForHelp,
					},
					rewards = { QuestKeyItems.SultanPrime.Amulet },
				},
			})
	end)
	:State(function()
		return QuestState.SultanPrime.Mission03.AskNatanekForHelp,
			QuestFactory.Dialog("Father Natanek", {
				[{ "mission", "misja", "naszyjnik", "amulet", "necklace" }] = {
					text = "I'd prefer this information to stay between us. Let's agree that you'll take what I received from the faithful today, and in exchange, you'll forget what Sultan showed you.",
				},
				[{ "dostalem", "donated" }] = {
					text = "Here, this is your reward.",
					nextState = {
						[Storage.SultanPrime.Mission03] = QuestState.SultanPrime.Mission03.AskNatanekForHelp,
						[Storage.Finished.SultanPrime] = MISSION_FINISHED,
					},
					rewards = { { id = 3043, count = 2 } },
					expReward = 800000,
				},
			})
	end)
	:Register()
