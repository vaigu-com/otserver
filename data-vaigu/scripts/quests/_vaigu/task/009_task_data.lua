NO_MAX_LEVEL_LIMIT = 5000

local taskData = {
	{
		name = "Apes",
		requiredKills = 200,
		creatures = { "kongra", "sibang", "merlkin" },
		exp = 31000,
		money = 5000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "Golira",
	},
	{
		name = "Barbarians",
		requiredKills = 200,
		creatures = { "barbarian headsplitter", "barbarian skullhunter", "barbarian brutetamer", "barbarian bloodwalker" },
		exp = 25000,
		money = 3000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "Barbaria",
	},
	{
		name = "Dwarves",
		requiredKills = 300,
		creatures = { "dwarf", "dwarf soldier", "dwarf guard", "dwarf geomancer" },
		exp = 45000,
		money = 5000,
		tibiaCoins = 3,
		min = 0,
		max = 45,
		bossName = "Foreman Kneebiter",
	},
	{
		name = "Falcons",
		requiredKills = 200,
		creatures = { "falcon knight", "falcon paladin" },
		exp = 1000000,
		money = 100000,
		tibiaCoins = 8,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Falconius Grandus",
	},
	{
		name = "Metal Gargoyles",
		requiredKills = 200,
		creatures = { "metal gargoyle" },
		exp = 400000,
		money = 30000,
		tibiaCoins = 3,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Titan Gargoyle",
	},
	{
		name = "War Golems",
		requiredKills = 200,
		creatures = { "war Golem" },
		exp = 750000,
		money = 40000,
		tibiaCoins = 8,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Golem Deez",
	},
	{
		name = "Furies",
		requiredKills = 200,
		creatures = { "fury" },
		exp = 700000,
		money = 10000,
		tibiaCoins = 5,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Irahsae",
	},
	{
		name = "Infernalists",
		requiredKills = 200,
		creatures = { "infernalist" },
		exp = 400000,
		money = 20000,
		tibiaCoins = 6,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Zarabustor",
	},
	{
		name = "Lost Dwarves",
		requiredKills = 250,
		creatures = { "lost basher", "lost exile", "lost husher", "lost thrower" },
		exp = 333000,
		money = 10000,
		tibiaCoins = 4,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "LOST EXTHROHUSHER",
	},
	{
		name = "Vampires",
		requiredKills = 400,
		creatures = { "vampire", "vampire viscount", "vampire bride",  },
		exp = 222000,
		money = 5000,
		tibiaCoins = 3,
		min = 30,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Boreth",
	},
	{
		name = "Carniphilas",
		requiredKills = 200,
		creatures = { "carniphila" },
		exp = 40000,
		money = 8000,
		tibiaCoins = 3,
		min = 0,
		max = 45,
		bossName = "Deathbine",
	},
	{
		name = "Crocodiles",
		requiredKills = 100,
		creatures = { "crocodile" },
		exp = 10000,
		money = 1000,
		tibiaCoins = 1,
		min = 0,
		max = 45,
		bossName = "The Snapper",
	},
	{
		name = "Cyclops",
		requiredKills = 300,
		creatures = { "cyclops", "cyclops drone", "cyclops smith" },
		exp = 60000,
		money = 3000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "The Old Whopper",
	},
	{
		name = "Dragons",
		requiredKills = 300,
		creatures = { "dragon hatchling", "dragon" },
		exp = 123000,
		money = 7500,
		tibiaCoins = 3,
		min = 30,
		max = 121,
		bossName = "Grand Mother Foulscale",
	},
	{
		name = "Gargoyles",
		requiredKills = 200,
		creatures = { "gargoyle" },
		exp = 28000,
		money = 3000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "Stoner",
	},
	{
		name = "Minotaurs",
		requiredKills = 1000,
		creatures = {
			"minotaur",
			"minotaur mage",
			"minotaur archer",
			"minotaur guard",
		},
		exp = 200000,
		money = 10000,
		tibiaCoins = 10,
		min = 0,
		max = 45,
		bossName = "The Horned Fox",
	},
	{
		name = "Mutated Humans",
		requiredKills = 200,
		creatures = { "mutated human" },
		exp = 40750,
		money = 2000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "Mutanted",
	},
	{
		name = "Orcs",
		requiredKills = 300,
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
		exp = 52000,
		money = 5000,
		tibiaCoins = 3,
		min = 0,
		max = 121,
		bossName = "Bibby Bloodbath",
	},
	{
		name = "Rotworms",
		requiredKills = 200,
		creatures = { "rotworm", "carrion worm" },
		exp = 8000,
		money = 1000,
		tibiaCoins = 1,
		min = 0,
		max = 45,
		bossName = "White Pale",
	},
	{
		name = "Stone Golems",
		requiredKills = 250,
		creatures = { "stone golem" },
		exp = 60000,
		money = 4000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "Grorlam",
	},
	{
		name = "Tarantulas",
		requiredKills = 250,
		creatures = { "tarantula" },
		exp = 25000,
		money = 2500,
		tibiaCoins = 1,
		min = 0,
		max = 45,
		bossName = "Hide",
	},
	{
		name = "Terramites",
		requiredKills = 200,
		creatures = { "terramite" },
		exp = 72000,
		money = 5000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "Thermite",
	},
	{
		name = "Tortoises",
		requiredKills = 250,
		creatures = { "tortoise", "thornback tortoise" },
		exp = 54000,
		money = 4000,
		tibiaCoins = 1,
		min = 0,
		max = 45,
		bossName = "Thorner",
	},
	{
		name = "Weak Undeads",
		requiredKills = 300,
		creatures = {
			"ghoul",
			"mummy",
			"skeleton",
			"skeleton warrior",
			"crypt shambler",
			"zombie",
		},
		exp = 35000,
		money = 4000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "Ripper",
	},
	{
		name = "Ancient Scarabs",
		requiredKills = 300,
		creatures = { "ancient scarab" },
		exp = 162000,
		money = 7000,
		tibiaCoins = 2,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Fleshcrawler",
	},
	{
		name = "Bonebeasts",
		requiredKills = 250,
		creatures = { "bonebeast" },
		exp = 130500,
		money = 7000,
		tibiaCoins = 2,
		min = 30,
		max = 121,
		bossName = "Ribstride",
	},
	{
		name = "Crystal Spiders",
		requiredKills = 250,
		creatures = { "crystal spider" },
		exp = 185000,
		money = 7000,
		tibiaCoins = 2,
		min = 46,
		max = 121,
		bossName = "The Bloodweb",
	},
	{
		name = "Giant Spiders",
		requiredKills = 400,
		creatures = { "giant spider" },
		exp = 337500,
		money = 10000,
		tibiaCoins = 3,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "The Old Widow",
	},
	{
		name = "Ice Golems",
		requiredKills = 250,
		creatures = { "ice golem" },
		exp = 88500,
		money = 4000,
		tibiaCoins = 2,
		min = 46,
		max = 121,
		bossName = "Shardhead",
	},
	{
		name = "Lancer Beetles",
		requiredKills = 200,
		creatures = { "lancer beetle" },
		exp = 82500,
		money = 8000,
		tibiaCoins = 3,
		min = 46,
		max = 121,
		bossName = "Deadly Beetle",
	},
	{
		name = "Mutated Bats",
		requiredKills = 350,
		creatures = { "mutated bat" },
		exp = 184500,
		money = 10000,
		tibiaCoins = 3,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Bruise Payne",
	},
	{
		name = "Mutated Rats",
		requiredKills = 300,
		creatures = { "mutated rat" },
		exp = 90000,
		money = 5000,
		tibiaCoins = 3,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Esmeralda",
	},
	{
		name = "Mutated Tigers",
		requiredKills = 400,
		creatures = { "mutated tiger" },
		exp = 262500,
		money = 4000,
		tibiaCoins = 3,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Tigre",
	},
	{
		name = "Necromancers",
		requiredKills = 1500,
		creatures = { "necromancer", "blood priest", "blood hand", "priestess" },
		exp = 543750,
		money = 10000,
		tibiaCoins = 6,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Necropharus",
	},
	{
		name = "Ogres",
		requiredKills = 300,
		creatures = { "ogre brute", "ogre savage", "ogre shaman" },
		exp = 361360,
		money = 10000,
		tibiaCoins = 3,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Brutus",
	},
	{
		name = "Pirates",
		requiredKills = 400,
		creatures = {
			"pirate skeleton",
			"pirate marauder",
			"pirate cutthroat",
			"pirate buccaneer",
			"pirate corsair",
		},
		exp = 95000,
		money = 5000,
		tibiaCoins = 3,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = { "Brutus Bloodbeard", "Deadeye Devious", "Lethal Lissy", "Ron the Ripper" },
	},
	{
		name = "Stampors",
		requiredKills = 200,
		creatures = { "stampor" },
		exp = 195000,
		money = 15000,
		tibiaCoins = 3,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Tromphonyte",
	},
	{
		name = "Wailing Widows",
		requiredKills = 200,
		creatures = { "wailing widow" },
		exp = 157500,
		money = 8000,
		tibiaCoins = 3,
		min = 46,
		max = 121,
		bossName = "Fiery Widow",
	},
	{
		name = "Wyverns",
		requiredKills = 250,
		creatures = { "wyvern" },
		exp = 115875,
		money = 4000,
		tibiaCoins = 2,
		min = 30,
		max = 121,
		bossName = "Reptilia",
	},
	{
		name = "Behemoths",
		requiredKills = 250,
		creatures = { "behemoth" },
		exp = 755500,
		money = 20000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Stonecracker",
	},
	{
		name = "Brimstone Bugs",
		requiredKills = 300,
		creatures = { "brimstone bug" },
		exp = 270000,
		money = 10000,
		tibiaCoins = 3,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Sulphur Scuttler",
	},
	{
		name = "Demons",
		requiredKills = 666,
		creatures = { "demon" },
		exp = 3000000,
		money = 30000,
		tibiaCoins = 15,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		rewards = { { id = 9388 } },
		bossName = "Demonica",
	},
	{
		name = "Destroyers",
		requiredKills = 300,
		creatures = { "destroyer" },
		exp = 900000,
		money = 20000,
		tibiaCoins = 3,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Bretzecutioner",
	},
	{
		name = "Drakens",
		requiredKills = 400,
		creatures = {
			"draken abomination",
			"draken elite",
			"draken spellweaver",
			"draken warmaster",
		},
		exp = 1078125,
		money = 5000,
		tibiaCoins = 3,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Paiz the Pauperizer",
	},
	{
		name = "Frost Dragons",
		requiredKills = 350,
		creatures = { "frost dragon", "frost dragon hatchling", "ice dragon" },
		exp = 540000,
		money = 15000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Frosty",
	},
	{
		name = "Ghastly Dragons",
		requiredKills = 200,
		creatures = { "ghastly dragon" },
		exp = 1707500,
		money = 10000,
		tibiaCoins = 5,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Ethershreck",
	},
	{
		name = "Hellhounds",
		requiredKills = 150,
		creatures = { "hellhound" },
		exp = 1530000,
		money = 15000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Kerberos",
	},
	{
		name = "Hellspawns",
		requiredKills = 300,
		creatures = { "hellspawn" },
		exp = 900000,
		money = 10000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Flameborn",
	},
	{
		name = "High Class Lizards",
		requiredKills = 400,
		creatures = {
			"lizard legionnaire",
			"lizard dragon priest",
			"lizard high guard",
			"lizard zaogun",
			"lizard chosen",
		},
		exp = 320000,
		money = 10000,
		tibiaCoins = 3,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Fazzrah",
	},
	{
		name = "Hydras",
		requiredKills = 350,
		creatures = { "hydra" },
		exp = 630000,
		money = 15000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "The Many",
	},
	{
		name = "Killer Caimans",
		requiredKills = 300,
		creatures = { "killer caiman" },
		exp = 236250,
		money = 5000,
		tibiaCoins = 2,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Killa",
	},
	{
		name = "Medusas",
		requiredKills = 300,
		creatures = { "medusa" },
		exp = 759375,
		money = 15000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Gorgo",
	},
	{
		name = "Nightmares",
		requiredKills = 250,
		creatures = { "nightmare", "nightmare scion" },
		exp = 645000,
		money = 10000,
		tibiaCoins = 3,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Tormentor",
	},
	{
		name = "Quaras",
		requiredKills = 400,
		creatures = {
			"quara constrictor",
			"quara constrictor scout",
			"quara hydromancer",
			"quara hydromancer scout",
			"quara mantassin",
			"quara mantassin scout",
			"quara pincher",
			"quara pincher scout",
			"quara predator",
			"quara predator scout",
		},
		exp = 600000,
		money = 10000,
		tibiaCoins = 4,
		min = 46,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Thul",
	},
	{
		name = "Sea Serpents",
		requiredKills = 500,
		creatures = { "sea serpent", "young sea serpent" },
		exp = 450000,
		money = 7000,
		tibiaCoins = 2,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Leviathan",
	},
	{
		name = "Serpent Spawns",
		requiredKills = 400,
		creatures = { "serpent spawn" },
		exp = 762500,
		money = 15000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "The Noxious Spawn",
	},
	{
		name = "Undead Dragons",
		requiredKills = 200,
		creatures = { "undead dragon" },
		exp = 2008800,
		money = 5000,
		tibiaCoins = 4,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Zanakeph",
	},
	{
		name = "Werewolves",
		requiredKills = 300,
		creatures = { "werewolf" },
		exp = 498750,
		money = 10000,
		tibiaCoins = 3,
		min = 121,
		max = NO_MAX_LEVEL_LIMIT,
		bossName = "Hemming",
	},
}

local portalKeyToTask = {}
local creatureNameToTask = {}
local bossNameToTask = {}
local storageToTask = {}

function GetTaskByCreatureName(creatureName)
	return creatureNameToTask[creatureName]
end
function GetTaskByBossName(bossName)
	return bossNameToTask[bossName]
end
function GetTaskByPortalKey(key)
	return portalKeyToTask[key]
end
function GetTaskByStorage(storage)
	return storageToTask[storage]
end
function GetAllTasks()
	return taskData
end

local taskScope = Scope("Task")
function GenerateTasksAuxillaryData()
	for _, task in pairs(GetAllTasks()) do
		local storage = taskScope:Get(task.name, "State")
		local currentKills = taskScope:Get(task.name, "CurrentKills")
		local bossAdmitCounter = taskScope:Get(task.name, "BossFightAdmits")

		task.storage = storage
		task.currentKills = currentKills
		task.bossAdmitCounter = bossAdmitCounter

		task.bossRoomEnterPortal = taskScope:Get(task.name, "BossRoomEnterPortal")
		task.bossSpawnPositionKey = taskScope:Get(task.name, "BossSpawnPosition")
		task.playerSpawnPositionKey = taskScope:Get(task.name, "PlayerSpawnPosition")
		task.bossRoomKey = taskScope:Get(task.name, "BossRoom")

		bossNameToTask[task.bossName] = task
		storageToTask[task.storage] = task
		portalKeyToTask[task.bossRoomEnterPortal] = task

		for _, creatureName in pairs(task.creatures) do
			creatureNameToTask[creatureName] = task
		end
	end

	local function validateTask(task)
		if not task.bossRoomZone:randomPosition() then
			logger.warn(T("[validateBossRoomZone] task :taskName: bossRoomZone is empty.", { taskName = task.name }))
		end

		local bossNames = {}
		if type(task.bossName) == "table" then
			bossNames = task.bossName
		else
			table.insert(bossNames, task.bossName)
		end
		if #bossNames > 0 then
			for _, bossName in pairs(bossNames) do
				if not MonsterType(bossName) then
					logger.warn(T("[validateBossRoomZone] task :taskName: has nonexistant boss with name :bossName: is empty.", { taskName = task.name, bossName = bossName }))
				end
			end
		else
			logger.warn(T("[validateBossRoomZone] task :taskName: bossName is empty.", { taskName = task.name }))
		end
	end

	local setupTaskZones = GlobalEvent("SetupTaskZones")
	function setupTaskZones.onStartup()
		for _, task in pairs(GetAllTasks()) do
			task.bossSpawnPosition = Zone(task.bossSpawnPositionKey):randomPosition()
			task.playerSpawnPosition = Zone(task.playerSpawnPositionKey):randomPosition()
			task.bossRoomZone = Zone(task.bossRoomKey)
			validateTask(task)
		end
	end
	setupTaskZones:register()
end

function RegisterTasksInQuestsTable()
	for _, task in pairs(GetAllTasks()) do
		local killsMission = {
			name = "TASK_MISSION_NAME",
			task = task,
			storage = task.storage,
			minState = 0,
			description = "TASK_MISSION_DESCRIPTION",
		}
		local bossMission = {
			name = "FIGHT_WITH_TASK_BOSS_MISSION_NAME",
			task = task,
			storage = task.bossAdmitCounter,
			minState = 0,
			description = "FIGHT_WITH_TASK_BOSS_MISSION_DESCRIPTION",
		}

		table.insert(TaskQuestlog.missions, killsMission)
		table.insert(TaskQuestlog.missions, bossMission)
	end
end

--[[
	{
		name = "Mammoths",
		requiredKills = 200,
		creatures = { "mammoth" },
		exp = 24000, 
		money = 5000,
		tibiaCoins = 2,
		min = 0,
		max = 45,
		bossName = "The Bloodtusk",
		bossPosition = Position(6500, 1840, 9),
		bossRoomCenter = Position(6500, 1845, 9),
					},
	]]
