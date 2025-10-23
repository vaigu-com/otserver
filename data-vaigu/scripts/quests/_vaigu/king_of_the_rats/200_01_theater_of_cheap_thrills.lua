local quest = Quest(LOCALIZERS.TheaterOfCheapThrills)

quest
	:Storage(function()
		Storage.TheaterOfCheapThrills = {
			Mission01 = {},
			Cheese = {},
			Mission02 = {},
			Mission03 = {},
			PlusShapePuzzle = {
				Tile = {},
				TileBeforeBook = {},
				MachineNorth = {},
				MachineCenter = {},
				MachineWest = {},
				Book = {},
				AccessDoor = {},
			},
			MissPizzaSpawn = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			RobercikSpawn = {},
			Mission07 = {},
			Mission08 = {},
			Mission09 = {},
			JuerdoTitsgoSpawn = {},
			BrazilMap = {},
			Mission10 = {},
		}
		QuestState.TheaterOfCheapThrills = {
			Mission01 = {
				AskRomekForMission = 1,
				FindCheese = 2,
			},
			Mission02 = {
				StartTheTest = 1,
				PassTheTest = 2,
			},
			Mission03 = {
				AskRomekForMission = 1,
				DefeatMissPitca = 2,
				ReportKillToRomek = 3,
				AskGravedigger_FindBook = 4,
				ReportToRomek = 5,
			},
			Mission04 = {
				AskRomekForMission = 1,
				EstablishFoodProvision = 2,
				BringGarlicToKebabMaster = 3,
				ReportToRomek = 4,
			},
			Mission05 = {
				AskRomekForMission = 1,
				AskArniForCamp = 2,
				ReportToKitz = 3,
				ReportToRomek = 4,
			},
			Mission06 = {
				AskRomekForMission = 1,
				FindRobercik = 2,
				ReportToRomek = 3,
			},
			Mission07 = {
				AskRomekForMission = 1,
				DonateToRomek = 2,
				WaitForFestivalToEnd = 3,
			},
			Mission08 = {
				AskRomekForMission = 1,
				TipVislavToStayAwayFromRomekServer = 2,
				ObserveRomekReaction = 3,
			},
			Mission09 = {
				AskRomekForMission = 1,
				FindBrazilMap = 2,
				PassMapToRomek = 3,
				TrackAndKillJuerdo = 4,
				ReportToRomek = 5,
			},
			Mission10 = {
				AskRomekForMission = 1,
				CommitRatocide = 2,
			},
		}
		QuestTopics.TheaterOfCheapThrills = {
			ConfirmCampDestination = 1,
			RevealKingPowers = 2,
			AnswerKingIsAlso = 3,
			TranslateCustodian = 4,
		}
	end)
	:Constant(function()
		SpawnLocks.TheaterOfCheapThrills = {
			Pitca = SpawnLock(),
			Robercik = SpawnLock(),
			Juerdo = SpawnLock(),
		}
		QuestKeyItems.TheaterOfCheapThrills = {
			Cheese = { id = 3607, key = Storage.TheaterOfCheapThrills.Cheese, desc = "100 Year Old Aged Cheese" },
		}
		TEATR_TANIEJ_SENSACJI_PLUS_SHAPE = {
			unlitToLit = { [28458] = 28459, [28452] = 28453, [28454] = 28455, [28456] = 28457 },
			litToUnlit = { [28459] = 28458, [28453] = 28452, [28455] = 28454, [28457] = 28456 },
			keyToMachineConfig = {
				[Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineNorth] = {
					topLeft = LIBRUM_VORTEX_ANCHOR:Moved(5, -1, 0),
					downRight = LIBRUM_VORTEX_ANCHOR:Moved(9, 3, 0),
					pillar = { pos = Vector(-4, -12, 0), litId = 28138, unlitId = 28890 },
				},
				[Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineCenter] = {
					topLeft = LIBRUM_VORTEX_ANCHOR:Moved(3, 9, 0),
					downRight = LIBRUM_VORTEX_ANCHOR:Moved(5, 11, 0),
					pillar = { pos = Vector(-2, -12, 0), litId = 28140, unlitId = 28891 },
				},
				[Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineWest] = {
					topLeft = LIBRUM_VORTEX_ANCHOR:Moved(-9, 11, 0),
					downRight = LIBRUM_VORTEX_ANCHOR:Moved(-6, 15, 0),
					pillar = { pos = Vector(-4, -13, 1), litId = 28137, unlitId = 28889 },
				},
			},
			book = { lit = 28139, unlit = 28888, pos = { x = -3, y = -12, z = 0 } },
		}
		QuestRewards.OutfitsAddons.ThreaterOfCheapThrills = {
			Raccoon1 = {
				{ outfitId = 1371, addons = 0 },
				{ outfitId = 1372, addons = 0 },
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Theater of Cheap Thrills",
			localizer = localizer,
			missions = {
				{
					name = "01. Vitat Iustitia",
					storage = Storage.TheaterOfCheapThrills.Mission01,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission01.AskRomekForMission] = "Many people ask: Who is this King of Rats and what's the deal? That's when I tell them, 'You stinker, go to Ratland and see for yourself. The King of Rats! Lets go! Yeehaw!",
						[QuestState.TheaterOfCheapThrills.Mission01.FindCheese] = "Romek assigned you the task of finding mature cheese in the pirates' hideout.",
						[MISSION_FINISHED] = "Chorus of Januses: A strange trumpet will spread a sound, fire will coagulate, the light will dim, and the world's history will turn to dust. From the trees of eternity, leaves will fall on the Judge's dreadful coming to bear witness to the Psalmist.",
					},
				},
				{
					name = "02. I'm Not a Rat's Fugue",
					storage = Storage.TheaterOfCheapThrills.Mission02,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission02.StartTheTest] = "Romek has offered you a position as his assistant. However, you must first pass a fair test.",
						[QuestState.TheaterOfCheapThrills.Mission02.PassTheTest] = "Pass the fair test to become the King of Rats assistant.",
						[MISSION_FINISHED] = "Chorus of Januses: My radiance will pierce the Darkness, My brilliance will scatter the Shadows, ~Your father drunkard after a case of beers.",
					},
				},
				{
					name = "03. Good Day, Mrs. Pitca",
					storage = Storage.TheaterOfCheapThrills.Mission03,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission03.AskRomekForMission] = "Romek needs help with a new task. Go to him.",
						[QuestState.TheaterOfCheapThrills.Mission03.DefeatMissPitca] = "Defeat Romek's supposed enemy, Mrs. Pitca.",
						[QuestState.TheaterOfCheapThrills.Mission03.ReportKillToRomek] = "You defeated Mrs. Pitca, now return to Romek.",
						[QuestState.TheaterOfCheapThrills.Mission03.AskGravedigger_FindBook] = "Romek mentioned that Grave Digger might know how to remove curses. Try to get the necessary information from him.",
						[QuestState.TheaterOfCheapThrills.Mission03.ReportToRomek] = "You found a book that can help Romek. Return to him now.",
						[MISSION_FINISHED] = "Chorus of Januses: Let us rejoice, brothers! Enough of tears! Our victory is complete! To the fighters, honor, to the fallen, respect! Let the earth carry a laudatory song! We poured sweat and blood But our glory is against the enemy! Although each of us has lost much, Let us rejoice, brothers! It's time for victory!",
					},
				},
				{
					name = "04. Ham from under the Rug",
					storage = Storage.TheaterOfCheapThrills.Mission04,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission04.AskRomekForMission] = "Romek needs help with a new task. Go to him.",
						[QuestState.TheaterOfCheapThrills.Mission04.EstablishFoodProvision] = "Romek has assigned you the task of catering his kebab party.",
						[QuestState.TheaterOfCheapThrills.Mission04.BringGarlicToKebabMaster] = "Shivganesh needs three garlic heads and payment for making the kebabs.",
						[QuestState.TheaterOfCheapThrills.Mission04.ReportToRomek] = "Shivganesh has promised to deliver the kebabs on time. Deliver the good news to Romek.",
						[MISSION_FINISHED] = "Chorus of Januses: How great is the peace gained by one who does not heed what a neighbor says, does, or thinks, but only what they themselves do, to be just and godly.",
					},
				},
				{
					name = "05. Holiday Camp, you know where",
					storage = Storage.TheaterOfCheapThrills.Mission05,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission05.AskRomekForMission] = "GM Romek needs help with a new problem, go to him.",
						[QuestState.TheaterOfCheapThrills.Mission05.AskArniForCamp] = "Organize a camp for Romek's son, Kitz. Arni will assist you with this task.",
						[QuestState.TheaterOfCheapThrills.Mission05.ReportToKitz] = "Inform Kitz that his trip is ready.",
						[QuestState.TheaterOfCheapThrills.Mission05.ReportToRomek] = "You have completed the task for Romek. Return to him now for your reward.",
						[MISSION_FINISHED] = "Chorus of Januses: Peace on all peaks. In leaves, in valleys Nothing.",
					},
				},
				{
					name = "06. King of Rats' Gambit",
					storage = Storage.TheaterOfCheapThrills.Mission06,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission06.AskRomekForMission] = "GM Romek needs help with a new problem, go to him.",
						[QuestState.TheaterOfCheapThrills.Mission06.FindRobercik] = "GM Romek is afraid for his life. Try to find Robercik before he finds Romek.",
						[QuestState.TheaterOfCheapThrills.Mission06.ReportToRomek] = "You defeated the cunning Robercik. Return to Romek for your reward.",
						[MISSION_FINISHED] = "Chorus of Januses: I was sent to break the chains of justice. This time, he will perish along with his soul.",
					},
				},
				{
					name = "07. The Art That of Just",
					storage = Storage.TheaterOfCheapThrills.Mission07,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission07.AskRomekForMission] = "GM Romek needs help with a new problem, go to him.",
						[QuestState.TheaterOfCheapThrills.Mission07.DonateToRomek] = "GM Romek will be waiting for donations until his death. It's better to support him.",
						[QuestState.TheaterOfCheapThrills.Mission07.WaitForFestivalToEnd] = "GM Romek has accepted your donation. Return to him when the festival is over.",
						[MISSION_FINISHED] = "Chorus of Januses: Iuvenes inconsiderate patrum suorum errata repetunt. Canem me rape cum cacat.",
					},
				},
				{
					name = "08. Abyssal Chasms of Decadence",
					storage = Storage.TheaterOfCheapThrills.Mission08,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission08.AskRomekForMission] = "GM Romek needs help with a new problem, go to him.",
						[QuestState.TheaterOfCheapThrills.Mission08.TipVislavToStayAwayFromRomekServer] = "GM Romek is starting a new minecraft server. Tell Vislav, a frequent visitor to old school servers, about Romek's known scams and acts of corruption.",
						[QuestState.TheaterOfCheapThrills.Mission08.ObserveRomekReaction] = "You tipped off Vislav. Now return to Romek and observe his reaction.",
						[MISSION_FINISHED] = "Chorus of Januses: The human form is above spider filth. Cunning is a virtue; the king of rats is a coward.",
					},
				},
				{
					name = "09. Cocoa Intruder",
					storage = Storage.TheaterOfCheapThrills.Mission09,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission09.AskRomekForMission] = "GM Romek needs help with a new problem, go to him.",
						[QuestState.TheaterOfCheapThrills.Mission09.FindBrazilMap] = "GM Romek instructed you to find the map of the leader of the southern Orcs.",
						[QuestState.TheaterOfCheapThrills.Mission09.PassMapToRomek] = "You obtained information about the location of Brazil. Pass the gathered information to Romek.",
						[QuestState.TheaterOfCheapThrills.Mission09.TrackAndKillJuerdo] = "You learned that King Juerdo Titsgo is ddosing Romek's server. He should be hiding in the vicinity of Brazilian Rats' Land. Knock him out so that Romek can run the server peacefully.",
						[QuestState.TheaterOfCheapThrills.Mission09.ReportToRomek] = "You gave Juerdo a beating. Return to Romek for your reward.",
						[MISSION_FINISHED] = "Chorus of Januses: He will be the patron of chances! For the work of destruction in a good cause is holy, like the work of creation. The king renounced his word - become a king and perish. When faith and freedom escape from people.",
					},
				},
				{
					name = "10. Forever and Ever Ytong",
					storage = Storage.TheaterOfCheapThrills.Mission10,
					states = {
						[QuestState.TheaterOfCheapThrills.Mission10.AskRomekForMission] = "The lives of the rats are in danger! Hurry to Romek.",
						[QuestState.TheaterOfCheapThrills.Mission10.CommitRatocide] = "Romek has ordered you to commit ratocide. Carry out his will and don't ask questions.",
						[MISSION_FINISHED] = "Chorus of Januses: We won't leave the land where we were born! It's written in our atlases! Justice will come in a stench! Do you know who ran over whom on the zebra crossing? Three Januses sing soprano: The time for trials has come! Give us a knife! Give us a knife! Our rich neighbor won't be! Go on, cut! Go on, cut! fat Janus the Baritone: LET'S KILL THEM!",
					},
				},
			},
		})
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.TheaterOfCheapThrills.Mission03] = QuestState.TheaterOfCheapThrills.Mission03.ReportKillToRomek,
		}
		local pitcaDeath = CreatureEvent("PitcaDeath")
		function pitcaDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			SpawnLocks.TheaterOfCheapThrills.Pitca:Reset()
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValueByKey(Storage.TheaterOfCheapThrills.Mission03)
				if storage_val ~= QuestState.TheaterOfCheapThrills.Mission03.DefeatMissPitca then
					return true
				end
				player:NextState(nextState)
			end)
			return true
		end
		pitcaDeath:register()
	end)
	:MonsterEvent(function()
		local nextState = {
			[Storage.TheaterOfCheapThrills.Mission06] = QuestState.TheaterOfCheapThrills.Mission06.ReportToRomek,
		}
		local robercikDeath = CreatureEvent("RobercikDeath")
		function robercikDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end

			SpawnLocks.TheaterOfCheapThrills.Robercik:Reset()
			onDeathForDamagingPlayers(creature, function(creature, player)
				local storage_val = player:getStorageValueByKey(Storage.TheaterOfCheapThrills.Mission06)
				if storage_val ~= QuestState.TheaterOfCheapThrills.Mission06.FindRobercik then
					return true
				end
				player:NextState(nextState)
			end)
			return true
		end
		robercikDeath:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Juerdo Titsgo")
		local monster = {}

		monster.description = "Juerdo Titsgo"
		monster.experience = 4999
		monster.outfit = {
			lookType = 56,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 4000
		monster.maxHealth = 3717
		monster.race = "blood"
		monster.corpse = 5964
		monster.speed = 200
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4999,
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
			"JuerdoDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.summon = {
			maxSummons = 10,
			summons = {
				{ name = "Snake", chance = 50, interval = 2000, count = 4 },
				{ name = "Cobra", chance = 50, interval = 2000, count = 3 },
				{ name = "Wyvern", chance = 10, interval = 2000, count = 1 },
			},
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -50 },
			{
				name = "combat",
				interval = 2000,
				chance = 70,
				type = COMBAT_ENERGYDAMAGE,
				minDamage = -70,
				maxDamage = -20,
				range = 1,
				shootEffect = CONST_ANI_ENERGY,
				target = false,
			},
			{
				name = "combat",
				interval = 2000,
				chance = 60,
				type = COMBAT_LIFEDRAIN,
				minDamage = -50,
				maxDamage = -20,
				length = 8,
				spread = 0,
				effect = CONST_ME_PURPLEENERGY,
				target = false,
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
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Miss Pitca")
		local monster = {}

		monster.description = "Miss Pitca"
		monster.experience = 100
		monster.outfit = {
			lookType = 156,
			lookHead = 94,
			lookBody = 78,
			lookLegs = 97,
			lookFeet = 114,
			lookAddons = 1,
			lookMount = 0,
		}

		monster.health = 300
		monster.maxHealth = 300
		monster.race = "undead"
		monster.corpse = 0
		monster.speed = 200
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4999,
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
			"PitcaDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -30 },
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
			{ type = "outfit", condition = false },
		}

		mType:register(monster)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Robercik")
		local monster = {}

		monster.description = "Robercik"
		monster.experience = 1245
		monster.outfit = {
			lookType = 97,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 729
		monster.maxHealth = 729
		monster.race = "blood"
		monster.corpse = 18190
		monster.speed = 200
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 4999,
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
			"RobercikDeath",
		}

		monster.light = {
			level = 0,
			color = 0,
		}

		monster.voices = {}

		monster.loot = {
			{ name = "gold coin", chance = 67740, maxCount = 100 },
			{ id = 3123, chance = 8986 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -50 },
			{
				name = "combat",
				interval = 2000,
				chance = 20,
				type = COMBAT_PHYSICALDAMAGE,
				minDamage = 0,
				maxDamage = -30,
				range = 4,
				shootEffect = CONST_ANI_THROWINGKNIFE,
				target = false,
			},
		}

		monster.defenses = {
			defense = 15,
			armor = 15,
			{ name = "invisible", interval = 2000, chance = 10, effect = CONST_ME_MAGIC_BLUE },
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
			{ type = "paralyze", condition = false },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		mType:register(monster)
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission01)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission01.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "*Muttering*",
				},
				[{ ANY_MESSAGE }] = {
					text = "O tempora, {o mores}! What do you want from me?",
				},
				[{ "o mores" }] = {
					text = "Maybe the punishment was appropriate for my actions. Nevertheless, I don't want to return to society; not as Tomek. Here, in Ratland, nobody knows me. By the way, what was all that fuss about the King of Rats? Anyway, it doesn't matter because I will become the King of Rats. Propane, butane, I have a cunning plan. I'll have to impress the rats to be crowned as their new monarch. Maybe you'd like to help me?",
				},
				[{ "yes", "tak" }] = {
					text = "This will be your first task: find something that rats crave the most - cheese. But it can't be just any cheese from under someone's foreskin or parmesan growing under fingernails. These rats have access to the latest cheeses, and they won't be impressed. To satisfy them, you'll have to find the legendary matured cheese with flowers. It's possible that the pirates have such cheese. It's probably well hidden. Their hideout is on the southern shore of Hurghada.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission01] = QuestState.TheaterOfCheapThrills.Mission01.FindCheese,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission01.FindCheese,
			QuestFactory.Dialog("GM Romek", {
				[{ "yes", "tak" }] = {
					text = "Thanks for the cheese. Your further help might be... helpful in my future reign. If you want, I can appoint you as my {assistant}.",
					requiredItems = {
						QuestKeyItems.TheaterOfCheapThrills.Cheese,
					},
					textNoRequiredItems = "Return when you've obtained the special cheese.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission01] = MISSION_FINISHED,
						[Storage.TheaterOfCheapThrills.Mission02] = QuestState.TheaterOfCheapThrills.Mission02.StartTheTest,
					},
				},
				[{ "no", "nie" }] = { text = "Return when you've obtained the special cheese." },
				[{ GREET }] = {
					text = "Hello, |PLAYERNAME|. Do you have the special cheese I asked for?",
				},
			}),
			QuestFactory.OnUseDeclarations({
				{
					id = 2472,
					key = Storage.TheaterOfCheapThrills.Cheese,
					rewards = { QuestKeyItems.TheaterOfCheapThrills.Cheese },
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission02)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission02.StartTheTest,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "If you want to become my assistant, you must pass the ratometer test. Are you ready?",
				},
				[{ "yes", "tak", "pomocnika", "assistant" }] = {
					text = "Who is the King of Rats, and what is his power?",
					nextTopic = QuestTopics.TheaterOfCheapThrills.RevealKingPowers,
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission02] = QuestState.TheaterOfCheapThrills.Mission02.PassTheTest,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission02.PassTheTest,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "If you want to become my assistant, you must pass the ratometer test. Are you ready?",
				},
				[{ "yes", "tak" }] = {
					text = "Who is the King of Rats, and what is his power?",
					nextTopic = QuestTopics.TheaterOfCheapThrills.RevealKingPowers,
				},
				[{ ANY_MESSAGE }] = {
					text = "Now, the next question: The King of Rats is a ruler who is aggressive but ...?",
					requiredTopic = QuestTopics.TheaterOfCheapThrills.RevealKingPowers,
					nextTopic = QuestTopics.TheaterOfCheapThrills.AnswerKingIsAlso,
				},
				[{ ANY_MESSAGE }] = {
					text = "You're doing well. Now it's time for the third and final task. Translate 'Custodian' to Polish.",
					requiredTopic = QuestTopics.TheaterOfCheapThrills.AnswerKingIsAlso,
					nextTopic = QuestTopics.TheaterOfCheapThrills.TranslateCustodian,
				},
				[{ "kurator", "kustosz", "custodian", "curator" }] = {
					text = "I appoint you as a rat that there are many! Come back in some time, and I'll surely find a responsible task for you.",
					requiredTopic = QuestTopics.TheaterOfCheapThrills.TranslateCustodian,
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission03] = QuestState.TheaterOfCheapThrills.Mission03.AskRomekForMission,
						[Storage.TheaterOfCheapThrills.Mission02] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission03)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission03.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Find my eternal enemy, tormentor, and oppressor, even though children in Africa are starving: Ms. Pitca, and arrange a Brazilian elevator for her. From the latest memes I read, she was heading towards Siberia. She seems to have her mother's intelligence, so you shouldn't have trouble dealing with her.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission03] = QuestState.TheaterOfCheapThrills.Mission03.DefeatMissPitca,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission03.DefeatMissPitca,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "Ms. Pitca is somewhere in Siberia. She might have tried to schmooze with the Business Giants.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local tile = MoveEvent()

				local lock = SpawnLocks.TheaterOfCheapThrills.Pitca
				function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
					if not player or not player:isPlayer() then
						return
					end

					if not player:HasExactMissionState(missionState) then
						return
					end

					if lock:IsSet() then
						return
					end

					lock:Set(Game.createMonster("Miss Pitca", player:getPosition()))
				end

				tile:key(Storage.TheaterOfCheapThrills.MissPizzaSpawn)
				tile:register()
			end)
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission03.ReportKillToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = { text = "Hello. Have you completed the task yet?" },
				[{ "yes", "tak" }] = {
					text = "What have you done? Brain-dead oppressor, tyrant, penguin of Madagascar, smarty pants, brainless killer, scoundrel. Oh no, it's me. I made a magical vow with Ms. Pitca. If I ever mention Ms. Pitca to anyone, I'll age a hundred times faster than a regular person. I think I have no more than a few months left to live. Here's the battle mission: I want you to try to remove this curse from me. Maybe the grave digger can help me at a costly but fair price.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission03] = QuestState.TheaterOfCheapThrills.Mission03.AskGravedigger_FindBook,
						[Storage.TheaterOfCheapThrills.PlusShapePuzzle.AccessDoor] = ACCESS_GRANTED,
					},
					rewards = { ExerciseWeaponBox(500) },
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission03.AskGravedigger_FindBook,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = { text = "Aaaaa!!!" },
				[{ "mission", "misja" }] = {
					text = "It's you again? If you're looking for the grave digger, you'll find him in Mirko. He runs his office supply store there.",
				},
			}),
			QuestFactory.Dialog("Grave Digger", {
				[{ "mission", "misja", "klatwa", "curse" }] = {
					text = "Yes, I'm somewhat knowledgeable about lifting curses, but which curse are you specifically referring to?",
				},
				[{ "ytong", "nie wiem", "i dont know", "idk", "nwm" }] = {
					text = "Particularly nasty, indeed. I'll have to ask you to go to a certain place. To lift the curse, you'll need to provide the cursed one with a secret passphrase. Unfortunately, I don't know that passphrase, but a special spell {book} might assist you.",
				},
				[{ "ksiega", "book" }] = {
					text = "The book is hidden behind magical mechanisms, deep within the caverns of the Stone Golems on Hurghad Island. The machines inside were created by someone named -stein, so take lot of gold coins with you.",
				},
			}),
			QuestFactory.OnUseDeclarations({
				{
					key = Storage.TheaterOfCheapThrills.PlusShapePuzzle.Book, -- dont change
					nextState = {
						[Storage.KingOfRatsHQ.CollectibleArtifacts.LibrumVortex] = 1,
						[Storage.TheaterOfCheapThrills.Mission03] = QuestState.TheaterOfCheapThrills.Mission03.ReportToRomek,
					},
					requiredstate = {
						[Storage.TheaterOfCheapThrills.Mission03] = QuestState.TheaterOfCheapThrills.Mission03.AskGravedigger_FindBook,
					},
					rewards = { QuestKeyItems.KingOfRatsHQ.LibrumVortex },
				},
			}),
			QuestFactory.Script(function(missionState)
				local function areAllMachinePillarsLit(machineConfigs)
					for _, machineConfig in pairs(machineConfigs) do
						local pos = machineConfig.pillar.pos
						local litId = machineConfig.pillar.litId
						if not Tile(LIBRUM_VORTEX_ANCHOR:Moved(pos)):getItemById(litId) then
							return false
						end
					end
					return true
				end

				local function unlitAllMachinePillars(machineConfigs)
					for _, machineConfig in pairs(machineConfigs) do
						local pos = machineConfig.pillar.pos
						local unlitId = machineConfig.pillar.unlitId
						local litId = machineConfig.pillar.litId
						Tile(LIBRUM_VORTEX_ANCHOR:Moved(pos)):getItemById(litId):transform(unlitId)
					end
				end

				local tileBeforeBook = MoveEvent()
				function tileBeforeBook.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
					if not player or not player:isPlayer() then
						return
					end

					local machineConfigs = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.keyToMachineConfig
					if not areAllMachinePillarsLit(machineConfigs) then
						return
					end

					unlitAllMachinePillars(machineConfigs)

					local litBookId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.lit
					local unlitBookId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.unlit
					local pos = LIBRUM_VORTEX_ANCHOR:Moved(TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.book.pos)
					local bookStand = Tile(pos):getItemById(unlitBookId)
					bookStand:transform(litBookId)
					bookStand:setKey(Storage.TheaterOfCheapThrills.PlusShapePuzzle.Book)

					player:say(player:Localizer(LOCALIZERS.TheaterOfCheapThrills):Get("The book has been unsealed. You have one minute before its closed."), TALKTYPE_MONSTER_SAY)
					addEvent(function()
						bookStand:transform(unlitBookId)
						bookStand:setKey()
					end, 60 * 1000)
					return true
				end
				tileBeforeBook:key(Storage.TheaterOfCheapThrills.PlusShapePuzzle.TileBeforeBook)
				tileBeforeBook:type("stepin")
				tileBeforeBook:register()
			end),
			QuestFactory.Script(function(missionState)
				local function getConfigByKey(key)
					return TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.keyToMachineConfig[key]
				end

				local function resetArea(config)
					IterateBetweenPositions(config.topLeft, config.downRight, function(context)
						local pos = context.pos
						local ground = Tile(pos):getGround()
						local groundId = ground:getId()
						local unlitId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.litToUnlit[groundId]
						if unlitId then
							Tile(pos):getItemById(groundId):transform(unlitId)
						end
						return true
					end)
				end

				local function isPuzzleCompleted(config)
					return IterateBetweenPositions(config.topLeft, config.downRight, function(context)
						local pos = context.pos
						local groundId = Tile(pos):getGround():getId()
						if TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.unlitToLit[groundId] then
							return false
						end
						return true
					end, { stopCondition = STOP_CONDITIONS.isFalse })
				end

				local function lightUpPillar(config)
					local tile = Tile(LIBRUM_VORTEX_ANCHOR:Moved(config.pillar.pos))
					local item = tile:getItemById(config.pillar.unlitId)
					if item then
						item:transform(config.pillar.litId)
					end
				end

				local device = Action()
				function device.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local config = getConfigByKey(item:getKey())
					if not isPuzzleCompleted(config) then
						resetArea(config)
						fromPosition:sendMagicEffect(CONST_ME_POFF)
						return false
					end
					resetArea(config)
					fromPosition:sendMagicEffect(CONST_ME_ENERGYHIT)

					lightUpPillar(config)
					return true
				end

				device:key(Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineNorth)
				device:key(Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineWest)
				device:key(Storage.TheaterOfCheapThrills.PlusShapePuzzle.MachineCenter)
				device:register()
			end),
			QuestFactory.Script(function(missionState)
				local function swapTile(pos)
					local tile = Tile(pos):getGround()
					local anyid = tile.itemid
					local nextid = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.litToUnlit[anyid] or TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.unlitToLit[anyid]

					if tile then
						tile:transform(nextid)
					end
				end

				local function swapNearby(pos)
					swapTile(Position(pos.x + 0, pos.y + 0, pos.z + 0))
					swapTile(Position(pos.x + 1, pos.y + 0, pos.z + 0))
					swapTile(Position(pos.x + 0, pos.y + 1, pos.z + 0))
					swapTile(Position(pos.x - 1, pos.y + 0, pos.z + 0))
					swapTile(Position(pos.x + 0, pos.y - 1, pos.z + 0))
				end

				local plus = MoveEvent()

				function plus.onAddItem(moveitem, tileitem, toPosition)
					if moveitem.itemid ~= 3031 then
						return false
					end

					moveitem:remove(1)
					swapNearby(toPosition)
				end

				plus:key(Storage.TheaterOfCheapThrills.PlusShapePuzzle.Tile)
				plus:type("additem")
				plus:register()
			end)
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission03.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "So, do you have what Grave Digger talked about?",
				},
				[{ "mission", "misja", "yes", "tak" }] = {
					text = "Thanks, I'll check the effect of this book right away. Here's your reward.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission03] = MISSION_FINISHED,
						[Storage.TheaterOfCheapThrills.Mission04] = QuestState.TheaterOfCheapThrills.Mission04.AskRomekForMission,
					},
					rewards = { ExerciseWeaponBox(400) },
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission04)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission04.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "I'm planning a party soon, and I need some catering. We can't rely on Ms. Pitca's services anymore, so I thought about ordering kebabs. Go to Shivganesh and ask him about the possibility of organizing a kebab set.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission04] = QuestState.TheaterOfCheapThrills.Mission04.EstablishFoodProvision,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission04.EstablishFoodProvision,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "Shivganesh has his bar right by the docks of Hurghada. The town is tiny, so you should be able to find it easily.",
				},
			}),
			QuestFactory.Dialog("Shivganesh", {
				[{ "mission", "misja", "kebab" }] = {
					text = "Sure, I can prepare such an order. Lately, I've been running low on garlic, so you'll have to manage with about three bulbs. The order will cost 8 platinum coins.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission04] = QuestState.TheaterOfCheapThrills.Mission04.BringGarlicToKebabMaster,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission04.BringGarlicToKebabMaster,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "Shivganesh has his bar right by the docks of Hurghada. The town is tiny, so you should be able to find it easily.",
				},
			}),
			QuestFactory.Dialog("Shivganesh", {
				[{ "mission", "misja", "czosnek", "garlic", "kebab" }] = {
					text = "Thanks for the help. Let Tom know that I'll deliver the kebabs on time",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission04] = QuestState.TheaterOfCheapThrills.Mission04.ReportToRomek,
					},
					requiredItems = {
						{ id = 8197, count = 3 },
					},
					requiredMoney = 800,
					textNoRequiredItems = "Return when you have three garlic cloves. And don't forget about the payment of 8 platinum coins.",
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission04.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Thanks for your help. Here's your reward.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission04] = MISSION_FINISHED,
						[Storage.TheaterOfCheapThrills.Mission05] = QuestState.TheaterOfCheapThrills.Mission05.AskRomekForMission,
					},
					rewards = { ExerciseWeaponBox(400) },
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission05)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission05.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "My missing son Kitz is trying to reconnect. Unfortunately, it wasn't easy to shoo him off. The ingrate has been taking alimony all his life, and now that he's of age, he has to earn his own living. A thief will steal anything that's not nailed to the ground. He's trying to find me to leech off me. No way. You need to get him involved in a camp, preferably a concentration camp. First, go to Arni, who deals with organizing trips.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission05] = QuestState.TheaterOfCheapThrills.Mission05.AskArniForCamp,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission05.AskArniForCamp,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Arni guards the south gate of the mirkocity.",
				},
			}),
			QuestFactory.Dialog("Arni", {
				[{ "kitz", "romek", "oboz", "camp", "trip", "wycieczka" }] = {
					text = "Okay, done. Tell Kitz not to bring anything but pajamas.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission05] = QuestState.TheaterOfCheapThrills.Mission05.ReportToKitz,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission05.ReportToKitz,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "My son is on the watch at the eastern gate.",
				},
			}),
			QuestFactory.Dialog("[SOLID] Kitz", {
				[{ "mission", "misja" }] = {
					text = "Hmm, are you sure it's just a regular camp?",
					nextTopic = QuestTopics.TheaterOfCheapThrills.ConfirmCampDestination,
				},
				[{ "yes", "tak" }] = {
					text = "Okay, then tell Arni I'd love to go there.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission05] = QuestState.TheaterOfCheapThrills.Mission05.ReportToRomek,
					},
					requiredTopic = QuestTopics.TheaterOfCheapThrills.ConfirmCampDestination,
				},
				[{ "no", "nie" }] = {
					text = "What? Is it a concentration camp? Are you crazy? If that's what he wanted to do to me, I'll stay away from him.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission05] = QuestState.TheaterOfCheapThrills.Mission05.ReportToRomek,
					},
					requiredTopic = QuestTopics.TheaterOfCheapThrills.ConfirmCampDestination,
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission05.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = { text = "So, did you manage to complete my {mission}?" },
				[{ "mission", "misja", "misje" }] = {
					text = "Thanks, finally, that scoundrel got what he deserved.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission05] = MISSION_FINISHED,
						[Storage.TheaterOfCheapThrills.Mission06] = QuestState.TheaterOfCheapThrills.Mission06.AskRomekForMission,
					},
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission06)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission06.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Listen, lad. I heard that the previous King of Rats, Robercik, has returned from his delegation. The stupid rats forgot that he used to be king, and when he tried to enter my kingdom, they kicked him out. I think he might have sneaked in somewhere, and now he's waiting for an opportunity to harm me. Injustice comes back like a boomerang.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission06] = QuestState.TheaterOfCheapThrills.Mission06.FindRobercik,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission06.FindRobercik,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = { text = "I don't know where he could be..." },
			}),
			QuestFactory.Script(function(missionState)
				local tile = MoveEvent()

				local lock = SpawnLocks.TheaterOfCheapThrills.Robercik
				function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
					if not player or not player:isPlayer() then
						return
					end

					if not player:HasExactMissionState(missionState) then
						return
					end

					if lock:IsSet() then
						return
					end

					lock:Set(Game.createMonster("Robercik", player:getPosition()))
				end

				tile:key(Storage.TheaterOfCheapThrills.RobercikSpawn)
				tile:register()
			end)
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission06.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Thanks, here's your reward. Robercik won't cause any more trouble.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission06] = MISSION_FINISHED,
						[Storage.TheaterOfCheapThrills.Mission07] = QuestState.TheaterOfCheapThrills.Mission07.AskRomekForMission,
					},
					rewards = { ExerciseWeaponBox(200) },
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission07)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission07.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "I'm currently raising funds for an artistic bohemia. Come back when I'm closing or donate a symbolic {amount}. How about 100 platinum coins?",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission07] = QuestState.TheaterOfCheapThrills.Mission07.DonateToRomek,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission07.DonateToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "I'm currently raising funds for an artistic bohemia. Come back when I'm closing or donate a symbolic {amount}. How about 100 platinum coins?",
				},
				[{ "mission", "misja", "kwote","amount" }] = {
					text = "Ytong is Ytong.",
					requiredItems = { { id = 3035, count = 10 } },
					textNoRequiredItems = "Then come back when I finish the fundraiser. The organization of the festival alone was worth at least 8 coronas extra.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission07] = QuestState.TheaterOfCheapThrills.Mission07.WaitForFestivalToEnd,
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission07.WaitForFestivalToEnd,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "After the festival, an Wolfy's old man came to me. Inspired by art, he decided to break free from family violence and handed me his {wifebeater}.",
				},
				[{ "mission", "misja", "zonobijke", "wifebeater" }] = {
					text = "I'll be closing soon. Come back for another mission later.",
					rewards = { QuestKeyItems.KingOfRatsHQ.Wifebeater },
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission08] = QuestState.TheaterOfCheapThrills.Mission08.AskRomekForMission,
						[Storage.TheaterOfCheapThrills.Mission07] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission08)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission08.AskRomekForMission, QuestFactory.Dialog("GM Romek", {
			[{ "mission", "misja" }] = {
				text = "I'm setting up a new minecraft server shortly. We're starting on Friday.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission08] = QuestState.TheaterOfCheapThrills.Mission08.TipVislavToStayAwayFromRomekServer,
				},
			},
		})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission08.TipVislavToStayAwayFromRomekServer,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "The start is getting closer. I hope this time we can last more than a week.",
				},
			}),
			QuestFactory.Dialog("Vislav Shivka", {
				[{
					"bone sword",
					"burst arrow",
					"crystal coin",
					"przekret",
					"korupcja",
					"corruption",
				}] = {
					text = "What!? That's corruption in a broad daylight! I'm not down for that. I'm going to investigate this case.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission08] = QuestState.TheaterOfCheapThrills.Mission08.ObserveRomekReaction,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission08.ObserveRomekReaction,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "That damn bald drunkard again. He's ruining my reputation.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission08] = MISSION_FINISHED,
						[Storage.TheaterOfCheapThrills.Mission09] = QuestState.TheaterOfCheapThrills.Mission09.AskRomekForMission,
					},
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission09)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission09.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "I have a simple job for you. Go to the southern Orc Fortess and read the map of their leader to find out where Brazil is located.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission09] = QuestState.TheaterOfCheapThrills.Mission09.FindBrazilMap,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission09.FindBrazilMap,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "These discussions will eventually drive me to the grave. The fortress is south of Mirkotown.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local updateStorages = {
					[Storage.TheaterOfCheapThrills.Mission09] = QuestState.TheaterOfCheapThrills.Mission09.PassMapToRomek,
				}

				local map = Action()

				function map.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if player:getStorageValueByKey(Storage.TheaterOfCheapThrills.Mission09) ~= QuestState.TheaterOfCheapThrills.Mission09.FindBrazilMap then
						return
					end

					player:NextState(updateStorages)
					return true
				end

				map:key(Storage.TheaterOfCheapThrills.BrazilMap)
				map:register()
			end)
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission09.PassMapToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Haha, yes! Finally, I know where that emigrant is. Pack your stuff in the car - we're going on a trip. You need to go to the Brazilian Ratland and defeat their king. Juerdo Titsgo is DDoSing my server, so players can't donate NFTs for an unjust but lucrative cause.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission09] = QuestState.TheaterOfCheapThrills.Mission09.TrackAndKillJuerdo,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission09.TrackAndKillJuerdo,
			QuestFactory.Dialog("GM Romek", {
				[{ GREET }] = {
					text = "Juerdo Titsgo is very short. He might hide somewhere when he sees you. His children, on the other hand, are huge mutants.",
				},
				[{ "mission" }] = {
					text = "Juerdo Titsgo is very short. He might hide somewhere when he sees you. His children, on the other hand, are huge mutants.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local tile = MoveEvent()

				local lock = SpawnLocks.TheaterOfCheapThrills.Juerdo
				function tile.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
					if not player or not player:isPlayer() then
						return
					end

					if not player:HasExactMissionState(missionState) then
						return
					end

					if lock:IsSet() then
						return
					end

					lock:Set(Game.createMonster("Juerdo Titsgo", player:getPosition()))
				end

				tile:key(Storage.TheaterOfCheapThrills.JuerdoTitsgoSpawn)
				tile:register()
			end)
	end)
	:MonsterEvent(function()
		local nextState = { [Storage.TheaterOfCheapThrills.Mission09] = QuestState.TheaterOfCheapThrills.Mission09.ReportToRomek }

		local juerdoDeath = CreatureEvent("JuerdoDeath")
		function juerdoDeath.onDeath(creature)
			if not creature or not creature:isMonster() then
				return true
			end
			SpawnLocks.TheaterOfCheapThrills.Juerdo:Reset()
			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValueByKey(Storage.TheaterOfCheapThrills.Mission09) ~= QuestState.TheaterOfCheapThrills.Mission09.TrackAndKillJuerdo then
					return true
				end

				player:NextState(nextState)
			end)
			return true
		end

		juerdoDeath:register()
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission09.ReportToRomek,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Thanks for your help. The DDoS attacks have stopped. Here's your reward.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission10] = QuestState.TheaterOfCheapThrills.Mission10.AskRomekForMission,
						[Storage.TheaterOfCheapThrills.Mission09] = MISSION_FINISHED,
					},
					rewards = { ExerciseWeaponBox(400) },
				},
			})
	end)
	:Mission(Storage.TheaterOfCheapThrills.Mission10)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission10.AskRomekForMission,
			QuestFactory.Dialog("GM Romek", {
				[{ "trial", "probe" }] = {
					text = NO_TEXT,
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission10] = QuestState.TheaterOfCheapThrills.Mission10.CommitRatocide,
					},
					spawnMonstersOnSuccess = {
						{ name = "Corym Charlatan", count = 2 },
						{ name = "Corym Skirmisher", count = 2 },
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
						},
					},
				},
				[{ "mission", "misja" }] = {
					text = "Here's the final stage of the initiation. If The chorus of januses is to judge our justice, then who judged them? Or is it just an illusion to cut us off from our human form and commit the ultimate embarrassment? I have to prove my loyalty to justice and commit genocide. You must help me commit genocide on my own faithful. It's fair and just. Ask about the {trial} if you're ready.",
				},
			})
	end)
	:State(function()
		return QuestState.TheaterOfCheapThrills.Mission10.CommitRatocide,
			QuestFactory.Dialog("GM Romek", {
				[{ "mission", "misja" }] = {
					text = "Here's your reward. Come back to me sometime. For now, I think I'll take a break.",
					nextState = {
						[Storage.TheaterOfCheapThrills.Mission10] = MISSION_FINISHED,
						[Storage.Finished.TheaterOfCheapThrills] = MISSION_FINISHED,
						[Storage.KingOfRatsHQ.Portals.SweatyCyclops] = ACCESS_GRANTED,
						[Storage.SafetyAndOccupationalHygiene.Mission01] = QuestState.SafetyAndOccupationalHygiene.Mission01.AskRomekForMission,
					},
					rewards = { ExerciseWeaponBox(400) },
					outfitRewards = QuestRewards.OutfitsAddons.ThreaterOfCheapThrills.Raccoon1
				},
			})
	end)
	:Register()
