local quest = Quest(LOCALIZERS.Task)

quest
	:Storage(function()
		Storage.Task = {
			TaskInfo = {},
			TaskPoints = {},
			PlayerOngoingTasks = {
				[1] = {},
				[2] = {},
				[3] = {},
			},
			BossRoomExitPortal = {},
			LastBossRoomEnterPosition = {},
		}
	end)
	:Constant(function()
		TASK_CANT_START_BECAUSE_HIGHER_LEVEL = -2
		TASK_CAN_START_DESPITE_HIGHER_LEVEL = -1

		TASK_SLOT_UNOCCUPIED = -1

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
				bossName = "Falcon Eesko",
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
				bossName = "Lost Extrohusher",
			},
			{
				name = "Vampires",
				requiredKills = 400,
				creatures = { "vampire", "vampire viscount", "vampire bride" },
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
					"orc marauder",
					"rorc",
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
		function GetAllTasks()
			return taskData
		end
	end)
	:Questlog(function(localizer)
		TaskQuestlog = {
			name = "Tasks",
			localizer = localizer,
			missions = {
				{
					name = "Task informations",
					storage = Storage.Task.TaskInfo,
					description = "TASKS_HELP_WINDOW_INFO",
				},
			},
		}
		table.insert(Questlog, TaskQuestlog)
	end)
	:Script(function() -- auxillary data generation
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

		local taskScope = Scope("Task")
		local function generateTasksAuxillaryData()
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
		end
		generateTasksAuxillaryData()
	end)
	:Script(function() -- validation
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
				task.bossSpawnPosition = Zone(task.bossSpawnPositionKey):getSinglePosition()
				task.playerSpawnPosition = Zone(task.playerSpawnPositionKey):getSinglePosition()
				task.bossRoomZone = Zone(task.bossRoomKey)
				validateTask(task)
			end
		end
		setupTaskZones:register()
	end)
	:Script(function() -- generate and append mission questlog entries
		local function registerTasksInQuestsTable()
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
					minState = 1,
					description = "FIGHT_WITH_TASK_BOSS_MISSION_DESCRIPTION",
				}

				table.insert(TaskQuestlog.missions, killsMission)
				table.insert(TaskQuestlog.missions, bossMission)
			end
		end
		registerTasksInQuestsTable()
	end)
	:Script(function() -- boss room
		local function clearBossRoom(task)
			local players = task.bossRoomZone:getPlayers()
			for _, player in pairs(players) do
				player:teleportToStoredOrTemple(Storage.Task.LastBossRoomEnterPosition)
			end
		end

		local function playerIsCheesing(fromPosition, toPosition)
			if toPosition == fromPosition then
				return true
			end
			return false
		end

		local function taskRandomBossName(task)
			local bossName = task.bossName
			if type(task.bossName) == "table" then
				bossName = table.random(task.bossName)
			end
			return bossName
		end
		local defaultTimeLimitMinutes = 5
		local function beforeEnter(player, task, fromPosition)
			local remainingMonsters = task.bossRoomZone:getMonsters()
			for _, monster in pairs(remainingMonsters) do
				monster:remove()
			end

			player:setStorageValueByKey(Storage.Task.LastBossRoomEnterPosition, fromPosition)

			stopEvent(task.clearRoomEvent)

			local bossName = taskRandomBossName(task)
			local boss = Game.createMonster(bossName, task.bossSpawnPosition, true, true)
			if not boss then
				logger.error(T("Could not create boss ':bossName:' creature for the task :name: on position :pos:.", { bossName = task.bossName, name = task.name, pos = task.bossSpawnPosition:ToString() }))
				player:say(T("[bossRoomEntrance::onStepIn::beforeEnter] cannot spawn boss :bossName:. Please contact an administrator.", { bossName = bossName }), TALKTYPE_MONSTER_SAY)
				return
			end

			local timeLimitMinutes = task.bossTimeLimit or defaultTimeLimitMinutes
			task.clearRoomEvent = addEvent(clearBossRoom, 60 * timeLimitMinutes * 1000, task)

			player:teleportTo(task.playerSpawnPosition)
			task.playerSpawnPosition:sendMagicEffect(CONST_ME_TELEPORT)
			player:say(T("You have :time: minutes to defeat :bossName:.", { time = timeLimitMinutes, bossName = bossName }), TALKTYPE_MONSTER_SAY)

			local currentAdmits = player:getStorageValueByKey(task.bossAdmitCounter)
			local nextAdmits = currentAdmits - 1
			player:setStorageValueByKey(task.bossAdmitCounter, nextAdmits)
		end

		local function canEnter(player, task, fromPosition, toPosition)
			if not player then
				return false
			end

			if playerIsCheesing(fromPosition, toPosition) then
				player:teleportTo(player:getTown():getTemplePosition())
				return false
			end

			local availableBossEntries = player:getStorageValueByKey(task.bossAdmitCounter)
			if availableBossEntries <= 0 then
				player:sendCancelMessage("You cannot enter until you finish the task.")
				return false
			end

			if task.bossRoomZone:countPlayers() > 0 then
				player:sendCancelMessage("Someone is already inside.")
				return false
			end

			return true
		end

		local function registerTasksBossTp()
			local bossRoomEntrance = MoveEvent()
			function bossRoomEntrance.onStepIn(creature, item, toPosition, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return
				end

				local task = GetTaskByPortalKey(item:getKey())
				if canEnter(player, task, fromPosition, toPosition) then
					beforeEnter(player, task, fromPosition)
				else
					player:teleportTo(fromPosition)
				end

				return true
			end
			bossRoomEntrance:type("stepin")
			for _, task in pairs(GetAllTasks()) do
				bossRoomEntrance:key(task.bossRoomEnterPortal)
			end
			bossRoomEntrance:register()

			local bossRoomExit = MoveEvent()
			function bossRoomExit.onStepIn(creature, item, toPosition, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return
				end

				player:teleportToStoredOrTemple(Storage.Task.LastBossRoomEnterPosition)
				return true
			end
			bossRoomExit:type("stepin")
			bossRoomExit:key("Task-BossRoomExitPortal")
			bossRoomExit:register()
		end
		registerTasksBossTp()
	end)
	:Script(function() -- task kill counter
		local function taskRewardCanBeClaimed(player, task)
			local state = player:getStorageValueByKey(task.storage)
			return state == REPORT_TASK_TO_NPC
		end

		---@param task table
		---@return boolean
		function Player:AddTaskKill(task)
			self:IncrementStorage(task.currentKills)
			self:RefreshStorage(task.storage)

			local currentKillsString = self:Localizer(LOCALIZERS.Task):Context({ task = task }):Get("TASK_CURRENT_KILLS")
			self:sendTextMessage(MESSAGE_EXPERIENCE, currentKillsString)

			if self:getStorageValueByKey(task.currentKills) >= task.requiredKills then
				self:setStorageValueByKey(task.storage, REPORT_TASK_TO_NPC)
				self:setStorageValueByKey(task.currentKills, task.requiredKills)

				local translatedMessageWhenFinished = self:Localizer(LOCALIZERS.Task):Context({ task = task }):Get("TASK_READY_TO_TURN_IN")
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessageWhenFinished)

				local bossAdmits = math.max(self:getStorageValueByKey(task.bossAdmitCounter), 0)
				local nextBossAdmits = bossAdmits + 1
				self:setStorageValueByKey(task.bossAdmitCounter, nextBossAdmits)
			end
		end

		function Player:CanAddTaskKill(task)
			if not task then
				return false
			end
			local state = self:getStorageValueByKey(task.storage)
			if state == TASK_CAN_START_DESPITE_HIGHER_LEVEL then
				return false
			end
			if state == TASK_CANT_START_BECAUSE_HIGHER_LEVEL then
				return false
			end
			if taskRewardCanBeClaimed(self, task) then
				return false
			end
			if state >= REPORT_TASK_TO_NPC then
				return false
			end
			return true
		end

		function Player:TryAddTaskKill(task)
			if self:CanAddTaskKill(task) then
				self:AddTaskKill(task)
				return true
			end
			return false
		end

		local function taskIfKilledMonster(killedCreature)
			local targetMonster = killedCreature:getMonster()
			if not targetMonster or targetMonster:getMaster() then
				return nil
			end

			return GetTaskByCreatureName(killedCreature:getName():lower())
		end

		local maxTaskKillGrants = 2
		local taskMonsterDeath = CreatureEvent("TaskMonsterDeath")
		function taskMonsterDeath.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
			local task = taskIfKilledMonster(killedCreature)
			if not task then
				return
			end

			local damageMap = killedCreature:getDamageMap()
			local topKillers = GetTopKillers(damageMap)
			local playersGranted = 0

			local lastHitKillerPlayer = Player(lastHitKiller)
			if lastHitKillerPlayer and lastHitKillerPlayer:TryAddTaskKill(task) then
				playersGranted = 1
			end

			for _, player in pairs(topKillers) do
				if playersGranted >= maxTaskKillGrants then
					break
				end

				if player ~= lastHitKillerPlayer and player:TryAddTaskKill(task) then
					playersGranted = playersGranted + 1
				end
			end
			return true
		end
		taskMonsterDeath:register()

		local taskMonsterDeathStartup = GlobalEvent("TaskMonsterDeathStartup")
		function taskMonsterDeathStartup.onStartup()
			local monsterNames = {}
			for _, task in pairs(GetAllTasks()) do
				for _, monsterName in pairs(task.creatures) do
					monsterNames[monsterName:lower()] = true
				end
			end

			for monsterName in pairs(monsterNames) do
				local mType = MonsterType(monsterName)
				if not mType then
					logger.error("[TaskMonsterDeathStartup] monster with name {} is not a valid MonsterType", monsterName)
				else
					mType:registerEvent("TaskMonsterDeath")
				end
			end
		end
		taskMonsterDeathStartup:register()
	end)
	:Script(function() -- task window and completion at npc
		local function resetTaskSuccesfulCompletion(player, task)
			player:setStorageValueByKey(task.currentKills, MISSION_NOT_STARTED)
			player:setStorageValueByKey(task.storage, TASK_CANT_START_BECAUSE_HIGHER_LEVEL)
		end

		local function cancelTask(player, task)
			player:setStorageValueByKey(task.currentKills, MISSION_NOT_STARTED)
			player:setStorageValueByKey(task.storage, TASK_CAN_START_DESPITE_HIGHER_LEVEL)
		end

		local function resetTaskSlot(player, taskSlot)
			player:setStorageValueByKey(taskSlot, TASK_SLOT_UNOCCUPIED)
		end

		local function slotHasInvalidStorage(taskStorage)
			if taskStorage == TASK_SLOT_UNOCCUPIED then
				return false
			end

			local task = GetTaskByStorage(taskStorage)
			if task then
				return false
			end

			return true
		end
		local function hasThisTaskDone(player, taskStorage)
			local state = player:getStorageValueByKey(taskStorage)
			if state == REPORT_TASK_TO_NPC then
				return true
			end

			return false
		end

		function hasAnyTaskDone(context)
			local player = context.player
			for _, taskSlot in pairs(Storage.Task.PlayerOngoingTasks) do
				local taskStorage = player:getStorageValueByKey(taskSlot)
				if slotHasInvalidStorage(taskStorage) then
					player:setStorageValueByKey(taskSlot, TASK_SLOT_UNOCCUPIED)
				elseif hasThisTaskDone(player, taskStorage) then
					return true
				end
			end
			return false
		end

		local function canTakeAnotherTask(context)
			local player = context.player
			local activeTasks = 0
			local maximumAllowedOngoingTasks = #Storage.Task.PlayerOngoingTasks
			for _, taskSlot in pairs(Storage.Task.PlayerOngoingTasks) do
				local ongoingTaskStorage = player:getStorageValueByKey(taskSlot)
				if ongoingTaskStorage ~= TASK_SLOT_UNOCCUPIED then
					activeTasks = activeTasks + 1
				end
			end

			return activeTasks < maximumAllowedOngoingTasks
		end

		local function hasAnyOngoingTask(context)
			local player = context.player
			for _, taskSlot in pairs(Storage.Task.PlayerOngoingTasks) do
				local ongoingTaskStorage = player:getStorageValueByKey(taskSlot)
				if ongoingTaskStorage ~= TASK_SLOT_UNOCCUPIED then
					return true
				end
			end

			return false
		end

		function Player:AddOngoingTask(task)
			for _, taskSlot in pairs(Storage.Task.PlayerOngoingTasks) do
				local ongoingTaskStorage = self:getStorageValueByKey(taskSlot)
				if ongoingTaskStorage == TASK_SLOT_UNOCCUPIED then
					self:setStorageValueByKey(task.currentKills, 0)
					self:setStorageValueByKey(task.storage, MISSION_STARTED)
					self:setStorageValueByKey(taskSlot, task.storage)
					return true
				end
			end
			return false
		end

		local function selectTaskFromList(player, button, choice)
			local task = choice.task
			player:AddOngoingTask(task)
		end

		local function cancelTaskFromList(player, button, choice)
			if choice.task then
				cancelTask(player, choice.task)
			end
			if choice.taskSlot then
				resetTaskSlot(player, choice.taskSlot)
			end
		end

		local function showTaskHelpWindow(player)
			local translatedMessage = player:Localizer(LOCALIZERS.Task):Get("TASKS_HELP_WINDOW_INFO")
			player:showTextDialog(7397, translatedMessage)
		end

		local function playerIsInTaskLevelRange(player, task)
			local playerLevel = player:getLevel()
			local min = task.min or 0
			local max = task.max or 99999
			return min <= playerLevel and playerLevel <= max
		end

		local function playerHasMinimumLevel(player, task)
			local playerLevel = player:getLevel()
			local min = task.min or 0
			return min <= playerLevel
		end

		local function playerNeverFinishedTask(player, task)
			return player:getStorageValueByKey(task.storage) == TASK_CAN_START_DESPITE_HIGHER_LEVEL
		end

		local function playerHasThisTaskTaken(player, task)
			for _, taskSlot in pairs(Storage.Task.PlayerOngoingTasks) do
				local ongoingTaskStorage = player:getStorageValueByKey(taskSlot)
				if ongoingTaskStorage == task.storage then
					return true
				end
			end
			return false
		end

		local function playerCanTakeTask(player, task)
			if playerHasThisTaskTaken(player, task) then
				return false
			end
			if playerIsInTaskLevelRange(player, task) then
				return true
			end
			if playerHasMinimumLevel(player, task) and playerNeverFinishedTask(player, task) then
				return true
			end
			return false
		end

		local function openTaskWindow(context)
			local player = context.player

			local localizer = player:Localizer(LOCALIZERS.Task)
			local message = localizer:Get("Select task you're interested in: ")
			local title = localizer:Get("Available Task list")
			local modalWindow = ModalWindow({ title = title, message = message })

			local availableTasks = {}
			for _, task in pairs(GetAllTasks()) do
				if playerCanTakeTask(player, task) then
					table.insert(availableTasks, task)
				end
			end

			table.sort(availableTasks, function(a, b)
				return a.name < b.name
			end)

			for _, task in pairs(availableTasks) do
				local choice = modalWindow:addChoice(T(":name: (:requiredKills:)", {
					name = task.name,
					requiredKills = task.requiredKills,
					task = task.task,
				}))
				choice.task = task
			end

			local select = modalWindow:addButton(localizer:Get("Select"), selectTaskFromList)
			local cancel = modalWindow:addButton(localizer:Get("Cancel"))

			modalWindow:addButton(localizer:Get("Help"), showTaskHelpWindow)
			modalWindow:setDefaultEnterButton(select.id - 1)
			modalWindow:setDefaultEscapeButton(cancel.id - 1)

			modalWindow:sendToPlayer(player)
		end

		local function openTaskCancelWindow(context)
			local player = context.player

			local localizer = player:Localizer(LOCALIZERS.Task)
			local message = localizer:Get("Select task you want to cancel: ")
			local title = localizer:Get("Ongoing tasks list:")
			local modalWindow = ModalWindow({ title = title, message = message })
			for _, taskSlot in pairs(Storage.Task.PlayerOngoingTasks) do
				local ongoingTaskStorage = player:getStorageValueByKey(taskSlot)
				local task = GetTaskByStorage(ongoingTaskStorage)
				if task then
					local choice = modalWindow:addChoice(T(":name:", { name = task.name }))
					choice.taskSlot = taskSlot
					choice.task = task
				end
			end

			local select = modalWindow:addButton(localizer:Get("Select"), cancelTaskFromList)
			local exit = modalWindow:addButton(localizer:Get("Exit"))

			modalWindow:addButton(localizer:Get("Help"), showTaskHelpWindow)
			modalWindow:setDefaultEnterButton(select.id - 1)
			modalWindow:setDefaultEscapeButton(exit.id - 1)

			modalWindow:sendToPlayer(player)
		end

		local function grantTaskRewards(context, task)
			local player = context.player

			if not player:TryAddItems(task.rewards or {}) then
				return false
			end
			local money = task.money
			local coins = task.tibiaCoins
			local exp = task.exp

			player:addMoney(money)
			player:AddAllCoins(coins)
			player:IncrementStorage(Storage.Task.TaskPoints, coins)
			player:addExperience(exp, true)
			return true
		end

		local rewardWasNotGranted = false
		local rewardWasGranted = true
		function Player:TryAddTaskRewards(context, task, taskSlot)
			local storage = task.storage
			local state = self:getStorageValueByKey(storage)
			if state ~= REPORT_TASK_TO_NPC then
				return rewardWasNotGranted
			end
			if not grantTaskRewards(context, task) then
				return rewardWasNotGranted
			end
			resetTaskSuccesfulCompletion(self, task)
			resetTaskSlot(self, taskSlot)
			return rewardWasGranted
		end

		local function grantRewardsForAllTasks(context)
			local player = context.player
			local translatedMessage = ""
			for _, taskSlot in pairs(Storage.Task.PlayerOngoingTasks) do
				local ongoingTaskStorage = player:getStorageValueByKey(taskSlot)
				local task = GetTaskByStorage(ongoingTaskStorage)
				if task then
					local grantedRewardForThisTask = player:TryAddTaskRewards(context, task, taskSlot)
					if grantedRewardForThisTask then
						translatedMessage = translatedMessage .. player:Localizer(LOCALIZERS.Task):Context({ task = task }):Get("TASK_REWARDS_DIALOG") .. "\n"
					end
				end
			end

			translatedMessage = translatedMessage .. player:Localizer(LOCALIZERS.Task):Get("Great job!")
			context.npcHandler:say(translatedMessage, context.npc, context.player)
		end

		JOB_UNIVERSAL_DIALOGS[JOB_TASKS] = {
			[{ "zadanie", "zadania", "nagroda", "wykonane", "reward" }] = {
				text = "NO_TEXT",
				specialRequirements = {
					{
						requirement = hasAnyTaskDone,
						requiredOutcome = true,
						textFailedRequirement = "Finish one of {tasks}, then we can talk about reward.",
					},
				},
				specialActionsOnSuccess = {
					{
						action = grantRewardsForAllTasks,
					},
				},
			},
			[{ "tasks", "taski", "biore", "task", "taskow" }] = {
				text = "NO_TEXT",
				specialRequirements = {
					{
						requirement = canTakeAnotherTask,
						requiredOutcome = true,
						textFailedRequirement = "YOU_HAVE_MAX_ONGOING_TASKS",
					},
				},
				specialActionsOnSuccess = { { action = openTaskWindow } },
			},
			[{ "zakoncz", "koniec", "cancel", "anuluj", "Anuluj" }] = {
				text = "NO_TEXT",
				specialActionsOnSuccess = { { action = openTaskCancelWindow } },
				specialRequirements = {
					{
						requirement = hasAnyOngoingTask,
						requiredOutcome = true,
						textFailedRequirement = "You don't have any active tasks. Ask me for {tasks} to sign up for one.",
					},
				},
			},
		}
	end)
	:Register()
