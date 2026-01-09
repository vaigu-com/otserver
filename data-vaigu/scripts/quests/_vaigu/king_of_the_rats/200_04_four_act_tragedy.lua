local quest = Quest(LOCALIZERS.FourActTragedy)

local unstableExplosionCombat = Combat()
unstableExplosionCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
unstableExplosionCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
unstableExplosionCombat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
unstableExplosionCombat:setParameter(COMBAT_PARAM_USECHARGES, 1)
unstableExplosionCombat:setArea(createCombatArea(AREA_CIRCLE3X3))

quest
	:Storage(function()
		Storage.FourActTragedy = {
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Portals = {
				ToRetro = {},
				ToPresent = {},
				AfterKraken = {},
				ToKolumb = {},
				AfterZulSzczurow = {},
			},
			Rewards = {
				GrazynaCore = {},
				Fanfare = {},
				Powder = {},
				TimmyBag = {},
				SlippersChest = {},
			},
			RetroKnurowoAccess = {},
			FanfareLever = {},
			WawelDragonAccess = {},
			LeviathanAccess = {},
			SlippersTorch = {},
			SlippersGravestone = {},
			SkurwiwijAccess = {},
			GrazhenaDoor = {},
			RatBumHole = {},
			CultScroll = {},
		}
		QuestState.FourActTragedy = {
			Mission01 = {
				AskRomekForMission = 1,
				NegotiateWithTurdstin = 2,
				ReportToRomek = 3,
			},
			Mission02 = {
				FindSomeoneInKnurow = 1,
				FindTimmyEquipment = 2,
				ReturnEquipmentToTimmy = 3,
				FindMagicDust = 4,
				ReportToRomek = 5,
			},
			Mission03 = {
				FindAndKillLewiatan = 1,
				ReportToRomek = 2,
			},
			Mission04 = {
				FindBribeslippers = 1,
				BringSlippersToRomek = 2,
				FindAndKillSkurwiwij = 3,
				ReportToRomek = 4,
			},
			Mission05 = {
				FindXena = 1,
				FindGrazhena = 2,
				KillRatBum = 3,
				ReportToRomek = 4,
			},
		}
	end)
	:Constant(function()
		GlobalFunctions.FourActTragedy = {}
		QuestKeyItems.FourActTragedy = {
			TimmyPowder = {
				id = 6548,
				key = Storage.FourActTragedy.Rewards.Powder,
				desc = "Elvish dust. Timmy might be needing this",
			},
			TimmyBag = {
				id = 3141,
				key = Storage.FourActTragedy.Rewards.TimmyBag,
				desc = "Timmy belongings. He might be needing them",
			},
			Fanfare = {
				id = 2954,
				desc = "Mysterius instrument. Most curious monsters can it allure. Put it down on the stone and play...",
			},
			GrazynaCore = {
				id = 20342,
				key = Storage.FourActTragedy.Rewards.GrazynaCore,
				desc = "Grazhena Core i3",
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Four Act Tragedy",
			localizer = localizer,
			missions = {
				{
					name = "01. Dodge those compensation claims",
					storage = Storage.FourActTragedy.Mission01,
					states = {
						[QuestState.FourActTragedy.Mission01.AskRomekForMission] = "Romek mentioned you should as him for mission.",
						[QuestState.FourActTragedy.Mission01.NegotiateWithTurdstin] = "Go to HF-P/X agent - turdstin.",
						[QuestState.FourActTragedy.Mission01.ReportToRomek] = "Return to romek and talk to him about HF-P/X case.",
						[MISSION_FINISHED] = "Romek sent you to Knurow. Try to find a way to go back in time there.",
					},
				},
				{
					name = "02. Bottom tex_L",
					storage = Storage.FourActTragedy.Mission02,
					states = {
						[QuestState.FourActTragedy.Mission02.FindSomeoneInKnurow] = "Find someone who can show you around.",
						[QuestState.FourActTragedy.Mission02.FindTimmyEquipment] = "Timmy asked you to find his equipment that was stolen by bandits.",
						[QuestState.FourActTragedy.Mission02.ReturnEquipmentToTimmy] = "You found timmy belongings. Return to him and give them back.",
						[QuestState.FourActTragedy.Mission02.FindMagicDust] = "Timmy needs elvish dust to perform his magic. Try finding it on nearby mountain.",
						[QuestState.FourActTragedy.Mission02.ReportToRomek] = "Timmy told you that he will already have helped you in the future. Go back to Romek.",
						[MISSION_FINISHED] = "You told romek about Timmy work.",
					},
				},
				{
					name = "03. Master Baitor",
					storage = Storage.FourActTragedy.Mission03,
					states = {
						[QuestState.FourActTragedy.Mission03.FindAndKillLewiatan] = "Romek asked you to buy him a beer at nearby Lewiatan.",
						[QuestState.FourActTragedy.Mission03.ReportToRomek] = "You defeated the kraken. Go back to Romek.",
						[MISSION_FINISHED] = "Find slippers bitten by the Rat Bum. Romek mentioned northern rat collaborators as his allies.",
					},
				},
				{
					name = "04. Non omnis moriar",
					storage = Storage.FourActTragedy.Mission04,
					states = {
						[QuestState.FourActTragedy.Mission04.FindBribeslippers] = "Find slippers bitten by the Rat Bum. Romek mentioned northern rat collaborators as his allies.",
						[QuestState.FourActTragedy.Mission04.BringSlippersToRomek] = "You found the Bribeslippers. Report back to Romek.",
						[QuestState.FourActTragedy.Mission04.FindAndKillSkurwiwij] = "Romek told you to follow the trail leading to the frog cult altar. Search the northern kongo.",
						[QuestState.FourActTragedy.Mission04.ReportToRomek] = "You defeated the Skurwiwij. Report back to Romek.",
						[MISSION_FINISHED] = "Ask Xena for possible usage of Grazhenacore.",
					},
				},
				{
					name = "05. Sic transit gloria mundi",
					storage = Storage.FourActTragedy.Mission05,
					states = {
						[QuestState.FourActTragedy.Mission05.FindXena] = "Ask Xena for possible usage of Grazhenacore.",
						[QuestState.FourActTragedy.Mission05.FindGrazhena] = "Try to find Grazhena deep under Hero caves.",
						[QuestState.FourActTragedy.Mission05.KillRatBum] = "Rat Bum ran away to his cave. Chase him!",
						[QuestState.FourActTragedy.Mission05.ReportToRomek] = "You defeated the Rat Bum. Go back to Romek.",
						[MISSION_FINISHED] = "You helped Romek in dealing with Rat Bum. He rewarded you for your effort.",
					},
				},
			},
		})
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.FourActTragedy.Mission03] = QuestState.FourActTragedy.Mission03.ReportToRomek,
		}

		local krakenDeath = CreatureEvent("TheKrakenDeath")

		function krakenDeath.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValueByKey(Storage.FourActTragedy.Mission03) ~= QuestState.FourActTragedy.Mission03.FindAndKillLewiatan then
					return true
				end

				player:NextState(nextState)
			end)
			return true
		end

		krakenDeath:register()
	end)
	:MonsterEvent(function()
		local wawelDragon = CreatureEvent("WawelDragonDeath")

		function wawelDragon.onDeath(creature)
			local deathPos = creature:getPosition()
			local corpse = Game.createItem(31649, 1, deathPos)
			corpse:setKey(Storage.FourActTragedy.Rewards.TimmyBag)
			return true
		end

		wawelDragon:register()
	end)
	:MonsterEvent(function()
		local selfDelete = Spell("instant")
		function selfDelete.onCastSpell(creature, var)
			creature:addHealth(-creature:getMaxHealth())
		end
		selfDelete:name("skurwiwij unstable self delete")
		selfDelete:words("###600")
		selfDelete:isAggressive(true)
		selfDelete:blockWalls(true)
		selfDelete:needLearn(true)
		selfDelete:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Unstable Ember")
		local monster = {}

		monster.description = "an Unstable Ember"
		monster.experience = 0
		monster.outfit = {
			lookType = 242,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 10000
		monster.maxHealth = 10000
		monster.race = "blood"
		monster.speed = 400
		monster.manaCost = 0

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
			{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -120, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
			{ name = "skurwiwij unstable self delete", interval = 2000, chance = 100, target = true, range = 1 },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
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
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = true },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Unstable Energy")
		local monster = {}

		monster.description = "an Unstable Energy"
		monster.experience = 0
		monster.outfit = {
			lookType = 290,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 10000
		monster.maxHealth = 10000
		monster.race = "blood"
		monster.speed = 400
		monster.manaCost = 0

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
			{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -120, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
			{ name = "skurwiwij unstable self delete", interval = 2000, chance = 100, target = true, range = 1 },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
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
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = true },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Skurwiwij")
		local monster = {}

		monster.description = "a Skurwiwij"
		monster.experience = 50000
		monster.outfit = {
			lookType = 544,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 10000
		monster.maxHealth = 10000
		monster.race = "undead"
		monster.speed = 400
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
			pushable = false,
			rewardBoss = true,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 100,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.events = {
			"SkurwiwijDeath",
		}

		monster.voices = {}

		monster.loot = {
			{ id = 32620, chance = 9000 },
			{ id = 22721, chance = 33000, maxCount = 3 },
			{ id = 19357, chance = 7000 },
			{ id = 23527, chance = 19000 },
			{ id = 30323, chance = 3000 },
			{ id = 35521, chance = 3000 },
			{ id = 35522, chance = 3000 },
			{ id = 35518, chance = 3000 },
			{ id = 35515, chance = 4500 },
			{ id = 20086, chance = 4000 },
			{ id = 9019, chance = 2000 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
			{ name = "skurwiwij stackable damage", interval = 1000, chance = 100, target = true, range = 7 },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
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
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = true },
		}

		mType:register(monster)
	end)
	:MonsterEvent(function()
		local skurwiwijStackableDamage = Spell("instant")
		function skurwiwijStackableDamage.onCastSpell(creature, var)
			GlobalFunctions.FourActTragedy.CastStackingDamageSpell(creature, var)
		end
		skurwiwijStackableDamage:name("skurwiwij stackable damage")
		skurwiwijStackableDamage:words("###602")
		skurwiwijStackableDamage:isAggressive(true)
		skurwiwijStackableDamage:blockWalls(true)
		skurwiwijStackableDamage:needTarget(true)
		skurwiwijStackableDamage:needLearn(true)
		skurwiwijStackableDamage:register()
	end)
	:MonsterEvent(function()
		local zulZulowDeath = CreatureEvent("ZulZulowDeath")
		function zulZulowDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			local deathPos = creature:getPosition()
			local name = creature:getName()

			addEvent(function()
				for _ = 1, 2 do
					Game.createMonster(name, deathPos)
				end
			end, 1500)
			return true
		end

		zulZulowDeath:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Wawel Dragon")
		local monster = {}

		monster.description = "a Wawel Dragon"
		monster.experience = 4999
		monster.outfit = {
			lookType = 1190,
			lookHead = 143,
			lookBody = 121,
			lookLegs = 63,
			lookFeet = 25,
		}

		monster.health = 3500
		monster.maxHealth = 3500
		monster.speed = 100
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 3500,
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
			staticAttackChance = 20,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.events = {
			"WawelDragonDeath",
		}

		monster.voices = {
			interval = 4999,
			chance = 10,
		}

		monster.loot = {
			{ name = "demonic essence", chance = 100000, maxCount = 2 },
			{ id = 4086, chance = 100000 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -420 },
			{
				name = "combat",
				interval = 1245,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -180,
				maxDamage = -220,
				range = 7,
				radius = 4,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREAREA,
				target = true,
			},
			{
				name = "combat",
				interval = 1787,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -180,
				maxDamage = -220,
				range = 7,
				radius = 4,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREAREA,
				target = true,
			},
			{
				name = "combat",
				interval = 1345,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -180,
				length = 8,
				spread = 3,
				effect = CONST_ME_FIREAREA,
				target = false,
			},
			{
				name = "combat",
				interval = 1962,
				chance = 30,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -180,
				length = 8,
				spread = 3,
				effect = CONST_ME_FIREAREA,
				target = false,
			},
			{
				name = "firefield",
				interval = 2000,
				chance = 40,
				range = 7,
				radius = 4,
				shootEffect = CONST_ANI_FIRE,
				target = true,
			},
		}

		monster.defenses = {
			defense = 25,
			armor = 25,
			{
				name = "combat",
				interval = 2000,
				chance = 25,
				type = COMBAT_HEALING,
				minDamage = 100,
				maxDamage = 500,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 100 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = -10 },
			{ type = COMBAT_HOLYDAMAGE, percent = -25 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Mission(Storage.FourActTragedy.Mission01)
	:State(function()
		return QuestState.FourActTragedy.Mission01.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja","task","zadanie" }] = {
					text = "Ehh... before I tell you what's next, we need to deal with the HF-P/X insurance agent. You probably know him - they call him Turdstin.",
					nextState = {
						[Storage.FourActTragedy.Mission01] = QuestState.FourActTragedy.Mission01.NegotiateWithTurdstin,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission01.NegotiateWithTurdstin,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Turdstin lives in the slums, Mirko. His life professions include homelessness, MGTOW, collecting cans, and being an insurance agent.",
				},
			}),
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "mission", "misja" }] = {
					text = "Good day person |PLAYERNAME|. We are here to {discuss} compensation claims related to the 'accident' in which Mr. HF-P/X was injured.",
				},
				[{ "omowic", "discuss" }] = {
					text = "According to our information, you {was} the main cause of the accident that resulted in Mr. HF-P/X's injuries.",
				},
				[{ "byl", "was" }] = {
					text = "In that case, please send the documents, and our team of specialists shh butt butt butt kshhhh. Oh, damn, my throat recorder broke. Umm... okay, I was lying about the insurance. But understand me - ever since the emperor took my lands, I have to fight for them, which has made me even more homeless.",
					nextState = {
						[Storage.FourActTragedy.Mission01] = QuestState.FourActTragedy.Mission01.ReportToRomek,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission01.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Well, hes just the smartest person in the world. Okay, let's not waste any more time. After HF-P/X's death, a time-delayed mechanism was activated, which opened a portal to the past. Now immigrants are flooding in from everywhere. Go to the portal in Knurow and head to the Knurow of the past. Find someone there who will help you with the task of stopping the influx of immigrants.",
					nextState = {
						[Storage.FourActTragedy.Mission01] = MISSION_FINISHED,
						[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.FindSomeoneInKnurow,
						[Storage.FourActTragedy.RetroKnurowoAccess] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:Mission(Storage.FourActTragedy.Mission02)
	:State(function()
		return QuestState.FourActTragedy.Mission02.FindSomeoneInKnurow,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "I told you to use the portal in Knurow, although I don't remember exactly where it was located. Something tells me it was somewhere along the shore...",
				},
			}),
			QuestFactory.Dialog("Woody", {
				[{ "portal", "teleport", "retro", "past", "przeszlosc" }] = {
					text = "Back when i was young we sat around the fireplace and we could teleport anywhere using power of our imagination.",
				},
			}),
			QuestFactory.Dialog("Timmy", {
				[{ "mission", "misja" }] = {
					text = "It seems I got lost in the corridors of time. I have vague memories from the future that I am a bouncer in my hometown. I think I could help you with the immigrant influx, but first, I need to reconcile with my present self. Find my equipment stolen by bandits, and I will help you.",
					nextState = {
						[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.FindTimmyEquipment,
						[Storage.FourActTragedy.WawelDragonAccess] = ACCESS_GRANTED,
					},
				},
			}),
			QuestFactory.Script(function(missionState)
				local toModern = Position(5513, 1554, 7)
				local toRetro = RETRO_KNUROWO_ANCHOR:Moved(-63, -9, 0)

				local tpToRetro = MoveEvent()
				function tpToRetro.onStepIn(player, item, position, fromPosition)
					if not player:isPlayer() then
						return true
					end

					if player:getStorageValueByKey(Storage.FourActTragedy.RetroKnurowoAccess) ~= ACCESS_GRANTED then
						return false
					end
					player:teleportTo(toRetro)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				tpToRetro:type("stepin")
				tpToRetro:key(Storage.FourActTragedy.Portals.ToRetro)
				tpToRetro:register()

				local tpToModern = MoveEvent()
				function tpToModern.onStepIn(player, item, position, fromPosition)
					if not player:isPlayer() then
						return true
					end

					if player:getStorageValueByKey(Storage.FourActTragedy.RetroKnurowoAccess) ~= ACCESS_GRANTED then
						return false
					end
					player:teleportTo(toModern)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				tpToModern:type("stepin")
				tpToModern:key(Storage.FourActTragedy.Portals.ToPresent)
				tpToModern:register()
			end)
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission02.FindTimmyEquipment,
			QuestFactory.Dialog("Timmy", {
				[{ "mission", "misja" }] = {
					text = "I don't know where they moved my stuff to.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local beastId = nil

				local spawnPos = RETRO_KNUROWO_ANCHOR:Moved(-26, -28, 6)
				local fanfareSacrificePos = RETRO_KNUROWO_ANCHOR:Moved(-29, -34, 6):Moved(-2, 0, 0)

				local panpipeLever = Action()
				function panpipeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end
					if Creature(beastId) then
						return
					end

					local fanfare = Tile(fanfareSacrificePos):getItemById(QuestKeyItems.FourActTragedy.Fanfare.id)

					if not fanfare then
						return false
					end
					if player:getStorageValueByKey(Storage.FourActTragedy.Mission02) ~= QuestState.FourActTragedy.Mission02.FindTimmyEquipment then
						return false
					end

					beastId = Game.createMonster("Wawel Dragon", spawnPos):getId()
					player:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
					return true
				end

				panpipeLever:key(Storage.FourActTragedy.FanfareLever)
				panpipeLever:register()
			end),
			QuestFactory.OnUseDeclarations({
				{
					id = 31649,
					key = Storage.FourActTragedy.Rewards.TimmyBag,
					rewards = { QuestKeyItems.FourActTragedy.TimmyBag },
					nextState = {
						[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.ReturnEquipmentToTimmy,
					},
				},
			}),
			QuestFactory.OnUseDeclarations({
				{

					id = 11809,
					key = Storage.FourActTragedy.Rewards.Fanfare,
					rewards = { QuestKeyItems.FourActTragedy.Fanfare },
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission02.ReturnEquipmentToTimmy,
			QuestFactory.Dialog("Timmy", {
				[{ "mission", "misja" }] = {
					text = "Thank you, that's mine. Okay, now I'm going back to the {present}!",
					requiredItems = {
						QuestKeyItems.FourActTragedy.TimmyBag,
					},
					textNoRequiredItems = "Are you sure you didn't lose any of my stuff along the way?",
					nextState = {
						[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.FindMagicDust,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission02.FindMagicDust,
			QuestFactory.Dialog("Timmy", {
				[{ "mission", "present", "terazniejszosci" }] = {
					text = "Tell Tomek that I will deal with those refugees as soon as I can. Actually, I've already dealt with them. Yeah, the paradoxes of time travel. And one more thing: the person responsible for convincing immigrants to use the HF-P/X portal was none other than Rat Bum.",
					requiredItems = {
						QuestKeyItems.FourActTragedy.TimmyPowder,
					},
					textNoRequiredItems = "My magic doesn't seem to work. We'll need elven spells. Go to the elves' rock and get some magical powder that I can use for the ritual. Watch out for the dormant Soros foundations. I've seen that they too got lost in this world.",
					nextState = {
						[Storage.FourActTragedy.Mission02] = QuestState.FourActTragedy.Mission02.ReportToRomek,
					},
				},
			}),
			QuestFactory.OnUseDeclarations({
				{

					id = 4073,
					key = Storage.FourActTragedy.Rewards.Powder,
					rewards = {
						QuestKeyItems.FourActTragedy.TimmyPowder,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission02.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "So, it's Rat Bum. Hmm, but in the memes, it said that Rat Bum can't do anything. I know his origin. I would like to tell you where to find him, but currently he is protected by a narrative armor. So, I suggest you go get some beer at Lewiatan now.",
					nextState = {
						[Storage.FourActTragedy.Mission02] = MISSION_FINISHED,
						[Storage.FourActTragedy.Mission03] = QuestState.FourActTragedy.Mission03.FindAndKillLewiatan,
						[Storage.FourActTragedy.LeviathanAccess] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:Mission(Storage.FourActTragedy.Mission03)
	:Monster(function()
		local mType = Game.createMonsterType("Great Leviathan")
		local monster = {}

		monster.description = "the Great Leviathan"
		monster.experience = 200000
		monster.outfit = {
			lookTypeEx = 11336,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 100000
		monster.maxHealth = 100000
		monster.race = "blood"
		monster.speed = 0
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
			pushable = false,
			rewardBoss = true,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.events = {
			"GreatLeviathanDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {
			{ id = 8853, chance = 25000 },
			{ id = 14142, chance = 2500 },
			{ id = 12318, chance = 3000 },
			{ id = 32043, chance = 37000, maxCount = 5 },
			{ id = 901, chance = 14000 },
			{ id = 902, chance = 11000 },
			{ id = 32621, chance = 10000 },
			{ id = 8056, chance = 8000 },
			{ id = 9303, chance = 28000 },
			{ id = 39235, chance = 2000 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -700 },
			{ name = "combat", interval = 1000, chance = 7, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -200, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_POFF, target = false },
			{ name = "combat", interval = 1000, chance = 13, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -300, radius = 8, effect = CONST_ME_LOSEENERGY, target = false },
			{ name = "combat", interval = 1000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -300, radius = 8, effect = CONST_ME_MAGIC_GREEN, target = false },
			{ name = "combat", interval = 1000, chance = 34, type = COMBAT_FIREDAMAGE, minDamage = -100, maxDamage = -200, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
			{ name = "combat", interval = 1000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -50, maxDamage = -150, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
			{ name = "combat", interval = 1000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -50, maxDamage = -150, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
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
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission03.FindAndKillLewiatan,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "If you don't know where to find the nearest Lewiatan, ask Christopher Columbus.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local toKolumb = Position(5909, 1233, 6)

				local tpToKolumb = MoveEvent()
				function tpToKolumb.onStepIn(player, item, position, fromPosition)
					if not player:isPlayer() then
						return true
					end

					player:teleportTo(toKolumb)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				tpToKolumb:type("stepin")
				tpToKolumb:key(Storage.FourActTragedy.Portals.ToKolumb)
				tpToKolumb:register()
			end)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Ship health")
		local monster = {}

		monster.description = "Ship health"
		monster.experience = 0
		monster.outfit = {
			lookTypeEx = 4940,
			lookType = 0,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.faction = FACTION_PLAYER

		monster.health = 30000
		monster.maxHealth = 30000
		monster.race = "undead"
		monster.speed = 0

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 100,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.events = {
			"ShipHealthDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = 0 },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
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
	:Monster(function()
		local mType = Game.createMonsterType("Kraken tentacles")
		local monster = {}

		monster.description = "a Kraken tentacle"
		monster.experience = 0
		monster.outfit = {
			lookTypeEx = 11350,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 40000
		monster.maxHealth = 40000
		monster.race = "blood"
		monster.speed = 0
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 3717,
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
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -200 },
			{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -120, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
		}

		monster.defenses = {
			defense = 5,
			armor = 5,
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
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = true },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = true },
		}

		mType.onSpawn = function(monster, creature)
			monster:setOutfit({ lookTypeEx = 11351 })
		end

		mType:register(monster)
	end)
	:EncounterData(function(missionState)
		local leviathanEncounter = EncounterData({
			displayName = "Leviathan's Domain",
			encounterId = "LEVIATHAN",
			bossName = "Great Leviathan",

			requiredState = { [Storage.FourActTragedy.LeviathanAccess] = ACCESS_GRANTED },

			lockoutExpiryTime = LOCKOUT_EXPIRY_TIME.WEEKLY,
			lockoutTriggerCriterion = LOCKOUT_TRIGGER_CRITERION.ON_KILL,
		})
		local p1 = leviathanEncounter:addStage({
			start = function()
				leviathanEncounter.shipHealth = Game.createMonster("Ship health", KRAKEN_ANCHOR:Moved(-49, 0, 0))
				leviathanEncounter.shipTentacle1 = Game.createMonster("Kraken tentacles", KRAKEN_ANCHOR:Moved(-52, -1, 0))
				leviathanEncounter.shipTentacle2 = Game.createMonster("Kraken tentacles", KRAKEN_ANCHOR:Moved(-44, 0, 0))
				leviathanEncounter.shipHealth:registerEvent("ShipHealthDeath")
			end,
		})
		local shipHealthDeath = CreatureEvent("ShipHealthDeath")
		function shipHealthDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			leviathanEncounter:nextStage()
			return true
		end
		shipHealthDeath:register()

		local maxHealthLoss = 0.9
		local encounterScope = leviathanEncounter:GetScope()
		local p2playerSpawnZone = Zone(encounterScope:Get("P2-PlayerAppearPositions"))
		local p2 = leviathanEncounter:addStage({
			start = function()
				addEvent(function()
					local totalMissingHp = 0
					for _, tentacle in pairs({ leviathanEncounter.shipTentacle1, leviathanEncounter.shipTentacle2 }) do
						local missingHp = 0
						if tentacle:isDead() then
							missingHp = 100
						else
							missingHp = 1 - tentacle:getHealth() / tentacle:getMaxHealth()
						end
						totalMissingHp = totalMissingHp + missingHp
					end

					local boss = leviathanEncounter:GetBossObject()
					boss:addHealth(-math.min(maxHealthLoss, totalMissingHp) * boss:getMaxHealth())

					local participants = leviathanEncounter:GetCurrentParticipants()
					for _, player in pairs(participants) do
						local randomAppearPos = p2playerSpawnZone:randomPosition()
						player:teleportTo(randomAppearPos)
					end
				end, 2000)
			end,
		})

		function leviathanEncounter:beforeStart() end

		local directions = {
			DIRECTION_SOUTH,
			DIRECTION_NORTH,
		}
		local directionToSlammerPositions = {
			[DIRECTION_NORTH] = Zone(encounterScope:Get("P1-DynamicTentanclePositionsLower")),
			[DIRECTION_SOUTH] = Zone(encounterScope:Get("P1-DynamicTentanclePositionsUpper")),
		}
		local slammerTextures = {
			[11337] = 11337,
			[11350] = 11350,
			[11351] = 11351,
			[11349] = 11349,
		}

		local slammerDamage = 700
		local combat = Combat()
		combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
		combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)

		local function trySpawnSlammer()
			local direction = table.random(directions)
			local slammerPosition = directionToSlammerPositions[direction]:randomPosition(true)

			local existingSlammer = slammerPosition:GetTopItem()
			if existingSlammer and slammerTextures[existingSlammer:getId()] then
				return
			end

			local randomTexture = table.random(slammerTextures)
			local slammer = Game.createItem(randomTexture, 1, slammerPosition)
			addEvent(function()
				local positions = Area(slammerPosition:MovedInDirection(direction, 2), slammerPosition:MovedInDirection(direction, 4)):GetPositions()
				for _, position in pairs(positions) do
					position:sendMagicEffect(CONST_ME_GROUNDSHAKER)
				end
			end, 2800)
			addEvent(function()
				slammer:remove()
				local boss = leviathanEncounter:GetBossObject()
				if not boss then
					return
				end
				local targets = CreatureList():Area(Area(slammerPosition:MovedInDirection(direction, 2), slammerPosition:MovedInDirection(direction, 4))):Get()
				table.insert(targets, leviathanEncounter.shipHealth)
				local damagePerTarget = slammerDamage / #targets
				combat:setFormula(COMBAT_FORMULA_DAMAGE, -damagePerTarget, 0, -damagePerTarget, 0)
				for _, target in pairs(targets) do
					if target:isPlayer() then
						combat:execute(boss, Variant(target:getPosition()))
					else
						target:addHealth(-damagePerTarget)
					end
				end
			end, 3000)
		end

		local slammerSpawnerScope = leviathanEncounter:GetEventScope():Get("P1-SlammerSpawner")
		local slammerSpawner = GlobalEvent(slammerSpawnerScope)
		function slammerSpawner.onThink()
			if not leviathanEncounter:IsActive() then
				return GLOBAL_EVENT_OK
			end
			if leviathanEncounter:GetCurrentPhase() ~= p1 then
				return GLOBAL_EVENT_OK
			end

			for _ = 1, leviathanEncounter:GetParticipantsCount() do
				trySpawnSlammer()
			end
			return GLOBAL_EVENT_OK
		end
		slammerSpawner:interval(4000)
		slammerSpawner:register()

		local seaMonsterNames = {
			"Seacrest Serpent",
			"Serpent Spawn",
			"Sea Serpent",
			"Sea Serpent",
		}
		local monsterSpawnZone = Zone(leviathanEncounter:GetScope():Get("MonsterSpawnPositions"))
		local function trySpawnSeaMonster()
			local pos = monsterSpawnZone:randomPosition()
			local randomSeaMonsterName = table.random(seaMonsterNames)
			Game.createMonster(randomSeaMonsterName, pos)
		end

		local monsterSpawnerScope = leviathanEncounter:GetEventScope():Get("P2-MonstersSpawner")
		local monsterSpawner = GlobalEvent(monsterSpawnerScope)
		function monsterSpawner.onThink()
			if not leviathanEncounter:IsActive() then
				return GLOBAL_EVENT_OK
			end
			if leviathanEncounter:GetCurrentPhase() ~= p2 then
				return GLOBAL_EVENT_OK
			end

			for _ = 1, leviathanEncounter:GetParticipantsCount() do
				trySpawnSeaMonster()
			end
			return GLOBAL_EVENT_OK
		end
		monsterSpawner:interval(14000)
		monsterSpawner:register()

		EncounterDataRegistry:Register(leviathanEncounter)
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.FourActTragedy.Mission03] = QuestState.FourActTragedy.Mission03.ReportToRomek,
		}

		local leviathanDeath = CreatureEvent("GreatLeviathanDeath")
		function leviathanDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValueByKey(Storage.FourActTragedy.Mission03) ~= QuestState.FourActTragedy.Mission03.FindAndKillLewiatan then
					return true
				end

				player:NextState(nextState)
			end)
			return true
		end

		leviathanDeath:register()
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission03.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "But I wasn't talking about some monster, just that shop on the corner. During that time, I went to Walmart to get heineken because I couldn't wait for you. Now, back to the point. I recalled this old story: people from the northeast whisper about certain {slippers} that Rat Bum nibbled on. They say he tried to steal them from his Master, who, under the influence of slippers, descended into the abyss of corruption. The prophecy was funded by the Ministry of State Security of the People's Republic of China.",
				},
				[{ "slippers", "kapciach" }] = {
					text = "Rumors have it that after the death of the aforementioned ruler, the slippers were buried with him. However, it is unknown where this burial place is. As I mentioned, all rumors about the origin of the slippers started with the inhabitants of the northern lands. I think it could be Rats collaborating with banshees. Search the corridors of their base. If you manage to find these slippers, based on the tooth pattern that bit the front part of the boot, we will find a matching profile on onlyfangs.com.",
					nextState = {
						[Storage.FourActTragedy.Mission03] = MISSION_FINISHED,
						[Storage.FourActTragedy.Mission04] = QuestState.FourActTragedy.Mission04.FindBribeslippers,
					},
				},
			})
	end)
	:Mission(Storage.FourActTragedy.Mission04)
	:State(function()
		return QuestState.FourActTragedy.Mission04.FindBribeslippers,
			QuestFactory.Dialog("GM Romek", { [{ "mission", "misja" }] = {
				text = "Ruins are located in the northern part of Kongo",
			} }),
			QuestFactory.OnUseDeclarations({
				{

					id = 1983,
					key = Storage.FourActTragedy.Rewards.SlippersChest,
					rewards = { QuestKeyItems.KingOfRatsHQ.Bribeslippers },
					nextState = { [Storage.FourActTragedy.Mission04] = QuestState.FourActTragedy.Mission04.BringSlippersToRomek },
					desc = "Rest is peace\n~Followers of The Frog Cult",
				},
			}),
			QuestFactory.Script(function(missionState)
				local slippersGravestoneLook = Look()
				function slippersGravestoneLook.onLook(player, item)
					if not player:isPlayer() then
						return false
					end

					SimpleTextDisplay(player, "You will not be forgotten\n~Members of the super frog cult")
					return DONT_SHOW_ONLOOK
				end
				slippersGravestoneLook:key(Storage.FourActTragedy.SlippersGravestone)
				slippersGravestoneLook:register()

				local slippersTp = Action()
				function slippersTp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:isPlayer() then
						return false
					end

					local storageVal = player:getStorageValueByKey(Storage.FourActTragedy.Mission04)
					if storageVal < QuestState.FourActTragedy.Mission04.FindBribeslippers then
						return false
					end
					if storageVal > QuestState.FourActTragedy.Mission04.BringSlippersToRomek then
						return false
					end

					local playerPos = player:getPosition()
					if playerPos.x > item:getPosition().x then
						player:teleportTo(playerPos:Moved(-2, 0, 0))
					elseif playerPos.x < item:getPosition().x then
						player:teleportTo(playerPos:Moved(2, 0, 0))
					end
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				slippersTp:key(Storage.FourActTragedy.SlippersTorch)
				slippersTp:register()
			end)
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission04.BringSlippersToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Did you find anything about slippers owner?",
				},
				[{
					"super frog cult",
					"frog",
					"cult",
					"super kultu zaby",
					"kult",
					"zaba",
				}] = {
					text = "Try to search in the underground ruins in the Kongo. This place was inhabited long ago by medusas, hydras, and other writhing creatures, and it is overgrown with foul flora. An ideal place for an altar for serpentine gods.",
					nextState = {
						[Storage.FourActTragedy.Mission04] = QuestState.FourActTragedy.Mission04.FindAndKillSkurwiwij,
						[Storage.FourActTragedy.SkurwiwijAccess] = ACCESS_GRANTED,
					},
				},
				[{ ANY_MESSAGE }] = {
					text = "Your eyes will open when mine are long closed",
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission04.FindAndKillSkurwiwij,
			QuestFactory.Script(function(missionState)
				local nextState = {
					[Storage.FourActTragedy.Mission04] = QuestState.FourActTragedy.Mission04.ReportToRomek,
				}

				local leviathanDeath = CreatureEvent("SkurwiwijDeath")
				function leviathanDeath.onDeath(creature)
					if not creature or not creature:isMonster() then
						return true
					end
					onDeathForDamagingPlayers(creature, function(creature, player)
						if not player:HasExactMissionState(missionState) then
							return
						end

						if player:TryAddItems({ QuestKeyItems.FourActTragedy.GrazynaCore }) then
							player:NextState(nextState)
						end
					end)
					return true
				end

				leviathanDeath:register()
			end)
	end)
	:EncounterData(function(missionState)
		local pylonNames = {
			north = "north",
			south = "south",
		}
		local skurwiwijEncounter = EncounterData({
			displayName = "Skurwiwij's Den",
			encounterId = "SKURWIWIJ",
			bossName = "Skurwiwij",

			requiredState = { [Storage.FourActTragedy.SkurwiwijAccess] = ACCESS_GRANTED },

			lockoutExpiryTime = LOCKOUT_EXPIRY_TIME.WEEKLY,
			lockoutTriggerCriterion = LOCKOUT_TRIGGER_CRITERION.ON_KILL,
		})
		skurwiwijEncounter:addStage({
			start = function() end,
		})

		local pylonPositions = {
			[pylonNames.north] = Position(6543, 537, 9),
			[pylonNames.south] = Position(6543, 548, 9),
		}
		local pylonTextures = {
			[pylonNames.north] = {
				verticalTexture = 5065,
				horizontalTexture = 5064,
			},
			[pylonNames.south] = {
				verticalTexture = 5069,
				horizontalTexture = 5068,
			},
		}
		local pylonAdds = {
			[pylonNames.north] = "Unstable Ember",
			[pylonNames.south] = "Unstable Energy",
		}
		local fireCombat = Combat()
		fireCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
		fireCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
		local energyCombat = Combat()
		energyCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
		energyCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_LOSEENERGY)
		local pylonCombats = {
			[pylonNames.north] = fireCombat,
			[pylonNames.south] = energyCombat,
		}

		function skurwiwijEncounter:beforeStart()
			self.lastPylonName = pylonNames.south
			self.pylonPower = 0
			self.pylonResetCount = 0
			self.unstableExplosionDamagePerReset = 100
			self.damagePerPylonPower = 10
		end

		local function findClosestPylonName(bossPos)
			local closestPylonName = nil
			local closestDistance = 99999
			for pylonName, pylonPosition in pairs(pylonPositions) do
				local distance = bossPos:EuclideanDistance(pylonPosition)
				if distance < closestDistance then
					closestDistance = distance
					closestPylonName = pylonName
				end
			end
			return closestPylonName
		end

		GlobalFunctions.FourActTragedy.CastStackingDamageSpell = function(bossObject, variant)
			local combat = pylonCombats[findClosestPylonName(bossObject:getPosition())]
			local damage = skurwiwijEncounter.pylonPower * skurwiwijEncounter.damagePerPylonPower
			combat:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0)
			return combat:execute(bossObject, variant)
		end

		local unstableExplosion = CreatureEvent("SkurwiwijUnstableExplosion")
		function unstableExplosion.onDeath(creature)
			local unstableExplosionDamage = (skurwiwijEncounter.pylonResetCount + 1) * skurwiwijEncounter.unstableExplosionDamagePerReset
			unstableExplosionCombat:setFormula(COMBAT_FORMULA_DAMAGE, -unstableExplosionDamage, 0, -unstableExplosionDamage, 0)

			local explosionPos = creature:getPosition()
			return unstableExplosionCombat:execute(creature, Variant(explosionPos))
		end
		unstableExplosion:register()

		local function triggerPylonReset(pylonName)
			local unstableElementalPos = pylonPositions[pylonName]
			local elemental = Game.createMonster(pylonAdds[pylonName], unstableElementalPos)
			elemental:registerEvent("SkurwiwijUnstableExplosion")
			unstableElementalPos:sendMagicEffect(CONST_ME_TELEPORT)
		end
		local function tryTriggerPylonReset(boss)
			local closestName = findClosestPylonName(boss:getPosition())
			if closestName ~= skurwiwijEncounter.lastPylonName then
				triggerPylonReset(skurwiwijEncounter.lastPylonName)
				skurwiwijEncounter.lastPylonName = closestName
				skurwiwijEncounter.pylonResetCount = skurwiwijEncounter.pylonResetCount + 1
				skurwiwijEncounter.pylonPower = 0
			end
		end

		local channelPowerInterval = 500
		local function drawLineToBoss(boss)
			local bossPosition = boss:getPosition()

			local closestPylonName = findClosestPylonName(bossPosition)
			local verticalTexture = pylonTextures[closestPylonName].verticalTexture
			local horizontalTexture = pylonTextures[closestPylonName].horizontalTexture
			local closestPylonPosition = pylonPositions[closestPylonName]

			closestPylonPosition:DrawLine(bossPosition, verticalTexture, horizontalTexture, channelPowerInterval)
		end

		local pylonLoopScope = skurwiwijEncounter:GetEventScope():Get("P2-MonstersSpawner")
		local pylonLoop = GlobalEvent(pylonLoopScope)
		function pylonLoop.onThink()
			if not skurwiwijEncounter:IsActive() then
				return GLOBAL_EVENT_OK
			end

			local boss = skurwiwijEncounter:GetBossObject()
			tryTriggerPylonReset(boss)
			drawLineToBoss(boss)

			skurwiwijEncounter.pylonPower = skurwiwijEncounter.pylonPower + 1
			return GLOBAL_EVENT_OK
		end
		pylonLoop:interval(channelPowerInterval)
		pylonLoop:register()

		EncounterDataRegistry:Register(skurwiwijEncounter)
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission04.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Grazhena Core? Hmm... My mother Xena once belonged to a rural housewives club. Ask her if she knows more about this object. She is the leader of the feminists. Maybe you've already met her.",
					requiredItems = {
						QuestKeyItems.FourActTragedy.GrazynaCore,
					},
					removeRequiredItems = false,
					textNoRequiredItems = "Skurwiwij had Grazhenacore, and you lost it? Come back when you find your lost item.",
					nextState = {
						[Storage.FourActTragedy.Mission04] = MISSION_FINISHED,
						[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.FindXena,
					},
				},
			})
	end)
	:Mission(Storage.FourActTragedy.Mission05)
	:State(function()
		return QuestState.FourActTragedy.Mission05.FindXena,
			QuestFactory.Dialog("Xe'na", {
				[{ "mission", "grazhenacore", "grazynacore", "grazyna", "grazhena" }] = {
					requiredItems = {
						QuestKeyItems.FourActTragedy.GrazynaCore,
					},
					textNoRequiredItems = "Come back when you have Grazhenacore with you.",
					text = "The existence of cancercontent is necessary if we want to maintain the balance of the universe. The cringe factory of rural housewives' kept our world at rest until recently when Grazhena Core was stolen. I will now take Grazhenacore from you. Try to find Grazhena in the prison. Self-proclaimed heroes from the eastern part of the city have locked her in the depths of their dungeons. Now she is forced to live among nightmare creatures.",
					nextState = {
						[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.FindGrazhena,
						[Storage.FourActTragedy.GrazhenaDoor] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission05.FindGrazhena,
			QuestFactory.Dialog("Grazhena", {
				[{ GREET }] = {
					text = "They locked me in here and blocked the exit with magical doors that I can't pass in my current state. You know what? Something is {itching} me here.",
				},
				[{ "itchy", "swedzi", "itching" }] = {
					text = "It's Rat Bum! I have Rat Bum in my pants! When I pull him out, he jumps back in. {Help} me deal with him!",
				},
				[{ "help", "pomoz" }] = {
					text = "He jumped out! You must have scared him! He jumped into that hole, which is too small for a human. There's some hole in front of my cell. Perhaps it leads to the same cave where that rascal fled!",
					nextState = {
						[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.KillRatBum,
					},
				},
			})
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission05.KillRatBum,
			QuestFactory.Dialog("Grazhena", {
				[{ "mission", "misja" }] = {
					text = "Cave entrance is here. Im gonna wait outside.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local toCave = MoveEvent()
				function toCave.onStepIn(player, item, position, fromPosition)
					if not player:isPlayer() then
						return true
					end

					if not player:HasExactMissionState(missionState) then
						return true
					end

					player:teleportTo(position:Moved(0, 0, 1))
					return true
				end

				toCave:type("stepin")
				toCave:key(Storage.FourActTragedy.RatBumHole)
				toCave:register()
			end)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Rat Bum")
		local monster = {}

		monster.description = "the Rat Bum"
		monster.experience = 200
		monster.outfit = { lookType = 305, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

		monster.health = 2000
		monster.maxHealth = 2000
		monster.race = "blood"
		monster.corpse = 6312
		monster.speed = 0
		monster.manaCost = 0

		monster.changeTarget = { interval = 4000, chance = 10 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = true,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 20,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = { level = 0, color = 0 }

		monster.events = { "RatBumDeath" }

		monster.voices = { interval = 5000, chance = 10 }

		monster.loot = { { name = "emerald bangle", chance = 3500 } }

		monster.attacks = {}

		monster.defenses = {
			defense = 25,
			armor = 25,
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
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:MonsterEvent(function()
		local updateStorages = {
			[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.ReportToRomek,
		}
		local requiredState = {
			[Storage.FourActTragedy.Mission05] = QuestState.FourActTragedy.Mission05.KillRatBum,
		}

		local ratBumDeath = CreatureEvent("RatBumDeath")
		function ratBumDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			onDeathForDamagingPlayers(creature, function(creature, player)
				if not player:HasRequiredStates(requiredState) then
					return
				end
				player:NextState(updateStorages)
			end)

			return true
		end

		ratBumDeath:register()
	end)
	:State(function()
		return QuestState.FourActTragedy.Mission05.ReportToRomek,
			QuestFactory.Dialog("Grazhena", {
				[{ "mission", "misja" }] = {
					text = "I'll now return to the village and meet my friends from my club. Thank you for your help.",
				},
				[{ GREET }] = {
					text = "I'll now return to the village and meet my friends from my club. Thank you for your help.",
				},
			}),
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "If you have a moment, go to the summit of the highest mountain in the Caribbean. You might find someone there whom you once knew.",
					nextState = {
						[Storage.FourActTragedy.Mission05] = MISSION_FINISHED,
						[Storage.Finished.FourActTragedy] = MISSION_FINISHED,
						[Storage.FourActTragedy.GrazhenaDoor] = ACCESS_NOT_GRANTED,
						[Storage.PerIustitiaAdAstra.Mission01] = QuestState.PerIustitiaAdAstra.Mission01.HeadToHighestMountain,
						[Storage.PerIustitiaAdAstra.AstralJanusSpawnTileAccess] = ACCESS_GRANTED,
					},
					rewards = { ExerciseWeaponBox(3500) },
				},
			})
	end)
	:Register()
