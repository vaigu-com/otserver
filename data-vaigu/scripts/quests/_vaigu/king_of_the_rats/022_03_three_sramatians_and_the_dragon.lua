local quest = Quest(LOCALIZERS.ThreeSramatiansAndTheDragon)
quest
	:Storage(function()
		Storage.ThreeSramatiansAndTheDragon = {
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			Mission06 = NextStorage(),
			Mission07 = NextStorage(),
			Mission08 = NextStorage(),
			Mission09 = NextStorage(),
			HfpxAccess = NextStorage(),

			GoldblumTrap = NextStorage(),
			Fireplaces = {
				Hive = NextStorage(),
				Lagoon = NextStorage(),
				Souleater = NextStorage(),
				WaterWell = NextStorage(),
				Hairycles = NextStorage(),
				Hellspawns = NextStorage(),
			},
			Rewards = {
				Rum = NextStorage(),
				DeepCrystal = NextStorage(),
				Rune1 = NextStorage(),
				Rune2 = NextStorage(),
				Rune3 = NextStorage(),
			},
			AbandonedFireplace = NextStorage(),
			VampireCityTrap = NextStorage(),
			RatOfKingsTile = NextStorage(),
			Portals = { AfterHfpx = NextStorage() },
		}
		QuestState.ThreeSramatiansAndTheDragon = {
			Mission01 = {
				TalkToRomek = 1,
				Finished = 2,
			},
			Mission02 = {
				FollowCompany = 1,
				SolvedGoldblumRiddle = 2,
				Finished = 3,
			},
			Mission03 = {
				FindCompanyAtHive = 1,
				AskBilbeusToJoin = 2,
				FindRum = 3,
				BringRumToBilbeus = 4,
				Finished = 5,
			},
			Mission04 = {
				FindCompanyAtSteppes = 1,
				FindCompanyAtHumanTown = 2,
				StealWineFromVampires = 3,
				EscapeDungeon_FindGertrude = 4,
				Finished = 5,
			},
			Mission05 = {
				AskLamborForHelp = 1,
				BringMeatToLambor = 2,
				FindCompanyAtWyverns = 3,
				Finished = 4,
			},
			Mission06 = {
				TalkToNomad = 1,
				BringDepthsCrystal = 2,
				ReportToBilbeus = 3,
				Finished = 4,
			},
			Mission07 = {
				FindArtifactAtVillage = 1,
				FindCompanyAtHairycles = 2,
				BringBananasToBilbeus = 3,
				Finished = 4,
			},
			Mission08 = {
				FindCompanyAtHellspawnTemple = 1,
				FindThreeMagicRunes = 2,
				Finished = 3,
			},
			Mission09 = {
				FindAndDefeatHfpx = 1,
				ReportToRatOfKings = 2,
				ReportToRomek = 3,
				Finished = 4,
			},
		}
	end)
	:Constant(function()
		TRZEJ_SRAMACI_I_SMOK_SPECIAL_CONDITIONS = {
			playerIsDrunk = function(context)
				local player = context.player
				if not player then
					return false
				end
				return player:hasCondition(CONDITION_DRUNK)
			end,
		}

		TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS = {
			rum = {
				aid = Storage.ThreeSramatiansAndTheDragon.Rewards.Rum,
				id = 2875,
				desc = "Pirate rum. Bilbeus might be interested in this one",
			},
			rune1 = { aid = Storage.ThreeSramatiansAndTheDragon.Rewards.Rune1, id = 3181, desc = "Unsealing rune" },
			rune2 = { aid = Storage.ThreeSramatiansAndTheDragon.Rewards.Rune2, id = 3183, desc = "Unsealing rune" },
			rune3 = { aid = Storage.ThreeSramatiansAndTheDragon.Rewards.Rune3, id = 3184, desc = "Unsealing rune" },
			deepCrystal = {
				aid = Storage.ThreeSramatiansAndTheDragon.Rewards.DeepCrystal,
				id = 7281,
				desc = "Deep sea crystal",
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "The Three Sramatians and the Dragon",
			missions = {
				[Storage.ThreeSramatiansAndTheDragon.Mission01] = {
					name = "01. Hither and Thither",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission01.TalkToRomek] = "GM Romek needs help with a new problem, go to him.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission01.Finished] = "And the men went along the road into the woods,\nWith an average pace,\nHumility will come for them in due time,\nEnter the bottom text here.",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission02] = {
					name = "02. Fungus Magnum",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission02.FollowCompany] = "I think the company went north through the gate of Mirkotown. From there, they went east, into the forest of cretin. In the forest, there is a secret passage through the caves of disgusting trolls. They might have used it. ~GM Romek",
						[QuestState.ThreeSramatiansAndTheDragon.Mission02.SolvedGoldblumRiddle] = "You correctly answered Goldblum's riddle. Now give him your best puzzle.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission02.Finished] = "Respiciens post te, hominem\nmemento te; cave, ne cadas",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission03] = {
					name = "03. Follow OSHA Standards",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission03.FindCompanyAtHive] = "Goldblum said that Bilbeus's company might be around the hive.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission03.AskBilbeusToJoin] = "Ask Bilbeus how you can join their company.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission03.FindRum] = "Find a box of rum in the pirate village nearby.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission03.BringRumToBilbeus] = "You found rum for Bilbeus. Return to him and suggest that he indulge himself.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission03.Finished] = "An unworthy act for a Welder\nThe King will probably put his balls in blender",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission04] = {
					name = "04. Delirium Tremens",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission04.FindCompanyAtSteppes] = "Find the company's camp in the western steppes.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission04.FindCompanyAtHumanTown] = "You found the camp, but the company has already moved on. They might have settled in the nearest human town.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission04.StealWineFromVampires] = "Bilbeus came up with the idea to steal wine from the vampires. New wine deliveries appear at the docks not only on Sundays at noon.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission04.EscapeDungeon_FindGertrude] = "Find a way to escape the dungeons, then locate Gertrude.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission04.Finished] = "Now it's time to search for valuable renewable resources for the Recycling Father.",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission05] = {
					name = "05. Aqua Inaestimabilis",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission05.AskLamborForHelp] = "Gertrude told you that the company went to the desert. The Djinn Lord - Lambor might help you find them.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission05.BringMeatToLambor] = "Lambor demanded dragon meat in exchange for information about your companions.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission05.FindCompanyAtWyverns] = "Lambor indicated that the company is by the old mine, where wyverns nest.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission05.Finished] = "An old unjust tyrant dragged me into trouble again.",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission06] = {
					name = "06. Shepherd of Rats",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission06.TalkToNomad] = "Bilbeus mentioned that you should head to the nomad's rock.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission06.BringDepthsCrystal] = "The Nomad asked for a favor - he wants a crystal from the depths.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission06.ReportToBilbeus] = "Return to Bilbo and tell him what you learned from the nomad.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission06.Finished] = "Fing\nfurious\nup to the sky, the SKY\nTO HELL,\nUUU",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission07] = {
					name = "07. Nasty Neighbor Abominable Cravings",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission07.FindArtifactAtVillage] = "Go to the lizard people's village and find the ancient artifact.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission07.FindCompanyAtHairycles] = "Bilbeus mentioned earlier that they will stop at Hairycles's place.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission07.BringBananasToBilbeus] = "Bilbeus wants to repay Hairycles for the information he provided. Bring some bananas to Bilbeus.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission07.Finished] = "Sheeit, it's awesome.",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission08] = {
					name = "08. Follow the Odor of Opulence",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission08.FindCompanyAtHellspawnTemple] = "Bilbeus indicated that they are heading to the Temple of Hellspawn.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission08.FindThreeMagicRunes] = "Find three magic runes to unlock the doors deep inside the temple.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission08.Finished] = "I saw a snail crawling along the edge of a razor. It's my dream. My nightmare born from hell. It plods, crawls along the devilishly sharp razor edge. And it doesn't die.",
					},
				},
				[Storage.ThreeSramatiansAndTheDragon.Mission09] = {
					name = "09. Artificial Intelligence and Euthanasia",
					states = {
						[QuestState.ThreeSramatiansAndTheDragon.Mission09.FindAndDefeatHfpx] = "The Rat of Kings took the runes from you and unsealed the door. Now find HF-P/X.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission09.ReportToRatOfKings] = "Return to the Rat of Kings and tell him about the battle.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission09.ReportToRomek] = "The Rat of Kings had a heart attack upon hearing about so many wrecked Passats. Now, go back to Romek.",
						[QuestState.ThreeSramatiansAndTheDragon.Mission09.Finished] = "Greed consumed you\nAbove creativity, attention-seeking\nAbove reason, fame\nProfit to the bottom, the worthy are hunted\nLack of a healthy foundation.\nYou killed my child in horror\nThe end of the world is coming.\nCanary, Russia, Bitcoins, Ameno.",
					},
				},
			},
		}
	end)
	:MonsterEvent(function()
		local storages = {
			[Storage.ThreeSramatiansAndTheDragon.State] = 23,
			[Storage.ThreeSramatiansAndTheDragon.Mission09] = 2,
		}

		local hfpx = CreatureEvent("HfpxKill")

		function hfpx.onDeath(creature)
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storageVal = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.State)
				if storageVal ~= 22 then
					return true
				end
				player:UpdateStorages(storages)
			end)
			return true
		end

		hfpx:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Jan Kockodan")
		local monster = {}

		monster.description = "Jan Kockodan"
		monster.experience = 8000
		monster.outfit = {
			lookType = 4,
			lookHead = 91,
			lookBody = 3,
			lookLegs = 33,
			lookFeet = 92,
			lookAddons = 1,
			lookMount = 0,
		}

		monster.health = 5700
		monster.maxHealth = 5700
		monster.race = "blood"
		monster.corpse = 22023
		monster.speed = 280
		monster.manaCost = 392

		monster.changeTarget = { interval = 4000, chance = 20 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = true,
			canPushItems = true,
			canPushCreatures = false,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 100, maxDamage = -666 }, -- bleed
			{
				name = "condition",
				type = CONDITION_BLEEDING,
				interval = 2000,
				chance = 60,
				minDamage = -150,
				maxDamage = -225,
				radius = 5,
				effect = CONST_ME_HOLYAREA,
				shootEffect = CONST_ANI_THROWINGKNIFE,
				target = true,
			},
		}

		monster.defenses = {
			defense = 50,
			armor = 35,
			{
				name = "combat",
				interval = 3717,
				chance = 15,
				type = COMBAT_HEALING,
				minDamage = 220,
				maxDamage = 280,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 10 },
			{ type = COMBAT_FIREDAMAGE, percent = 10 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 10 },
			{ type = COMBAT_DEATHDAMAGE, percent = -10 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Runic Hellspawn")
		local monster = {}

		monster.description = "a runic hellspawn"
		monster.experience = 9000
		monster.outfit = { lookType = 322, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

		monster.health = 5500
		monster.maxHealth = 5500
		monster.race = "fire"
		monster.corpse = 9009
		monster.speed = 344
		monster.manaCost = 0

		monster.changeTarget = { interval = 3717, chance = 15 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

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
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = {}
		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -352 },
			{
				name = "combat",
				interval = 2000,
				chance = 20,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -175,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREATTACK,
				target = false,
			},
		}

		monster.defenses = {
			defense = 40,
			armor = 40,
			{
				name = "combat",
				interval = 2000,
				chance = 10,
				type = COMBAT_HEALING,
				minDamage = 120,
				maxDamage = 230,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
			{
				name = "speed",
				interval = 2000,
				chance = 15,
				speedChange = 270,
				effect = CONST_ME_MAGIC_RED,
				target = false,
				duration = 4999,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 70 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 100 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 30 },
			{ type = COMBAT_HOLYDAMAGE, percent = -90 },
			{ type = COMBAT_DEATHDAMAGE, percent = 30 },
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
		local mType = Game.createMonsterType("Enchanted Hellspawn")
		local monster = {}

		monster.description = "an enchanted hellspawn"
		monster.experience = 9000
		monster.outfit = { lookType = 322, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0, lookMount = 0 }

		monster.health = 5500
		monster.maxHealth = 5500
		monster.race = "fire"
		monster.corpse = 9009
		monster.speed = 344
		monster.manaCost = 0

		monster.changeTarget = { interval = 3717, chance = 15 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

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
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -352 },
			{
				name = "combat",
				interval = 2000,
				chance = 20,
				type = COMBAT_FIREDAMAGE,
				minDamage = -150,
				maxDamage = -175,
				shootEffect = CONST_ANI_FIRE,
				effect = CONST_ME_FIREATTACK,
				target = false,
			},
		}

		monster.defenses = {
			defense = 40,
			armor = 40,
			{
				name = "combat",
				interval = 2000,
				chance = 10,
				type = COMBAT_HEALING,
				minDamage = 120,
				maxDamage = 230,
				effect = CONST_ME_MAGIC_BLUE,
				target = false,
			},
			{
				name = "speed",
				interval = 2000,
				chance = 15,
				speedChange = 270,
				effect = CONST_ME_MAGIC_RED,
				target = false,
				duration = 4999,
			},
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 50 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 10 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 70 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 100 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 30 },
			{ type = COMBAT_HOLYDAMAGE, percent = -90 },
			{ type = COMBAT_DEATHDAMAGE, percent = 30 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission01)
	:State(
		ANY_STATE,
		QuestFactory.Script(function(missionState)
			local hive = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Hive
			local lagoon = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Lagoon
			local souleater = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Souleater
			local waterWell = Storage.ThreeSramatiansAndTheDragon.Fireplaces.WaterWell
			local hairycles = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Hairycles
			local hellspawns = Storage.ThreeSramatiansAndTheDragon.Fireplaces.Hellspawns

			local spawnTimer = 1000 * 2 * 60

			local companyMembersNames = {
				"Moorin the second of the copper cowbell",
				"Brallin of the beech wall unit",
				"Guseppe Four Cheeses",
				"Bilbeus",
			}
			local aidToCompany = { [hive] = nil, [lagoon] = nil, [souleater] = nil, [waterWell] = nil }

			local aidToRequiredState = {
				[hive] = { min = 3, max = 6 },
				[lagoon] = { min = 8, max = 8 },
				[souleater] = { min = 10, max = 10 },
				[waterWell] = { min = 13, max = 16 },
				[hairycles] = { min = 18, max = 19 },
				[hellspawns] = { min = 20, max = 22 },
			}

			local litFireplaceId = 2000
			local unlitFireplaceId = 1997

			local function hasRequiredState(player, aid)
				local questState = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.State)

				local states = aidToRequiredState[aid]
				local min = states.min
				local max = states.max
				return min <= questState and questState <= max
			end

			local function SpawnCompany(aid, fireplace)
				aidToCompany[aid] = {}
				local members = {}
				local pos = fireplace:getPosition()
				for _, name in pairs(companyMembersNames) do
					local member = Game.createNpc(name, pos)
					if member then
						member:setMasterPos(Position(pos))
						members[#members + 1] = member
					end
				end

				aidToCompany[aid] = members

				fireplace:transform(litFireplaceId)
				addEvent(function()
					fireplace:transform(unlitFireplaceId)
					fireplace:setActionId(aid)
					for _, member in pairs(aidToCompany[aid]) do
						member:remove()
					end
					aidToCompany[aid] = nil
				end, spawnTimer)
			end

			local function companyAlreadySpawnedAtAid(aid)
				return aidToCompany[aid] ~= nil
			end

			local fire = Action()
			function fire.onUse(player, fireplace, fromPosition, target, toPosition, isHotkey)
				local aid = fireplace:getActionId()
				if companyAlreadySpawnedAtAid(aid) then
					return false
				end
				if not hasRequiredState(player, aid) then
					return false
				end
				SpawnCompany(aid, fireplace)
				return true
			end

			for _, storage in pairs(Storage.ThreeSramatiansAndTheDragon.Fireplaces) do
				fire:aid(storage)
			end
			fire:register()
		end)
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission01.TalkToRomek,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "Shireajevo, year two thousand fifteen. Or was it {sixteenth}? Hmm, not sure...",
			},
			[{ "szesnasty", "sixteenth" }] = {
				text = "I remember now: it was the Year of Linux. Bambalf came to visit my father, Bilbeus. The wizard, as he entered the main room, said to my father, who was sprawled on the couch: 'Have you heard of an android so rich it sleeps on Passats?' and then sat down next to him. My {father} denied it and with unprecedented curiosity, added that they should sit down. Since they were already sitting, I assumed they wanted to sit over vodka that was just appeared on the table.",
			},
			[{ "ojca", "father" }] = {
				text = "Another time, my father invited Bambalf's hunting buddies. Apparently, they were already familiar with the story, as when the Wizard finally arrived, he didn't have to retell it from the beginning. Bambalf explained to my father that these friends were actually the unknown culprits behind the collapse of the state-owned farms around the Brzezinka Mountain. He also mentioned their sramatian roots and their supposed inheritance from an android sleeping on Passats. Later, they discussed some work agreement and a plan to take over a legitimate inheritance. I don't remember much of it because I was young and didn't understand all the words. Then they drank vodka, and they set off on a {journey}.",
			},
			[{ "droge", "journey" }] = {
				text = "From my father's {letters}, I learned that while traveling, they were accompanied by music. He wrote that the melody and vocals came from behind the screen, whatever that means. On the seventh day of the journey, when they decided to set up camp and go to sleep, something unexpected happened. Three sopranist Januses started singing: 'Memento mori es grande finali. Put their bodies in microwave, shall we!?' and then they broke the fourth wall. While revealing their vile faces they captured the adventurers. Then, fat Janus the Baritone (a hater of all changes, like compulsory zipper merging), turned the tide of action. While simultaneously addressing all the heroes of all times in all of the universe's history, he uttered these words: 'PRICKS' fat Janus the Baritone roasted the vile sopranists in the embers of Polish hatred, and then he returned to Olympus. With his departure, he left behind a map of Poland's roads. Since then, I haven't heard any mention of the Janus choir.",
			},
			[{ "listow", "letters" }] = {
				text = "From the most {recent} letters, I learned that they fought with mutts, homeless people, and other abominations. That was still within the borders of our Voivodeship. They reached the northern edge of the familiar territory, and just by the scent of the air, they knew that in this part of the country, people lived at least as well as the homeless in Hurghada. Being abroad, they were invited to a dinner (out of pity) by a camel farm owner. Then, they went to bed, I don't know where.",
			},
			[{ "aktualnych", "recent" }] = {
				text = "Three months have passed since the last letter, and I used to receive them at monthly intervals. That's why I got worried about their current condition. I can't leave my kingdom, but if you're determined, I can help you find them. Let me know when you're {ready}. In the meantime, I'll try to estimate their last location and possibly their current direction.",
			},
			[{ "ready", "gotowy" }] = {
				text = "I've placed their possible location in your quest log. Good luck. And as for the Janusz choir... aside from that people. I can lend you my scroll with various poems. Oh, and one more thing. Based on my estimates, the company may have passed near Goldblum's burrow. He's known for posing very difficult riddles, and failing to solve them ends, the very least, badly. You might want to go to someone who's escaped his clutches before - Far Myrrus.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission01] = 2,
					[Storage.ThreeSramatiansAndTheDragon.Mission02] = 1,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission02)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission02.FollowCompany,
		QuestFactory.Dialog("GM Romek", {
			[{ "goldbluma", "goldblum", "mission" }] = {
				text = "Seriusly, talk to Far Myrrus about Goldblum.",
			},
		}),
		QuestFactory.Dialog("Goldblum", {
			[{ GREET }] = {
				text = "What are you doing in my kosher cave? And you know what, I only have two entrances here: one normal and one through the toilet. I can smell which one you used, you pig.",
			},
			[{ "mission" }] = {
				text = "I'm Goldblum, and I feel like you'll want something from me that I won't want to give. Like money, for example. Or maybe you need {help}?",
			},
			[{ "way", "wyjsc", "help" }] = {
				text = "Alright, but you have to answer my {riddle}. Then I'll answer yours. If you lose, it's sex for money without money.",
			},
			[{ "riddle", "zagodke" }] = {
				text = "What determines the valuation of structured bonds, index certificates, participation certificates, and other structured products, you school-less wretch?",
				nextTopic = 1,
			},
			[{ ANY_MESSAGE }] = {
				text = "What are you trying? Answer immediately!",
				requiredTopic = 0,
			},
			[{ ANY_MESSAGE }] = {
				text = "No, no... now lets commence six for money. *licks his lips*",
				requiredTopic = 1,
			},
			[{
				"Od aktualnego poziomu indeksu gieldowego, kursu akcji, ceny surowca, kursu waluty lub innego wskaznika rynkowego, ktory stanowi ich instrument bazowy",
				"It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate or other market indicator that serves as their underlying instrument",
			}] = {
				text = "CUT THE CRAP! HOW DID YOU KNOW, YOU STUPID IDIOT!! Never mind. Ask your question - there's no question that will surprise my devious, vile mind.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission02] = 2,
				},
				requiredTopic = 1,
			},
		}),
		QuestFactory.Script(function(missionState)
			local goldBlumTrap = MoveEvent()

			function goldBlumTrap.onStepIn(player, item, position, fromPosition)
				if not player:isPlayer() then
					return true
				end

				if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.State) < 1 then
					return false
				end
				player:teleportTo(player:getPosition():Moved(0, 0, 1))
				player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
				return true
			end

			goldBlumTrap:type("stepin")
			goldBlumTrap:aid(Storage.ThreeSramatiansAndTheDragon.GoldblumTrap)
			goldBlumTrap:register()
		end)
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission02.SolvedGoldblumRiddle,
		QuestFactory.Dialog("Goldblum", {
			[{ GREET }] = { text = "So, give me the ryddle!" },
			[{ ANY_MESSAGE }] = {
				text = "SHIT, because YOU'RE BROKE! No? How can that be? You're not welcome here anymore. Others like you went through that wire, and I showed them the way to the hive. Farewell, scoundrel.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission02] = 3,
					[Storage.ThreeSramatiansAndTheDragon.Mission03] = 1,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission03)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission03.FindCompanyAtHive,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Look at him! He cant use a {toilet} properly.",
			},
			[{ "toilet", "latryny" }] = {
				text = "Anyway, soon we'll set out on a further journey. But perhaps, first, would you like to hear the prophecy about the legendary {neyghboor}?",
			},
			[{ "neyghboor", "somsiedzie" }] = {
				text = "...a specific scent not only woke up the companions of adventure but also woke up the vile neyghbor's cravings... Jan Kockodan gets annoyed when someone has it better than him. And he said this: 'This scent is everywhere. It's that dumbass Bilbo, a moron who can afford the hallway paneling. AFTER HIM!! Ugly mutts, run! Follow the scent of wealth!",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission03] = 2,
				},
				monstersToSpawn = { ["Thornfire Wolf"] = 5 },
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission03.AskBilbeusToJoin,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Those wolves were just spirits I summoned to better illustrate the story. The real Jan Kockodan is much more dangerous. If you want to join us, you must complete one challenge. Let's say you steal rum from these pirates here.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission03] = 3,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission03.FindRum,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "You can see them from our current location. Be careful; spirited water is only ordinary pastime, but rum on the other hand... It's their holy grail.",
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission03.BringRumToBilbeus,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission", "rum" }] = {
				text = "Mmm, delicious. Alright, comrades, it's time to move. See you on the coast at the western steppes.",
				requiredItems = { TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rum },
				textNoRequiredItems = "Come back with rum, or there's nothing to talk about.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission03] = 5,
					[Storage.ThreeSramatiansAndTheDragon.Mission04] = 1,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission04)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission04.FindCompanyAtSteppes,
		QuestFactory.Script(function(missionState)
			local updateStorages = {
				[Storage.ThreeSramatiansAndTheDragon.Mission04] = 2,
			}

			local FirePlace = Action()
			function FirePlace.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.State) ~= 7 then
					return false
				end
				player:UpdateStorages(updateStorages)
				return true
			end

			FirePlace:aid(Storage.ThreeSramatiansAndTheDragon.AbandonedFireplace)
			FirePlace:register()
		end)
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission04.FindCompanyAtHumanTown,
		QuestFactory.Dialog("Bilbeus", {
			[{ GREET }] = {
				text = "Sorry we went ahead, but we were bored in that wilderness.",
			},
			[{ "mission" }] = {
				text = "Let's head to the private docks of the vampire lords. They receive a daily supply of wine for the nobility. We'll sneak in there unnoticed. No one will figure out few bottles or barrels missing.",
				specialConditions = {
					{
						condition = TRZEJ_SRAMACI_I_SMOK_SPECIAL_CONDITIONS.playerIsDrunk,
						requiredOutcome = true,
						textNoRequiredCondition = "I have a great idea, but I won't tell you while you are sober. I'm already tipsy, now it's your turn.",
					},
				},
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission04] = 3,
					[Storage.ThreeSramatiansAndTheDragon.Mission05] = 1,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission04.StealWineFromVampires,
		QuestFactory.Script(function(missionState)
			local szczurKrolowConfig = {
				name = "rat of kings",
				pos = Position(6792, 558, 11),
			}

			local tileIn = MoveEvent()

			function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end

				local storageVal = player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.State)

				if storageVal < 21 or storageVal > 23 then
					return false
				end

				local pos = szczurKrolowConfig.pos
				local tile = Tile(pos)
				if not tile then
					return false
				end
				local monster = tile:getTopCreature()
				if monster then
					return false
				else
					Game.createNpc(szczurKrolowConfig.name, pos, false, false)
					pos:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end

			tileIn:aid(Storage.ThreeSramatiansAndTheDragon.RatOfKingsTile)
			tileIn:register()

			local tileOut = MoveEvent()

			function tileOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:isPlayer() then
					return false
				end
				local pos = szczurKrolowConfig.pos
				local tile = Tile(pos)
				if not tile then
					return false
				end
				local monster = tile:getTopCreature()
				if monster and not Tile(fromPosition):getTopCreature() and string.lower(monster:getName()) == "rat of kings" then
					monster:remove()
					pos:sendMagicEffect(CONST_ME_TELEPORT)
				end
			end

			tileOut:aid(Storage.ThreeSramatiansAndTheDragon.RatOfKingsTile)
			tileOut:register()
		end)
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission04.EscapeDungeon_FindGertrude,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "We played ourselves. We'll distract the guard, and you try to escape. If we succeed too, we'll meet up at Gertruda place. If we were tio separate, seek help from her.",
			},
		}),
		QuestFactory.Dialog("Gertrude", {
			[{ "mission" }] = {
				text = "Your team left me a note stating they headed to the desert. You can ask Lambor for help finding them.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission05] = 3,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission05)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission05.AskLamborForHelp,
		QuestFactory.Dialog("Lambor", {
			[{ "mission" }] = {
				text = "I know where you can find your friends. But first, I expect something in return. Bring me two dragon beefbottoms, and I'll help you.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission05] = 4,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission05.BringMeatToLambor,
		QuestFactory.Dialog("Lambor", {
			[{ "mission" }] = {
				text = "Your party went to the only source of pure water - the abandoned shack on the Wyvern Hill.",
				requiredItems = { { id = 3583, count = 2 } },
				textNoRequiredItems = "Come back with two dragon beefbottoms, and I promise I'll help you.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission05] = 5,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission05.FindCompanyAtWyverns,
		QuestFactory.Dialog("Lambor", {
			[{ ANY_MESSAGE }] = {
				text = "Your party went to the only source of pure water - the abandoned shack on the Wyvern Hill.",
			},
		}),
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Good thing you found us. I was starting to worry. No time for chit-chat. We tried to extract information about HF-P/X from the desert nomads. One of them claims to know where to find one of the ancient artifacts. We couldn't negotiate with them - maybe you can. Their settlement is in the north of the desert.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission05] = 6,
					[Storage.ThreeSramatiansAndTheDragon.Mission06] = 1,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission05)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission06.TalkToNomad,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Tourists in such a place are an easy target. I told one of the nomads that we wouldn't renovate their old town. Maybe you can offer him something in exchange for information. Currently, they're camped on one of the rocks in the north.",
			},
		}),
		QuestFactory.Dialog("Polychek", {
			[{ "mission" }] = {
				text = "I've been visited before by those who asked, 'spare any help, boss?' If you renovate my old town, we'll consider it. You can also bring me a crystal of the depths. Do one of these, and I'll surely reward you.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission06] = 2,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission06.BringDepthsCrystal,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Tourists in such a place are an easy target. I told one of the nomads that we wouldn't renovate their old town. Maybe you can offer him something in exchange for information. Currently, they're camped on one of the rocks in the north.",
			},
		}),
		QuestFactory.Dialog("Polychek", {
			[{ "mission" }] = {
				text = "What you're looking for is in the lizardmen village. The lizardmen stumbled upon underground bug light deposits, and now they're exploiting them to the max. However, they stumbled upon something much more powerful - an ancient artifact. My scouts told me they guard it like a treasure it is. They recently moved it to the highest tower.",
				requiredItems = { TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.deepCrystal },
				textNoRequiredItems = "If you don't know where to find the crystals, try diving into the sea east of here.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission06] = 3,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission06.ReportToBilbeus,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "I've heard of underground chocolate chip cookie deposits, but natural bud light formations, never. Are you sure about my truth? Well, okay. Go to the lizard village and try to find at least one bud light. In the meantime, we'll go to the Medusa Tower area. Zwalin wants to meet Marluk sister. Although now I come to think about it, we won't stay there long. Ultimately, we'll meet at Hairycles's.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission06] = 4,
					[Storage.ThreeSramatiansAndTheDragon.Mission07] = 1,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission07)
	:State(QuestState.ThreeSramatiansAndTheDragon.Mission07.FindArtifactAtVillage) --38f
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission07.FindCompanyAtHairycles,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Hairycles provided us with directions to HF-P/X's hideout. But first, we need to do him a favor. If possible, bring us about 2^log(10000) bananas.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission07] = 3,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission07.BringBananasToBilbeus,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Thanks for your help. Now we'll head to the eastern monkey village. Between the Kongo village and the monkey grove there lies a hidden entrance to the ruins of an ancient temple.",
				requiredItems = { { id = 3587, count = 16 } },
				textNoRequiredItems = "I need exactly 16 bananas to avoid embarassment in front of Hairycles.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission07] = 4,
					[Storage.ThreeSramatiansAndTheDragon.Mission08] = 1,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission08)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission08.FindCompanyAtHellspawnTemple,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "I have a feeling that Jan Kockodan got ahead of us. Maybe he's hiding somewhere in this hellish cave. Watch out for him! From the notes given to me by Hairycles, it appears that somewhere in this temple are enchanted doors. The key to opening them is to collect three different magical runes. Fortunately, all the runes are in the temple... if no one has stolen them.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission08] = 2,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission08.FindThreeMagicRunes,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Yes, those are all the needed runes. You can now try to find the enchanted doors I mentioned. Maybe we'll find HF-P/X here.",
				requiredItems = {
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune1,
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune2,
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune3,
				},
				removeRequiredItems = false,
				textNoRequiredItems = "Unfortunately, I don't know the exact location of the runes.",
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
					},
				},
			},
		}),
		QuestFactory.Dialog("Rat of Kings", {
			[{ "mission" }] = {
				text = "Don't wait for the sramatians. They're slacking on purpose to avoid having to fight {HF-P/X}. Besides, do you have all the {runes}?",
			},
			[{ "hfpx", "hf-p/x" }] = {
				text = "While you were traveling the world, I went to the library in Bydgoshch. I found information that HF-P/X terrorized an ancient temple where the treasury of Passats was located. For uncounted years, it's been hiding somewhere in the underground of that temple. I think he might want to use Passats in a fight. Perhaps he possesses necromantic abilities and can animate inanimate objects. Or maybe he'll use Passats as kamikaze projectiles? Don't wait for the sramats; they won't come.",
			},
			[{ "runy", "runes" }] = {
				text = "Yes, those are all the needed runes. You can now try to use the enchanted lever. Maybe we'll find HF-P/X here.",
				requiredItems = {
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune1,
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune2,
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune3,
				},
				textNoRequiredItems = "I see you don't have all the runes yet.",
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
					},
				},
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission08] = 3,
					[Storage.ThreeSramatiansAndTheDragon.Mission09] = 1,
					[Storage.ThreeSramatiansAndTheDragon.HfpxAccess] = 1,
				},
			},
		})
	)
	:Mission(Storage.ThreeSramatiansAndTheDragon.Mission09)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission09.FindAndDefeatHfpx,
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "Wait! Behind those doors might be HF-P/X! Try not to go too deep until we finish collecting, okay?",
			},
		}),
		QuestFactory.Dialog("Bilbeus", {
			[{ "mission" }] = {
				text = "I'm gonna stay here and have your back.",
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission09.ReportToRatOfKings,
		QuestFactory.Dialog("Rat of Kings", {
			[{ "mission" }] = {
				text = "WHAAAAAT??? How many Passats were lost there? I'm about to faint...",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission09] = 3,
				},
			},
		})
	)
	:State(
		QuestState.ThreeSramatiansAndTheDragon.Mission09.ReportToRomek,
		QuestFactory.Dialog("GM Romek", {
			[{ "mission" }] = {
				text = "I have bad news. The stress level of the Rat of Kings reached the maximum possible value upon hearing about the Passat wreckage. Rats, unlike humans, react differently to such circumstances. Their reaction is self-destruction of the organism and tearing the soul into billions of smaller rat souls and Schrodinger's souls, each existing and not existing at the same time. The only way to bring him back to life is to find all the Schrödinger's souls and separate them from the real rat ones. Leave this problem to me, as I need you for another {task}.",
				nextState = {
					[Storage.ThreeSramatiansAndTheDragon.Mission09] = 4,
					[Storage.Finished.ThreeSramatiansAndTheDragon] = 1,
					[Storage.FourActTragedy.Mission01] = 1,
				},
			},
		})
	)
QuestFactory.Script(function(missionState)
	local hfpxConfig = {
		actionid = Storage.ThreeSramatiansAndTheDragon.HfpxAccess,
		bossName = "Operator HF-P/X",
		timerStorage = Storage.ThreeSramatiansAndTheDragon.HfpxAccess,
		cooldown = "weekly",

		leverPosition = Position(6799, 552, 12),
		entranceGrid = {
			topLeft = Position(6795, 552, 12),
			downRight = Position(6798, 552, 12),
		},
		exitTeleportDestination = Position(6796, 554, 12),
		exitTeleportPosition = Position(6789, 548, 13),
		exitTeleportActionid = Storage.ThreeSramatiansAndTheDragon.Portals.AfterHfpx,

		bossPos = Position(6791, 550, 13),
		enterPos = Position(6801, 556, 13),
		durationMinutes = 10,
		corner1 = THREE_SRAMATIANS_AND_THE_DRAGON_ANCHOR:Moved(0, 0, 0),
		corner2 = THREE_SRAMATIANS_AND_THE_DRAGON_ANCHOR:Moved(15, 11, 0),

		requiredStorages = {
			[Storage.ThreeSramatiansAndTheDragon.HfpxAccess] = 1,
		},
	}
	RegisterEncounter(hfpxConfig)

	local lever = Action()

	function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		return UseEncounterLever(player, item, hfpxConfig)
	end

	lever:aid(hfpxConfig.actionid)
	lever:register()
end)
QuestFactory.Script(function(missionState)
	local updateStorages = {
		Storage.ThreeSramatiansAndTheDragon.State,
		Storage.ThreeSramatiansAndTheDragon.Mission05,
	}

	local cagePos = Position(6206, 918, 9)

	local vampireKidnapping = MoveEvent()

	function vampireKidnapping.onStepIn(player, item, position, fromPosition)
		if not player:isPlayer() then
			return true
		end

		if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.State) ~= 9 then
			return false
		end
		player:teleportTo(cagePos)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:IncrementStorages(updateStorages)
		return true
	end

	vampireKidnapping:type("stepin")
	vampireKidnapping:aid(Storage.ThreeSramatiansAndTheDragon.VampireCityTrap)
	vampireKidnapping:register()
end)
