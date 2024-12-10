local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.IKEAForTheBold = {
			Mission01 = 11073,
			SpawnDominoUndergroundChest = 11077,
			BookChest = 11078,
			BookOfContraband = 11079,

			Mission02 = 11074,
			AnonsFatherAsked = 11075,
			MilesAsked = 11076,
			TileBeforeHawser = 11079,
			ShoreCaveChest = 11080,
		}
		SpawnLocks.IKEAForTheBold = {
			DominoUnderground = SpawnLock(),
			DominoShore = SpawnLock(),
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "IKEA for the BOLD",
			missions = {
				[Storage.LocalSupport.IKEAForTheBold.Mission01] = {
					name = "The Stocktaking",
					states = {
						[1] = "Commissioner Fisher has mentioned that Komor needs help.",
						[2] = "Komor needs help dealing with the disappearing furniture from his warehouse.",
						[3] = "Komor let you ask Gypsy if he knows anything about the theft of the furniture.",
						[4] = "Try to find the thief; he's possibly hiding in the sewers.",
						[5] = "You found the thief, but he managed to get away. Try to look around his hideout.",
						[6] = "You found a list of stolen items; the thief has apparently stolen more than just furniture. Go to Komor and give him the list.",
						[7] = "You helped Komor and got rewarded for that. You have started the new mission 'Needle in a Haystack'.",
					},
				},
				[Storage.LocalSupport.IKEAForTheBold.Mission02] = {
					name = "Needle in a Haystack",
					states = {
						[1] = "You helped Komor find his stolen furniture. Get your reward from the floor above if you haven't already. Visit Komor again to find out what he found on the list.",
						[2] = "Komor asked you to consult Commissioner Fisher about the thief.",
						[3] = "Fish asked you to track down the thief. Perhaps someone from nearby saw where he ran away?",
						[4] = "Find the bandit camp and see if they have anything to do with it.",
						[5] = "Ask the bandit leader about the furniture thief.",
						[6] = "Everything indicates that the thief is trying to smuggle items and hide in the steppes. The bandit leader suggested where you should go now.",
						[7] = "You have defeated the Lumberjack Domino, look around his hiding place.",
						[8] = "From now on, you can use his boat. Report to Commissioner Fisher.",
						[9] = "You prematurely ended the plot of Lumberjack Domino, from now on you can sail his boat from the bandit camp to the south of the steppes.",
					},
				},
			},
		}
	end)
	:MonsterEvent(function()
		local dominoUnderground = CreatureEvent("LumberjackDominoUndergroundDeath")
		function dominoUnderground.onDeath(creature)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			SpawnLocks.IKEAForTheBold.DominoUnderground:Reset()

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.IKEAForTheBold.Mission01) == PH_STATE then
					player:setStorageValue(Storage.IKEAForTheBold.Mission01, PH_STATE)
				end
			end)
			return true
		end
		dominoUnderground:register()

		local dominoShore = CreatureEvent("LumberjackDominoShoreDeath")
		function dominoShore.onDeath(creature)
			SpawnLocks.IKEAForTheBold.DominoShore:Reset()

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.IKEAForTheBold.Mission02) == PH_STATE then
					player:setStorageValue(Storage.IKEAForTheBold.Mission02, PH_STATE)
				end
			end)
			return true
		end
		dominoShore:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Lumberjack Domino Underground")
		local monster = {}

		monster.name = "Lumberjack Domino"
		monster.description = "a lumberjack domino"
		monster.experience = 1400
		monster.outfit = {
			lookType = 143,
			lookHead = 114,
			lookBody = 116,
			lookLegs = 116,
			lookFeet = 114,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 1000
		monster.maxHealth = 1000
		monster.race = "blood"
		monster.corpse = 0
		monster.speed = 60
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 5000,
			chance = 0,
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
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 200,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
			pet = false,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
		}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 65 },
		}

		monster.defenses = {
			defense = 9,
			armor = 9,
			{ name = "speed", interval = 2000, chance = 15, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
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

		monster.events = {
			"LumberjackDominoUndergroundDeath",
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Lumberjack Domino Shore")
		local monster = {}

		monster.name = "Lumberjack Domino"
		monster.description = "a lumberjack domino"
		monster.experience = 21000
		monster.outfit = {
			lookType = 143,
			lookHead = 114,
			lookBody = 116,
			lookLegs = 116,
			lookFeet = 114,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 8000
		monster.maxHealth = 8000
		monster.race = "blood"
		monster.corpse = 111
		monster.speed = 90
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 5000,
			chance = 0,
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
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
			pet = false,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
		}

		monster.loot = {
			{ name = "platinum coin", chance = 100000, minCount = 10, maxCount = 15 },
			{ name = "knight axe", chance = 10000 },
			{ name = "knight armor", chance = 5000 },
			{ name = "knight legs", chance = 5000 },
			{ name = "steel helmet", chance = 60000 },
			{ name = "tower shield", chance = 5000 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -150 },
			{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, range = 7, radius = 1, shootEffect = CONST_ANI_WHIRLWINDAXE, target = true },
			{ name = "berserk", interval = 2000, chance = 13, minDamage = 0, maxDamage = -150, target = false },
		}

		monster.defenses = {
			defense = 9,
			armor = 9,
			{ name = "speed", interval = 2000, chance = 15, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
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

		monster.events = {
			"LumberjackDominoShoreDeath",
		}

		mType:register(monster)
	end)
	:Mission(Storage.LocalSupport.IKEAForTheBold.Mission01)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Komor", {
			[{ "misja", "mission" }] = {
				text = "There is one problem with which you could help me. Some furniture started to disappear from my storages.\nI know for sure that it wasnt Narro's mafia, because they are using wood for different purposes, they are not interested in my products.\nDo you want to help me the one responsible for stealing my furniture?",
			},
			[{ "yes", "tak" }] = {
				text = "Thanks that you agreed to {help}. I hope that its not another mafia.",
				nextState = { [Storage.IKEAForTheBold.State] = 2 },
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Komor", { [{ "misja", "mission", "help", "pomoc" }] = {
			text = "Maybe Gypsy knows something about furniture thief, people like him stick together...",
		} })
	)
	:State(
		PH_STATE,
		QuestFactory.StartupItems({
			{
				id = 11809,
				pos = { 5832, 1597, 11 },
				aid = Storage.IKEAForTheBold.SpawnDominoUndergroundChest,
			},
		}),
		QuestFactory.Script(function(missionState)
			local undergroundChest = Action()
			function undergroundChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:HasExactMissionState(missionState) then
					return false
				end

				if SpawnLocks.IKEAForTheBold.DominoUnderground:IsSet() then
					return false
				end

				Game.createMonster("Lumberjack Domino Underground")
				SpawnLocks.IKEAForTheBold.DominoUnderground:Set()
			end
			undergroundChest:aid(Storage.IKEAForTheBold.SpawnDominoUndergroundChest)
			undergroundChest:register()
		end)
	)
	:State(
		PH_STATE,
		QuestFactory.StartupItems({
			{
				id = 2471,
				pos = { 5840, 1588, 11 },
				aid = Storage.IKEAForTheBold.BookChest,
				rewards = {
					{ id = 3076 },
					{ id = 2816, aid = Storage.IKEAForTheBold.BookOfContraband },
				},
				nextState = { [Storage.IKEAForTheBold.Mission01] = PH_STATE },
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Komor", {
			[{ "misja", "mission" }] = {
				text = "Thank you for finding perpetrator. Your reward is upstairs, here is the key to the door.\nMeanwhile I will call to two almighty Mirks, so they will bring my stolen stuff from those undergrounds",
				nextState = {
					[Storage.IKEAForTheBold.State] = 5,
				},
				requiredItems = {
					{ id = 2816, aid = Storage.IKEAForTheBold.BookOfContraband, text = "DOMINO_BOOK_OF_CONTRABAND_TEXT" },
				},
				rewards = {
					{ id = 2972, actionid = 5008 }, -- ehhhhhhh
				},
				expReward = 30000,
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Komor", {
			[{ "mission", "misja" }] = {
				text = "I checked the list of stolen items, I saw that he had a ball that Gypsy was looking for. Wait, its not {all}.",
			},
			[{ "all", "wszystko" }] = {
				text = "Recent entries on the list suggest that our thief was stealing food and supplies from the orcs of the south.\nGo to Commissioner Fisher and tell him about it. Also ask him if he knows something about that thief.",
			},
		})
	)
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:Mission(Storage.LocalSupport.IKEAForTheBold.Mission02)
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
