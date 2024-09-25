--[[
local sultanPrime = Quest("sultan_prime")
sultanPrime
	:Constant(function()
		SULTAN_PRIME_KEY_ITEMS = {
			bottle = { id = 10183, aid = Storage.SultanPrime.MagicianFountain },
			amulet = { id = 3015, aid = Storage.SultanPrime.RewardsScripted.Necklace },
		}
		SULTAN_PRIME_RETRO_MIRKO = {
			requiredCoffinCount = 5,
			corpseId = {
				[18134] = 1, -- hero
				[18034] = 1, -- adventurer
				[18138] = 1, -- hunter
			},
			requiredCorpseCount = 10,
		}
		SULTAN_PRIME_PORTALS = {}
		DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED = 8261
	end)
	:Storage(function()
		Storage.SultanPrime = {
			Questline = NextStorage(),

			Mission01 = NextStorage(),
			MagicianFountain = NextStorage(),

			Mission02 = NextStorage(),
			FarmerChair = NextStorage(),
			DromedaryCount = NextStorage(),

			Mission03 = NextStorage(),
			Coffin = NextStorage(),
			CoffinCount = NextStorage(),
			CorpseCount = NextStorage(),
			Jaw = NextStorage(),
			DoorAfterRyba = NextStorage(),
			RetroLever = NextStorage(),

			RewardsScripted = { Necklace = NextStorage() },
		}
		Storage.Finished.SultanPrime = 15016
		Storage.DesertQuestHub.ToSultanPrime = NextStorage()
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Sultan Prime",
			startStorageId = Storage.SultanPrime.Localizer,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "What Is Mafia? Is It Good?",
					storageId = Storage.SultanPrime.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "You found the cursed amulet of power. Return it to the King of Phantasms so he can begin his world destruction plan.",
						[2] = "Sultan made you an offer. Give the neclace to him to begin your mission.",
						[3] = "You returned the amulet to the Sultan and agreed to help him.",
					},
				},
				[2] = {
					name = "Unlucky Surveyors",
					storageId = Storage.SultanPrime.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 7,
					states = {
						[1] = "Go to Sultan of Phantasms for another task.",
						[2] = "Sultan of Phantasms assigned you a task worthy of a novice villain. Poison the fountain in the town of Magicians using the poisoned flask.",
						[3] = "You've successfully completed the first task for Sultan of Phantasms. Return to him now.",
						[4] = "CAMELS_KILLED_STATUS",
						[5] = "You wiped out the camel farm. Leave the rope on the table - he'll know what to do with it.",
						[6] = "Sultan will be pleased with your actions. Return to him for your reward.",
						[7] = "Sultan rewarded you for your cooperation.",
					},
				},
				[3] = {
					name = "Sultan's Last Plague",
					storageId = Storage.SultanPrime.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 6,
					states = {
						[1] = "OPENED_COFFINS_STATUS",
						[2] = "BODIES_THROWN_STATUS",
						[3] = "~Sultan69: It's time to get rid of Aspirant Ryba. After work, you can leave the barracks through the northern doors and use the shortcut.",
						[4] = "~Sultan69: How did Ryba escape? The Crypt King also fell in battle. Come back immediately so I can chew you out!",
						[5] = "Sultan ordered you to.. You can go to Father Natanek and ask him for redemption.",
						[6] = "Father Natank gave you today's offering from today's Mass in exchange for your silence.",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local startupItemsMagicians = {
			{ pos = { -7, -3, 0 }, id = 1936, aid = Storage.SultanPrime.MagicianFountain },
			{ pos = { -6, -3, 0 }, id = 1937, aid = Storage.SultanPrime.MagicianFountain },
			{ pos = { -7, -2, 0 }, id = 1938, aid = Storage.SultanPrime.MagicianFountain },
			{ pos = { -6, -2, 0 }, id = 1939, aid = Storage.SultanPrime.MagicianFountain },
		}
		local startupItemsCamels = {
			{ pos = { 10, -3, 0 }, id = 8520, aid = Storage.SultanPrime.FarmerChair, uid = 1000 },
		}
		local startupItemsRetroMirko = {
			{ pos = { 34, 1, 2 }, id = 2772, aid = Storage.SultanPrime.RetroLever },

			{ pos = { -31, -72, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
			{ pos = { -4, -73, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
			{ pos = { -71, -63, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
			{ pos = { -64, -72, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
			{ pos = { -14, -80, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
			{ pos = { -23, -74, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
			{ pos = { -27, -85, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
			{ pos = { -28, -74, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
			{ pos = { -47, -85, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
			{ pos = { -52, -78, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
			{ pos = { -68, -76, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },

			{ pos = { -7, -10, 1 }, id = 10548, aid = Storage.SultanPrime.Jaw },

			{ pos = { -31, 43, 0 }, id = 6260, aid = Storage.SultanPrime.DoorAfterRyba },

			{ pos = { -35, 31, 0 }, id = 23483, aid = Storage.DesertQuestHub.ToSultanPrime },
			{ pos = { -48, -68, -2 }, id = 1949, aid = Storage.DesertQuestHub.ToSultanPrime },
		}

		local npcsRetroMirko = { { name = "The sultan of Phantasms", pos = { 20, -8, 2 } } }
		local npcsCamels = { { name = "Dampreefer", pos = { 0, 0, 0 } } }
		local monstersDesert = { { name = "Cezary Baryka", pos = { -106, 122, 2 } } }
		local monstersRetroMirko = { { name = "Aspirant Ryba", pos = { -32, 48, 0 } } }

		local desertQuestInit = GlobalEvent("sultanPrimeInit")
		function desertQuestInit.onStartup()
			LoadStartupItems(startupItemsMagicians, MIRKO_MAGICIANS_ANCHOR)
			LoadStartupItems(startupItemsCamels, CAMEL_FARM_ANCHOR)
			LoadStartupItems(startupItemsRetroMirko, RETRO_MIRKO_ANCHOR)

			LoadStartupNpcs(npcsRetroMirko, RETRO_MIRKO_ANCHOR)
			LoadStartupNpcs(npcsCamels, CAMEL_FARM_ANCHOR)

			LoadStartupMonsters(monstersDesert, DESERT_QUEST_ONE_ANCHOR)
			LoadStartupMonsters(monstersRetroMirko, RETRO_MIRKO_ANCHOR)
		end
		desertQuestInit:register()
	end)
	:MonsterEvent(function()
		local cezary = CreatureEvent("CezaryBarykaDeath")

		function cezary.onDeath(creature)
			local deathPos = creature:getPosition()
			local corpse = Game.createItem(4240, 1, deathPos)
			corpse:setActionId(Storage.SultanPrime.RewardsScripted.Necklace)

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
	:State(QUEST_NOT_STARTED)
	:Script(function(storageToRequiredState)
		local neckUpdateStorages = {
			[Storage.SultanPrime.Mission01] = 1,
		}
		local questStorage = Storage.SultanPrime.Mission01

		local corpse = Action()
		function corpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if player:getStorageValue(questStorage) ~= QUEST_NOT_STARTED then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
				return
			end

			player:AddItems({ SULTAN_PRIME_KEY_ITEMS.amulet })
			player:UpdateStorages(neckUpdateStorages)
			return true
		end
		corpse:aid(Storage.SultanPrime.RewardsScripted.Necklace)
		corpse:register()
	end)
	:State(QuestState.SultanPrime.Mission01.Start)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Adventurer |PLAYERNAME|... I was watching you proceed through that dungeon and beat all the deadly traps. You might have something that I value. Precisely that {amulet} that u took from Cezary Baryka.",
			nextState = {
				[Storage.SultanPrime.Mission01] = 2,
			},
		},
	})
	:State(QuestState.SultanPrime.Mission01.GivingAmuletToSultan)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Adventurer |PLAYERNAME|... I was watching you proceed through that dungeon and beat all the deadly traps. You might have something that I value. Precisely that {amulet} that u took from Cezary Baryka.",
		},
		[{ "mission", "amulet", "naszyjnik" }] = {
			text = "Thanks for your cooperation. Now if you don't mind, i have a {mission} for you.",
			requiredItems = { SULTAN_PRIME_KEY_ITEMS.amulet },
			textNoRequiredItems = "Ehh, you lost it? Guess Imma take over the world in next season.",
			nextState = {
				[Storage.SultanPrime.Mission01] = 3,
				[Storage.SultanPrime.Mission02] = 1,
			},
		},
	})
	:Mission(Storage.SultanPrime.Mission02)
	:State(QuestState.SultanPrime.Mission02.Start)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "My favorite follower, |PLAYERNAME|. You came for new {mission}?",
		},
		[{ "mission", "yes", "tak" }] = {
			text = "I don't think I told you about this, but I have a plan to take over and rule the world. That amulet will surely help me, but I still would not mind gaining new allies. I'm currently trying to convince mages, warriors, animals and other inferior beings. Your first task will be to poison magicians' water source. They rejected my will and ridiculed my proposal for an alliance.",
			nextState = {
				[Storage.SultanPrime.Mission02] = 2,
			},
			rewards = { SULTAN_PRIME_KEY_ITEMS.bottle },
		},
	})
	:State(QuestState.SultanPrime.Mission02.PoisoningMagicianWell)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Hi again, |PLAYERNAME|. Did you complete the mission?",
		},
	})
	:Script(function(storageToRequiredState)
		local function isUsingBottleOnFountain(target)
			if not target then
				return false
			end
			if not (target:getActionId() == Storage.SultanPrime.MagicianFountain) then
				return
			end
			if target:getId() == SULTAN_PRIME_KEY_ITEMS.bottle.id then
				return
			end
		end

		local taintBottle = Action()
		function taintBottle.onUse(player, bottle, fromPosition, target, toPosition, isHotkey)
			local storage_val = player:getStorageValue(Storage.SultanPrime.Mission02)
			if storage_val ~= 2 then
				return false
			end

			if not isUsingBottleOnFountain(target) then
				return false
			end

			player:RemoveItems({ SULTAN_PRIME_KEY_ITEMS.bottle })
			player:setStorageValue(Storage.SultanPrime.Mission02, 3)
			player:setStorageValue(Storage.SultanPrime.DromedaryCount, 0)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			target:getPosition():sendMagicEffect(CONST_ME_PLANTATTACK)
			return true
		end

		taintBottle:aid(Storage.SultanPrime.MagicianFountain)
		taintBottle:register()
	end)
	:State(QuestState.SultanPrime.Mission02.PoisoningMagicianWell)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Hi, |PLAYERNAME|. Did you manage to compelte your first task?",
		},
		[{ "mission", "yes", "tak" }] = {
			text = "Good job. Now we will take care of a certain farmer from the steppes. Dampreefer is a hermit. I offered for him to join me, but he refused. Go to his farm and cull his farm animals. This should make him commit a suicide. Dampreefer is very poor, so you might need to help him with that. Maybe Leroy Merlin rope $6.99/meter?",
			nextState = {
				[Storage.SultanPrime.Mission02] = 4,
			},
		},
	})
	:State(QuestState.SultanPrime.Mission02.CullingOfCamels)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Dampreefer farm is located near pirates' yard on the steppes.",
		},
	})
	:Dialog("Dampreefer", {
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
	})
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.SultanPrime.Mission02] = 5,
		}
		local requiredCamelKills = 6

		local function isOnFarm(player)
			return player:getPosition():EuclideanDistance(SULTAN_PRIME_CAMEL_FARM.topLeft) < 100
		end

		local dromedary = CreatureEvent("DromedaryKill")
		function dromedary.onDeath(creature)
			local targetMonster = creature:getMonster()
			if not targetMonster or targetMonster:getMaster() then
				return true
			end

			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.SultanPrime.Mission02)
				if storage_val ~= 4 then
					return true
				end

				if not isOnFarm(player) then
					return true
				end

				player:IncrementStorage(Storage.SultanPrime.DromedaryCount, 1)
				player:RefreshStorage(Storage.SultanPrime.Mission02)

				if player:getStorageValue(Storage.SultanPrime.DromedaryCount) >= requiredCamelKills then
					player:UpdateStorages(updateStorages)
				end
			end)
			return true
		end
		dromedary:register()
	end)
	:State(QuestState.SultanPrime.Mission02.HangTheFarmer)
	:Dialog("Dampreefer", {
		[{ GREET }] = {
			text = "What in damnation!? What did you do. I dont {feel} like.",
		},
		[{ "chce", "feel" }] = {
			text = "Just put the rope on the table. I will serve myself.",
		},
	})
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Dampreefer farm is located near pirates' yard on the steppes.",
		},
	})
	:Script(function(storageToRequiredState)
		local chair = MoveEvent()
		function chair.onAddItem(moveitem, tileitem, position)
			if not moveitem then
				return false
			end
			local id = moveitem.itemid
			if id ~= 3003 then
				return true
			end

			local pos = moveitem:getPosition()
			moveitem:remove()

			local topLeft = CAMEL_FARM_ANCHOR:Moved(SULTAN_PRIME_CAMEL_FARM.topLeft)
			local downRight = CAMEL_FARM_ANCHOR:Moved(SULTAN_PRIME_CAMEL_FARM.downRight)

			local players = CreatureList():Area(topLeft, downRight):FilterByPlayer()
			for _, player in pairs(players) do
				if player:getStorageValue(Storage.SultanPrime.Mission02) == 5 then
					player:setStorageValue(Storage.SultanPrime.Mission02, 6)
				end
			end

			Game.createItem(18114, 1, pos)
			return true
		end
		chair:type("additem")
		chair:aid(Storage.SultanPrime.FarmerChair)
		chair:register()
	end)
	:State(QuestState.SultanPrime.Mission02.ReportHanging)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Welcome again, |PLAYERNAME|. Have you succeeded in the last task I entrusted to you?",
		},
		[{ "mission", "yes", "tak" }] = {
			text = "Great, he got exactly what he deserved. Now a new mission - go back in time to the mirkotown 20 years ago. In the meantime, I'm gonna do my business on the other battlefront, and I will leave my hologram here. I will provide details to your mission in your quest log.",
			nextState = {
				[Storage.SultanPrime.Mission02] = 7,
				[Storage.SultanPrime.Mission03] = 1,
				[Storage.SultanPrime.CoffinCount] = 0,
			},
		},
	})
	:Mission(Storage.SultanPrime.Mission03)
	:Script(function(storageToRequiredState)
		local retroMirkoPos = RETRO_MIRKO_ANCHOR:Moved({ x = -46, y = -68, z = -2 })

		local lever = Action()
		function lever.onUse(creature, item, fromPosition, itemEx, toPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end
			if player:getStorageValue(Storage.SultanPrime.Mission03) < 1 then
				return true
			end

			player:teleportTo(retroMirkoPos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
		lever:aid(Storage.SultanPrime.RetroLever)
		lever:register()
	end)
	:State(QuestState.SultanPrime.Mission03.Start)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
		},
	})
	:Script(function(storageToRequiredState)
		local coffin = Action()
		function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not target then
				return false
			end
			local storageVal = player:getStorageValue(Storage.SultanPrime.Mission03)
			if storageVal ~= 1 then
				return true
			end

			Game.createItem(2121, 1, toPosition)
			player:setStorageValue(
				Storage.SultanPrime.CoffinCount,
				player:getStorageValue(Storage.SultanPrime.CoffinCount) + 1
			)
			player:RefreshStorage(Storage.SultanPrime.Mission03)

			if
				(player:getStorageValue(Storage.SultanPrime.CoffinCount))
				== SULTAN_PRIME_RETRO_MIRKO.requiredCoffinCount
			then
				player:setStorageValue(Storage.SultanPrime.CorpseCount, 0)
				player:setStorageValue(Storage.SultanPrime.Mission03, 2)
			end
			return true
		end
		coffin:aid(Storage.SultanPrime.Coffin)
		coffin:register()
	end)
	:State(QuestState.SultanPrime.Mission03.TentacleFeeding)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
		},
	})
	:Script(function(storageToRequiredState)
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

		local jawMonster = nil

		local eatingJaw = MoveEvent()
		function eatingJaw.onAddItem(corpse, tile, position)
			if not corpse then
				return
			end

			local threwBody = SULTAN_PRIME_RETRO_MIRKO.corpseId[corpse:getId()]
			if not threwBody then
				jawMonster:say(randomMessageOnFail())
			end

			jawMonster:say(randomMessageOnSuccess())

			local playerPos = tile:getPosition():Moved(2, 0, -1)
			local player = Tile(playerPos):getTopCreature()
			if not player then
				return
			end
			local storageVal = player:getStorageValue(Storage.SultanPrime.Mission03)
			if storageVal ~= 2 then
				return true
			end

			player:IncrementStorage(Storage.SultanPrime.CorpseCount)
			player:RefreshStorage(Storage.SultanPrime.Mission03)
			if
				player:getStorageValue(Storage.SultanPrime.CorpseCount) >= SULTAN_PRIME_RETRO_MIRKO.requiredCorpseCount
			then
				player:setStorageValue(Storage.SultanPrime.Mission03, 3)
			end
			return true
		end

		eatingJaw:type("additem")
		eatingJaw:aid(Storage.SultanPrime.Jaw)
		eatingJaw:register()

		local encounterLeverInit = GlobalEvent("SultanPrimeTentacle")
		function encounterLeverInit.onStartup()
			-- ToDo: check if pos is correct
			jawMonster = Game.createMonster("Tentacly Jaw", RETRO_MIRKO_ANCHOR:Moved({ -7, -11, 0 }))
			jawMonster:setInvulnerable()
		end
		encounterLeverInit:register()
	end)
	:State(QuestState.SultanPrime.Mission03.KillingRyba)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "DETECTED |PLAYERNAME|. EXECUTE: GREET ON OBJECT $|PLAYERNAME|.",
		},
	})
	:Script(function(storageToRequiredState)
		local ryba = CreatureEvent("RybaKill")

		function ryba.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValue(Storage.SultanPrime.Mission03)
				if storage_val ~= 3 then
					return true
				end
				player:setStorageValue(Storage.SultanPrime.Mission03, 4)
				player:setStorageValue(Storage.SultanPrime.DoorAfterRyba, 1)
			end)
			return true
		end

		ryba:register()
	end)
	:State(QuestState.SultanPrime.Mission03.ReportKillingRyba)
	:Dialog("Sultan of Phantasms", {
		[{ GREET }] = {
			text = "Whaaat, Ryba escaped? Undead king perished? What kind of villain are you?",
		},
		[{ "mission" }] = {
			text = "What else? Take this amulet and stick it up in your ass.",
			nextState = {
				[Storage.SultanPrime.Mission03] = 5,
			},
			rewards = { SULTAN_PRIME_KEY_ITEMS.amulet },
		},
	})
	:State(QuestState.SultanPrime.Mission03.ReportToNatanek)
	:Dialog("Father Natanek", {
		[{ "mission", "misja", "naszyjnik", "amulet", "necklace" }] = {
			text = "I'd prefer this information to stay between us. Let's agree that you'll take what I received from the faithful today, and in exchange, you'll forget what Sultan showed you.",
		},
		[{ "dostalem", "donated" }] = {
			text = "Here, this is your reward.",
			nextState = {
				[Storage.SultanPrime.Mission03] = 6,
			},
			rewards = { { id = 3043, count = 2 } },
			expReward = 800000,
		},
	})
	:Register()
]]
