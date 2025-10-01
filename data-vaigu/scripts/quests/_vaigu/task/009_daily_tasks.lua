local quest = Quest(LOCALIZERS.DailyTasks)

quest
	:Storage(function()
		Storage.DailyTasks = {
			DailyTaskInfo = {},
			DailyLimit = {},
			RandomTasksExpiry = {},
			Board = {},
			DailyLimitExpiry= {},
		}
	end)
	:Constant(function()
		DAILY_TASK_NOT_STARTED = -1

		DAILY_TASK_LIMIT = 3

		local dailyTasksData = {
			{
				name = "Undeads",
				items = {
					{ id = 9649, count = 5 },
					{ id = 10291, count = 8 },
					{ id = 10283, count = 3 },
				},
				requiredKills = 120,
				creatures = {
					"ghoul",
					"mummy",
					"skeleton",
					"skeleton warrior",
					"crypt shambler",
					"zombie",
				},
				exp = 8000,
				money = 3000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Apes",
				items = { { id = 11511, count = 5 }, { id = 11471, count = 2 } },
				requiredKills = 100,
				creatures = { "kongra", "merlkin", "sibang" },
				exp = 10000,
				money = 3500,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Orcs",
				items = { { id = 11480, count = 3 }, { id = 11453, count = 10 } },
				requiredKills = 130,
				creatures = {
					"orc",
					"orc berserker",
					"orc leader",
					"orc rider",
					"orc shaman",
					"orc spearman",
					"orc warlord",
					"orc warrior",
				},
				exp = 13000,
				money = 3000,
				tibiaCoins = 1,
				min = 0,
				max = 90,
			},
			{
				name = "Crocodiles",
				items = { { id = 10279, count = 20 } },
				requiredKills = 100,
				creatures = { "crocodile" },
				exp = 8000,
				money = 2500,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Cyclops",
				items = { { id = 9657, count = 12 } },
				requiredKills = 60,
				creatures = { "cyclops", "cyclops drone", "cyclops smith" },
				exp = 13000,
				money = 4000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Gargoyles",
				items = { { id = 10278, count = 6 } },
				requiredKills = 80,
				creatures = { "gargoyle" },
				exp = 15000,
				money = 4000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Trolls",
				items = { { id = 9689, count = 2 } },
				requiredKills = 70,
				creatures = { "troll", "troll champion", "swamp troll" },
				exp = 5000,
				money = 1500,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Minotaurs",
				items = { { id = 11472, count = 5 }, { id = 11451, count = 5 } },
				requiredKills = 150,
				creatures = {
					"minotaur",
					"minotaur mage",
					"minotaur archer",
					"minotaur guard",
				},
				exp = 15000,
				money = 5000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Rotworms",
				items = { { id = 9692, count = 5 }, { id = 10275, count = 3 } },
				requiredKills = 100,
				creatures = { "rotworm", "carrion worm" },
				exp = 5000,
				money = 2000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Stone Golems",
				items = { { id = 10315, count = 2 } },
				requiredKills = 50,
				creatures = { "stone golem" },
				exp = 10000,
				money = 3000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Tarantulas",
				items = { { id = 10281, count = 10 } },
				requiredKills = 100,
				creatures = { "tarantula" },
				exp = 10000,
				money = 5000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Tortoises",
				items = { { id = 5678, count = 3 } },
				requiredKills = 80,
				creatures = { "tortoise", "thornback tortoise" },
				exp = 10000,
				money = 4000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Scarabs",
				items = { { id = 9641, count = 4 } },
				requiredKills = 80,
				creatures = { "scarab" },
				exp = 11000,
				money = 3500,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Goblins",
				items = { { id = 11539, count = 1 } },
				requiredKills = 100,
				creatures = { "goblin", "goblin assassin", "goblin scavenger" },
				exp = 7000,
				money = 3500,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Amazons",
				items = { { id = 11443, count = 10 } },
				requiredKills = 100,
				creatures = { "amazon", "valkyrie" },
				exp = 15000,
				money = 2000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Elves",
				items = { { id = 9635, count = 5 } },
				requiredKills = 150,
				creatures = { "elf", "elf scout", "elf arcanist" },
				exp = 15000,
				money = 5000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Hunters",
				items = { { id = 11469, count = 4 } },
				requiredKills = 100,
				creatures = { "hunter", "poacher" },
				exp = 18000,
				money = 4000,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Dwarves",
				items = { { id = 3375, count = 1 } },
				requiredKills = 150,
				creatures = {
					"dwarf",
					"dwarf miner",
					"dwarf geomancer",
					"dwarf soldier",
					"dwarf guard",
				},
				exp = 14000,
				money = 3500,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			},
			{
				name = "Mutated Humans",
				items = { { id = 10308, count = 5 } },
				requiredKills = 100,
				creatures = { "mutated human" },
				exp = 15000,
				money = 3500,
				tibiaCoins = 1,
				min = 0,
				max = 69,
			}, -- 50+ lvl
			{
				name = "Green Dragons",
				items = { { id = 11457, count = 5 } },
				requiredKills = 50,
				creatures = { "dragon", "dragon hatchling" },
				exp = 36000,
				money = 5000,
				tibiaCoins = 2,
				min = 30,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Insects",
				items = {
					{ id = 14083, count = 8 },
					{ id = 14081, count = 6 },
					{ id = 14078, count = 5 },
				},
				requiredKills = 150,
				creatures = {
					"swarmer",
					"spitter",
					"crawler",
					"hive overseer",
					"insectoid worker",
					"kollos",
					"spidris",
					"spidris elite",
					"waspoid",
				},
				exp = 65000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Coryms",
				items = {
					{ id = 17809, count = 8 },
					{ id = 17819, count = 8 },
					{ id = 17817, count = 8 },
				},
				requiredKills = 120,
				creatures = { "corym charlatan", "corym skirmisher", "corym vanguard" },
				exp = 35000,
				money = 4000,
				tibiaCoins = 2,
				min = 30,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Ancient Scarabs",
				items = { { id = 9631, count = 5 } },
				requiredKills = 60,
				creatures = { "ancient scarab" },
				exp = 40000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Bonebeasts",
				items = { { id = 10277, count = 5 } },
				requiredKills = 60,
				creatures = { "bonebeast" },
				exp = 35000,
				money = 8000,
				tibiaCoins = 2,
				min = 30,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Crystal Spiders",
				items = { { id = 7449, count = 1 } },
				requiredKills = 60,
				creatures = { "crystal spider" },
				exp = 55000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Wailing Widows",
				items = { { id = 10411, count = 7 } },
				requiredKills = 70,
				creatures = { "wailing widow" },
				exp = 40000,
				money = 7000,
				tibiaCoins = 3,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Mutated Tigers",
				items = { { id = 10293, count = 10 } },
				requiredKills = 80,
				creatures = { "mutated tiger" },
				exp = 40000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Necromancers",
				items = { { id = 10320, count = 4 }, { id = 11475, count = 1 } },
				requiredKills = 80,
				creatures = { "necromancer", "blood priest", "blood hand", "priestess" },
				exp = 30000,
				money = 6000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Ogres",
				items = { { id = 22188, count = 3 }, { id = 22189, count = 2 } },
				requiredKills = 70,
				creatures = { "ogre shaman", "ogre brute", "ogre savage" },
				exp = 75000,
				money = 9000,
				tibiaCoins = 3,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Pirates",
				items = { { id = 10302, count = 12 } },
				requiredKills = 120,
				creatures = {
					"pirate skeleton",
					"pirate marauder",
					"pirate cutthroat",
					"pirate buccaneer",
					"pirate corsair",
				},
				exp = 50000,
				money = 8000,
				tibiaCoins = 2,
				min = 30,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Wyverns",
				items = { { id = 9644, count = 6 } },
				requiredKills = 60,
				creatures = { "wyvern" },
				exp = 34000,
				money = 6000,
				tibiaCoins = 2,
				min = 30,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Wyrms",
				items = { { id = 9665, count = 8 } },
				requiredKills = 50,
				creatures = { "wyrm", "elder wyrm" },
				exp = 50000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Earth Elementals",
				items = { { id = 10305, count = 8 } },
				requiredKills = 80,
				creatures = { "earth elemental", "massive earth elemental" },
				exp = 40000,
				money = 8000,
				tibiaCoins = 2,
				min = 30,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Roaring Lions",
				items = { { id = 9691, count = 10 } },
				requiredKills = 60,
				creatures = { "roaring lion" },
				exp = 20000,
				money = 2000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Heroes",
				items = { { id = 11510, count = 2 } },
				requiredKills = 50,
				creatures = {
					"hero",
					"vicious squire",
					"vile grandmaster",
					"renegade knight",
				},
				exp = 45000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Giant Spiders",
				items = { { id = 5879, count = 1 } },
				requiredKills = 50,
				creatures = { "giant spider" },
				exp = 55000,
				money = 6500,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Faes",
				items = { { id = 25693, count = 5 }, { id = 25696, count = 5 } },
				requiredKills = 90,
				creatures = {
					"boogy",
					"dark faun",
					"faun",
					"nymph",
					"pixie",
					"pooka",
					"swan maiden",
					"twisted pooka",
				},
				exp = 70000,
				money = 3000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Worker Golems",
				items = { { id = 9655, count = 1 } },
				requiredKills = 50,
				creatures = { "worker golem" },
				exp = 80000,
				money = 7000,
				tibiaCoins = 3,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Mutated Rats",
				items = { { id = 9668, count = 3 } },
				requiredKills = 60,
				creatures = { "mutated rat" },
				exp = 30000,
				money = 6000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			}, -- 120+ lvl
			{
				name = "Behemoths",
				items = { { id = 11447, count = 5 } },
				requiredKills = 50,
				creatures = { "behemoth" },
				exp = 150000,
				money = 10000,
				tibiaCoins = 3,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Brimstone Bugs",
				items = { { id = 11703, count = 8 }, { id = 11702, count = 5 } },
				requiredKills = 70,
				creatures = { "brimstone bug" },
				exp = 75000,
				money = 4000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Demons",
				items = { { id = 5954, count = 3 } },
				requiredKills = 30,
				creatures = { "demon" },
				exp = 200000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			}, -- can be completed once since 120 lvl
			{
				name = "Destroyers",
				items = { { id = 10298, count = 3 } },
				requiredKills = 50,
				creatures = { "destroyer" },
				exp = 150000,
				money = 15000,
				tibiaCoins = 3,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Drakens",
				items = { { id = 10404, count = 3 }, { id = 10397, count = 3 } },
				requiredKills = 70,
				creatures = {
					"draken abomination",
					"draken elite",
					"draken spellweaver",
					"draken warmaster",
				},
				exp = 180000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Frost Dragons",
				items = { { id = 9661, count = 1 } },
				requiredKills = 50,
				creatures = { "frost dragon", "frost dragon hatchling", "ice dragon" },
				exp = 110000,
				money = 10000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Dragon Lords",
				items = { { id = 5948, count = 2 } },
				requiredKills = 50,
				creatures = { "dragon lord", "dragon lord hatchling" },
				exp = 110000,
				money = 10000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Hellhounds",
				items = { { id = 16131, count = 1 }, { id = 9636, count = 1 } },
				requiredKills = 20,
				creatures = { "hellhound" },
				exp = 250000,
				money = 10000,
				tibiaCoins = 3,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Hellspawns",
				items = { { id = 10304, count = 5 } },
				requiredKills = 50,
				creatures = { "hellspawn" },
				exp = 150000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "High Lizards",
				items = { { id = 10416, count = 1 }, { id = 10444, count = 1 } },
				requiredKills = 60,
				creatures = {
					"lizard legionnaire",
					"lizard dragon priest",
					"lizard high guard",
					"lizard zaogun",
					"lizard chosen",
				},
				exp = 100000,
				money = 10000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Killer Caimans",
				items = { { id = 10279, count = 12 } },
				requiredKills = 60,
				creatures = { "killer caiman" },
				exp = 60000,
				money = 6000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Medusas",
				items = { { id = 10309, count = 3 } },
				requiredKills = 40,
				creatures = { "medusa" },
				exp = 160000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Nightmares",
				items = { { id = 10312, count = 3 } },
				requiredKills = 50,
				creatures = { "nightmare", "nightmare scion" },
				exp = 160000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Quaras",
				items = {
					{ id = 11490, count = 2 },
					{ id = 11489, count = 2 },
					{ id = 11487, count = 2 },
				},
				requiredKills = 60,
				creatures = {
					"quara constrictor",
					"quara hydromancer",
					"quara hydromancer scout",
					"quara mantassin",
					"quara pincher",
					"quara pincher scout",
					"quara predator",
					"quara predator scout",
				},
				exp = 120000,
				money = 9000,
				tibiaCoins = 3,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Sea Serpents",
				items = { { id = 9666, count = 5 } },
				requiredKills = 50,
				creatures = { "sea serpent", "young sea serpent" },
				exp = 100000,
				money = 5000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Hydras",
				items = { { id = 10282, count = 5 } },
				requiredKills = 50,
				creatures = { "hydra" },
				exp = 150000,
				money = 10000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Undead Dragons",
				items = { { id = 10316, count = 3 } },
				requiredKills = 30,
				creatures = { "undead dragon" },
				exp = 333000,
				money = 10000,
				tibiaCoins = 3,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Ghastly Dragons",
				items = { { id = 10449, count = 3 } },
				requiredKills = 30,
				creatures = { "ghastly dragon" },
				exp = 250000,
				money = 10000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Asuras",
				items = { { id = 21974, count = 10 }, { id = 21975, count = 10 } },
				requiredKills = 60,
				creatures = {
					"dawnfire asura",
					"midnight asura",
					"frost flower asura",
					"true dawnfire asura",
					"true midnight asura",
					"true frost flower asura",
				},
				exp = 130000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Frazzles",
				items = { { id = 20198, count = 8 }, { id = 20199, count = 7 } },
				requiredKills = 50,
				creatures = { "frazzlemaw", "guzzlemaw" },
				exp = 180000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Lycanthropes",
				items = {
					{ id = 22051, count = 4 },
					{ id = 22052, count = 4 },
					{ id = 22054, count = 4 },
				},
				requiredKills = 70,
				creatures = {
					"werewolf",
					"werebadger",
					"werebear",
					"wereboar",
					"werefox",
				},
				exp = 140000,
				money = 10000,
				tibiaCoins = 2,
				min = 60,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Glooth Bandits",
				items = { { id = 21816, count = 3 } },
				requiredKills = 60,
				creatures = { "glooth bandit", "glooth brigand" },
				exp = 150000,
				money = 10000,
				tibiaCoins = 2,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Shaburak Demons",
				items = { { id = 3030, count = 5 } },
				requiredKills = 40,
				creatures = { "shaburak demon", "shaburak lord", "shaburak prince" },
				exp = 50000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Askarak Demons",
				items = { { id = 3032, count = 5 } },
				requiredKills = 40,
				creatures = { "askarak demon", "askarak lord", "askarak prince" },
				exp = 50000,
				money = 5000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Putrid Mummies",
				items = { { id = 25697, count = 4 } },
				requiredKills = 40,
				creatures = { "putrid Mummy" },
				exp = 40000,
				money = 3000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Banshees",
				items = { { id = 11446, count = 1 } },
				requiredKills = 30,
				creatures = { "banshee" },
				exp = 30000,
				money = 3000,
				tibiaCoins = 2,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Lost Dwarves",
				items = { { id = 17855, count = 2 }, { id = 12600, count = 4 } },
				requiredKills = 60,
				creatures = { "lost basher", "lost husher", "lost exile", "lost thrower" },
				exp = 80000,
				money = 8000,
				tibiaCoins = 3,
				min = 50,
				max = NO_MAX_LEVEL_LIMIT,
			},
			{
				name = "Weak Cults",
				items = { { id = 9638, count = 1 }, { id = 9639, count = 2 } },
				requiredKills = 50,
				creatures = { "novice of the cult", "adept of the cult", "acolyte of the cult", "enlightened of the cult" },
				exp = 40000,
				money = 3000,
				tibiaCoins = 2,
				min = 30,
				max = 120,
			},
			{
				name = "Ice Witches",
				items = { { id = 7441, count = 3 } },
				requiredKills = 50,
				creatures = { "ice witch" },
				exp = 40000,
				money = 3000,
				tibiaCoins = 2,
				min = 30,
				max = 120,
			},
			{
				name = "Other Dimension",
				items = { { id = 23510, count = 2 }, { id = 23518, count = 2 } },
				requiredKills = 30,
				creatures = { "sparkion", "breach brood", "reality reaver", "dread intruder" },
				exp = 80000,
				money = 8000,
				tibiaCoins = 3,
				min = 120,
				max = NO_MAX_LEVEL_LIMIT,
			},
		}
		function GetAllDailyTasks()
			return dailyTasksData
		end

		local function getDailyTasksLevelBrackets()
			local result = {}
			local mem = {}
			for _, dailyTask in pairs(GetAllDailyTasks()) do
				if not mem[dailyTask.min] then
					mem[dailyTask.min] = dailyTask.min
					table.insert(result, dailyTask.min)
				end
			end
			return result
		end
		DAILY_TASKS_LEVEL_BRACKETS_COUNT = #getDailyTasksLevelBrackets()
	end)
	:Questlog(function(localizer)
		DailyTaskQuestlog = {
			name = "Daily task",
			localizer = localizer,
			missions = {
				{
					name = "Daily tasks information",
					storage = Storage.DailyTasks.DailyTaskInfo,
					description = "DAILY_TASKS_HELP_WINDOW_INFO",
				},
			},
		}
		table.insert(Questlog, DailyTaskQuestlog)
	end)
	:Script(function() -- auxillary data generation
		local creatureNameToDailyTask = {}
		local storageToDailyTask = {}

		function GetDailyTaskByStorage(storage)
			return storageToDailyTask[storage]
		end
		function GetDailyTaskByCreatureName(creatureName)
			return creatureNameToDailyTask[creatureName]
		end

		local function setAuxillaryMaps(dailyTask)
			storageToDailyTask[dailyTask.storage] = dailyTask
			for _, creatureName in pairs(dailyTask.creatures) do
				creatureNameToDailyTask[creatureName] = dailyTask
			end
		end

		local taskTaskNameScope = Scope("DailyTask", "TaskName")
		local taskCurrentKillsScope = Scope("DailyTask", "CurrentKills")
		local function registerDailyTasksInQuestsTable()
			for _, dailyTask in pairs(GetAllDailyTasks()) do
				local storage = taskTaskNameScope:Get(dailyTask.name)
				local currentKills = taskCurrentKillsScope:Get(dailyTask.name)

				dailyTask.storage = storage
				dailyTask.currentKills = currentKills

				local dailyTaskMission = {
					name = "DAILY_TASK_MISSION_NAME",
					dailyTask = dailyTask,
					storage = storage,
					minValue = 0,
					description = "DAILY_TASK_MISSION_DESCRIPTION",
				}

				setAuxillaryMaps(dailyTask)
				table.insert(DailyTaskQuestlog.missions, dailyTaskMission)
			end
		end
		registerDailyTasksInQuestsTable()
	end)
	:Script(function() -- daily task windows
		local function playerCanTakeAnyDailyTask(player)
			for i = 1, DAILY_TASKS_LEVEL_BRACKETS_COUNT do
				local dailyTask = GetDailyTaskByIndex(i)
				if player:CanTakeDailyTask(dailyTask) then
					return true
				end
			end
			return false
		end

		local function selectDailyTaskFromList(player, button, choice)
			local dailyTask = choice.dailyTask
			local storage = dailyTask.storage
			player:AddOngoingDailyTask(dailyTask)
			player:AddCustomItem({
				id = 2815,
				key = storage,
				text = "DAILY_TASK_PAMPHLET_DESCRIPTION",
				addToStore = false,
			})
			local dailyTaskActiveMessage = player:Localizer(LOCALIZERS.DailyTasks):Get("YOU_RECEIVED_DAILY_TASK")
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, dailyTaskActiveMessage)
		end

		local function showDailyTaskHelpWindow(player)
			local translatedMessage = player:Localizer(LOCALIZERS.Tasks):Get("DAILY_TASKS_HELP_WINDOW_INFO")
			player:showTextDialog(2819, translatedMessage)
		end

		local function openDailyTaskWindow(context)
			local player = context.player

			local localizerTasks = player:Localizer(LOCALIZERS.Tasks)
			local localizerDailyTasks = player:Localizer(LOCALIZERS.DailyTasks)
			local message = localizerTasks:Get("Select task you're interested in: ")
			local title = localizerDailyTasks:Get("Daily tasks")
			local modalWindow = ModalWindow({ title = title, message = message })

			for i = 1, DAILY_TASKS_LEVEL_BRACKETS_COUNT do
				local dailyTask = GetDailyTaskByIndex(i)
				if player:CanTakeDailyTask(dailyTask) then
					local choiceText = localizerDailyTasks:Context({ dailyTask = dailyTask }):Get("DAILY_TASK_FOR_X")
					local choice = modalWindow:addChoice(choiceText)
					choice.dailyTask = dailyTask
				end
			end

			local select = modalWindow:addButton(localizerTasks:Get("Select"), selectDailyTaskFromList)
			local cancel = modalWindow:addButton(localizerTasks:Get("Cancel"))

			modalWindow:addButton(localizerTasks:Get("Help"), showDailyTaskHelpWindow)
			modalWindow:setDefaultEnterButton(select.id - 1)
			modalWindow:setDefaultEscapeButton(cancel.id - 1)

			modalWindow:sendToPlayer(player)
		end

		local function onDailyTaskboardUse(player)
			player:setStorageValueByKey(Storage.DailyTasks.DailyTaskInfo, MISSION_FINISHED)
			if not playerCanTakeAnyDailyTask(player) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(LOCALIZERS.DailyTasks):Get("YOU_TAKEN_ALL_AVAILABLE_DAILY_TASKS"))
				return false
			end

			openDailyTaskWindow({ player = player })
			return true
		end

		local dailyBoard = Action()
		function dailyBoard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			return onDailyTaskboardUse(player)
		end
		dailyBoard:key(Storage.DailyTasks.Board)
		dailyBoard:register()

		local dailyBoardLook = Look()
		function dailyBoardLook.onLook(player, item)
			onDailyTaskboardUse(player)
			return DONT_SHOW_ONLOOK
		end
		dailyBoardLook:key(Storage.DailyTasks.Board)
		dailyBoardLook:register()

		local function onPamphlet(player, item)
			local key = item:getKey()
			local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
			local translatedText = player:Localizer(LOCALIZERS.DailyTasks):Context({ key = key }):Get(text)
			SimpleTextDisplay(player, translatedText)
		end

		local dailyPamphletUse = Action()
		function dailyPamphletUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			onPamphlet(player, item)
			item:remove()
			return true
		end

		local dailyPamphletLook = Look()
		function dailyPamphletLook.onLook(player, item)
			onPamphlet(player, item)
			item:remove()
			return DONT_SHOW_ONLOOK
		end

		for _, dailyTask in pairs(GetAllDailyTasks()) do
			local key = dailyTask.storage
			dailyPamphletUse:key(key)
			dailyPamphletLook:key(key)
		end
		dailyPamphletUse:register()
		dailyPamphletLook:register()
	end)
	:Script(function() -- daily task counter
		local function playerStartedThisDailyTask(player, dailyTask)
			local dailyTaskProgress = player:getStorageValueByKey(dailyTask.storage)
			if dailyTaskProgress ~= DAILY_TASK_NOT_STARTED then
				return true
			end
			return false
		end

		local function isDailytaskReadyToTurnIn(player, dailyTask)
			local state = player:getStorageValueByKey(dailyTask.storage)
			return state == REPORT_TASK_TO_NPC
		end

		function Player:CanAddDailyTaskKill(dailyTask)
			if not playerStartedThisDailyTask(self, dailyTask) then
				return false
			end
			if isDailytaskReadyToTurnIn(self, dailyTask) then
				return false
			end
			return true
		end

		---@param dailyTask table
		---@return boolean
		function Player:AddDailyTaskKill(dailyTask)
			self:IncrementStorage(dailyTask.currentKills)
			self:RefreshStorage(dailyTask.storage)

			local currentKillsString = self:Localizer(LOCALIZERS.DailyTasks):Context({ dailyTask = dailyTask }):Get("DAILY_TASK_CURRENT_KILLS")
			self:sendTextMessage(MESSAGE_EXPERIENCE, currentKillsString)

			if self:getStorageValueByKey(dailyTask.currentKills) >= dailyTask.requiredKills then
				self:setStorageValueByKey(dailyTask.storage, REPORT_TASK_TO_NPC)
				self:setStorageValueByKey(dailyTask.currentKills, dailyTask.requiredKills)

				local translatedMessageWhenFinished = self:Localizer(LOCALIZERS.DailyTasks):Context({ dailyTask = dailyTask }):Get("DAILY_TASK_READY_TO_TURN_IN")
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessageWhenFinished)
			end
			return true
		end

		function Player:TryAddKillToDailyTask(dailyTask)
			if self:CanAddDailyTaskKill(dailyTask) then
				self:AddDailyTaskKill(dailyTask)
				return true
			end
			return false
		end

		local grantCreditToKillers = 2
		local dailyTaskMonsterDeath = CreatureEvent("DailyTaskMonsterDeath")
		function dailyTaskMonsterDeath.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
			local targetMonster = killedCreature:getMonster()
			if not targetMonster or targetMonster:getMaster() then
				return true
			end

			local dailyTask = GetDailyTaskByCreatureName(killedCreature:getName():lower())
			if not dailyTask then
				return
			end

			local damageMap = killedCreature:getDamageMap()
			local topKillers = GetTopKillers(damageMap, lastHitKiller)
			local playersGranted = 0
			for _, player in pairs(topKillers) do
				if playersGranted >= grantCreditToKillers then
					return
				end
				if player:TryAddKillToDailyTask(dailyTask) then
					playersGranted = playersGranted + 1
				end
			end
			return true
		end
		dailyTaskMonsterDeath:register()

		local dailyTaskMonsterDeathStartup = GlobalEvent("DailyTaskMonsterDeathStartup")
		function dailyTaskMonsterDeathStartup.onStartup()
			local monsterNames = {}
			for _, task in pairs(GetAllDailyTasks()) do
				for _, monsterName in pairs(task.creatures) do
					monsterNames[monsterName:lower()] = true
				end
			end

			for monsterName in pairs(monsterNames) do
				local mType = MonsterType(monsterName)
				if not mType then
					logger.error("[TaskMonsterDeathStartup] monster with name {} is not a valid MonsterType", monsterName)
				else
					mType:registerEvent("DailyTaskMonsterDeath")
				end
			end
		end
		dailyTaskMonsterDeathStartup:register()
	end)
	:Script(function() -- generate daily tasks for today
		local function getLevelBracketDailyTasks()
			local result = {}
			for _, dailyTask in pairs(GetAllDailyTasks()) do
				result[dailyTask.min] = result[dailyTask.min] or {}
				table.insert(result[dailyTask.min], dailyTask)
			end
			return result
		end

		local function generateRandomDailyTasks()
			local dailyTasksByLevel = getLevelBracketDailyTasks()
			local randomDailyTasks = {}

			for requiredLevel, dailyTasksForThisLevel in pairs(dailyTasksByLevel) do
				local randomIndex = math.random(1, #dailyTasksForThisLevel)
				local randomTaskStorage = dailyTasksForThisLevel[randomIndex]
				table.insert(randomDailyTasks, randomTaskStorage)
			end
			return randomDailyTasks
		end

		local todayDailyTasks = {}
		local function getDailyTaskDatabase(slotIndex)
			return Game.getStorageValueByKey("daily-task-slot-" .. tostring(slotIndex))
		end

		local function loadTodayDailyTasksDatabase()
			for slotIndex = 1, DAILY_TASKS_LEVEL_BRACKETS_COUNT do
				local dailyTask = getDailyTaskDatabase(slotIndex)
				todayDailyTasks[slotIndex] = dailyTask
			end
		end

		function GetDailyTaskByIndex(index)
			return todayDailyTasks[index]
		end

		local function logDailyTasks()
			local logString = "Daily tasks: "
			for index, dailyTask in pairs(todayDailyTasks) do
				logString = logString .. T(":name:, ", { name = dailyTask.name })
			end

			logger.info(logString)
		end

		local function wereDailyTasksSetToday(currentTimestamp)
			local LockoutExpiry = Game.getStorageValueByKey(Storage.DailyTasks.RandomTasksExpiry)
			if not LockoutExpiry then
				return false
			end
			if currentTimestamp <= LockoutExpiry then
				return true
			end
			return false
		end

		local function calculateTodayDate()
			local currentDate = os.date("*t")
			local year = currentDate.year
			local month = string.format("%02d", tonumber(currentDate.month))
			local day = string.format("%02d", tonumber(currentDate.day))
			local todayDate = tonumber(year .. month .. day)
			return todayDate
		end

		local function setDailyTaskDatabase(slotIndex, dailyTask)
			Game.setStorageValueByKey("daily-task-slot-" .. tostring(slotIndex), dailyTask)
		end
		local function setTodayDailyTasksDatabase(currentTimestamp)
			math.randomseed(os.time())
			local newDailyTasks = generateRandomDailyTasks()
			for i, task in ipairs(newDailyTasks) do
				setDailyTaskDatabase(i, task)
			end
		end
		local initializeRandomDailyTasks = GlobalEvent("InitializeRandomDailyTasks")
		function initializeRandomDailyTasks.onStartup()
			local todayDate = calculateTodayDate()
			if Game.isLockoutExpired(Storage.DailyTasks.RandomTasksExpiry) then
				setTodayDailyTasksDatabase(todayDate)
				Game.setLockoutExpiry(Storage.DailyTasks.RandomTasksExpiry, LOCKOUT_EXPIRY_TIME.DAILY)
			end

			loadTodayDailyTasksDatabase()

			logDailyTasks()
		end
		initializeRandomDailyTasks:register()
	end)
	:Script(function() -- task window and completion at npc
		function Player:TryResetDailyTaskCounter()
			if self:isLockoutExpired(Storage.DailyTasks.DailyLimitExpiry) then
				self:setLockoutExpiry(Storage.DailyTasks.DailyLimitExpiry, LOCKOUT_EXPIRY_TIME.DAILY)
				self:setStorageValueByKey(Storage.DailyTasks.DailyLimit, 0)
			end
		end

		local function resetDailyTaskSuccesfulCompletion(player, task)
			player:setStorageValueByKey(task.currentKills, MISSION_NOT_STARTED)
			player:setStorageValueByKey(task.storage, DAILY_TASK_NOT_STARTED)
		end

		local function resetDailyTask(player, task)
			player:setStorageValueByKey(task.currentKills, MISSION_NOT_STARTED)
			player:setStorageValueByKey(task.storage, DAILY_TASK_NOT_STARTED)
		end

		local function hasAnyOngoingDailyTask(context)
			local player = context.player
			for _, task in pairs(GetAllDailyTasks()) do
				if player:getStorageValueByKey(task.storage) ~= DAILY_TASK_NOT_STARTED then
					return true
				end
			end
			return false
		end

		function Player:AddOngoingDailyTask(dailyTask)
			self:setStorageValueByKey(dailyTask.currentKills, 0)
			self:setStorageValueByKey(dailyTask.storage, MISSION_STARTED)
		end

		local function cancelDailyTaskFromList(player, button, choice)
			if choice.dailyTask then
				resetDailyTask(player, choice.dailyTask)
			end
		end

		function Player:CanTakeDailyTask(dailyTask)
			local minLevel = dailyTask.min
			local maxLevel = dailyTask.max
			local playerLevel = self:getLevel()
			if playerLevel < minLevel then
				return false
			end
			if playerLevel > maxLevel then
				return false
			end

			local storage = dailyTask.storage
			local dailyTaskProgress = self:getStorageValueByKey(storage)
			if dailyTaskProgress ~= DAILY_TASK_NOT_STARTED then
				return false
			end

			return true
		end

		local function openDailyTaskCancelWindow(context)
			local player = context.player

			local localizer = player:Localizer(LOCALIZERS.Tasks)
			local message = localizer:Get("Select task you want to cancel: ")
			local title = localizer:Get("Ongoing tasks list:")
			local modalWindow = ModalWindow({ title = title, message = message })
			for _, dailyTask in pairs(GetAllDailyTasks()) do
				if player:getStorageValueByKey(dailyTask.storage) ~= DAILY_TASK_NOT_STARTED then
					local choice = modalWindow:addChoice(T(":name:", { name = dailyTask.name }))
					choice.dailyTask = dailyTask
				end
			end

			local select = modalWindow:addButton(localizer:Get("Select"), cancelDailyTaskFromList)
			local exit = modalWindow:addButton(localizer:Get("Exit"))
			modalWindow:setDefaultEnterButton(select.id - 1)
			modalWindow:setDefaultEscapeButton(exit.id - 1)

			modalWindow:sendToPlayer(player)
		end

		local function grantDailyTaskRewards(context, task)
			local player = context.player

			if not player:TryAddItems(task.rewards or {}) then
				return false
			end
			local money = task.money
			local coins = task.tibiaCoins
			local exp = task.exp

			player:addMoney(money)
			player:AddAllCoins(coins)
			player:IncrementStorage(Storage.Tasks.TaskPoints, coins)
			player:addExperience(exp, true)
			return true
		end

		function Player:TryAddDailyTaskRewards(context, dailyTask)
			local storage = dailyTask.storage
			local dailyTaskState = self:getStorageValueByKey(storage)
			if dailyTaskState == DAILY_TASK_NOT_STARTED then
				return ""
			end

			local localizer = self:Localizer(LOCALIZERS.Tasks):Context({
				dailyTask = dailyTask,
			})

			if self:getStorageValueByKey(Storage.DailyTasks.DailyLimit) >= DAILY_TASK_LIMIT then
				return localizer:Get("YOU_EXCEEDED_DAILY_TASK_LIMIT")
			end

			local requiredKills = dailyTask.requiredKills
			local currentKills = self:getStorageValueByKey(dailyTask.currentKills)
			if currentKills < requiredKills then
				return localizer:Get("YOU_DONT_HAVE_REQUIRED_DAILY_TASK_KILLS")
			end

			local requiredItems = dailyTask.items
			if not self:HasItems(requiredItems) then
				return localizer:Get("YOU_DONT_HAVE_REQUIRED_DAILY_TASK_ITEMS")
			end

			self:RemoveItems(requiredItems)
			grantDailyTaskRewards(context, dailyTask)
			resetDailyTaskSuccesfulCompletion(self, dailyTask)
			resetDailyTask(self, dailyTask)
			self:IncrementStorage(Storage.DailyTasks.DailyLimit, 1)
			return localizer:Get("DAILY_TASK_REWARDS_DIALOG")
		end

		local function grantRewardsForAllDailyTasks(context)
			local player = context.player
			local translatedMessage = ""
			for _, dailyTask in pairs(GetAllDailyTasks()) do
				local taskMessage = player:TryAddDailyTaskRewards(context, dailyTask)
				if taskMessage ~= "" then
					translatedMessage = translatedMessage .. taskMessage .. "\n"
				end
			end
			if translatedMessage == "" then
				translatedMessage = player:Localizer(LOCALIZERS.DailyTasks):Get("YOU_DONT_HAVE_ONGOING_DAILY_TASK")
			end
			context.npcHandler:say(translatedMessage, context.npc, context.player)
		end

		JOB_UNIVERSAL_DIALOGS[JOB_DAILYTASK] = {
			[{ "anuluj", "zrezygnowac", "cancel" }] = {
				specialActionsOnSuccess = {
					{
						action = openDailyTaskCancelWindow,
					},
				},
				specialRequirements = {
					{
						requirement = hasAnyOngoingDailyTask,
						requiredOutcome = true,
						textFailedRequirement = "You don't have any active daily tasks. You can sign up for daily task on the daily task board. Please report me if you finish one of them.",
					},
				},
			},
			[{ "ogloszenie", "task", "nagroda", "reward" }] = {
				specialActionsOnSuccess = {
					{
						action = grantRewardsForAllDailyTasks,
					},
				},
			},
		}
	end)
	:Register()
