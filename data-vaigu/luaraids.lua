-- Lua Raids by Homeslice@otland.net
LUA_RAID_CONFIG = {
	--[[ 
   ["test"] = {
        --Automatic Raids - using the talkaction skips these checks.
        --spawnInterval = 99000, --optional, 1000 = 1% chance per globalevent(GE) (10 min),
		spawnInterval = 1000, --optional, 1000 = 1% chance per globalevent(GE) (10 min),
            --1440 min in a day / globalEvent interval (10 min) = 144 runs a day,
            --1% (chance) / 100 * 144 (GEs times run) = average of 1.44 of this raid, per day
        secondsBetweenRerunning = 24*60*60,--optional, SECONDS, 86400 = 24 hours
        secondsBetweenOtherRaids = 30*60,--optional, SECONDS, 3600 = 1 hour. Other raids includes this raid too.
        minPlayersOnline = 1, --optional, amount of players online for raid to occur
      
        --Raid Details
        --lastRunTime = TIME, Automatically created. Do not uncomment.
        announcements = { --optional, can set announcements to nil
            --{ delay = 0, message = "Test", broadcastType = MESSAGE_EVENT_ADVANCE}, --broadcastType is optional
            { delay = 0, message = "Gobliny nadchodza okrasc miasto!"},
            { delay = 1000, message = "Creatures from the intiri swamp are fleeing into town due to the toxic smog!"},
        },
        delayGroups = {--optional, give any creature a delayGroup of 1 to them spawning by 5000 MS or 5 seconds.
            2000,4000 --Milliseconds, first entry = delayGroup 1, second = 2...
        },
        --msDespawnDelay = 20000, --Optional. In Milliseconds. 3600000 = 1 hour. Removes all creatures spawned by the raid. 20000-20sek
        creatures = {
            --AVAILABLE PARAMETERS
            --spawnAmount, {from/to OR position}, delayGroup, force (forceSpawn/stack), and npc are optional
            --note: monsters with a from/to.x are not guranteed to be spawned by enabling force, but they will spawn/stack on other creatures.
            --    The force flag is guranteed to spawn monsters on a single position, providing the position is walkable.
          
            --{ name="Orc", position = {x = 1056, y = 1056, z = 7}, delayGroup = 1, force = true, npc=false },
            --{ name="Orc", from = {x = 1056, y = 1056, z = 7}, to = {x = 1058, y = 1058, z = 7}, delayGroup = 1, force = true },
            --{ name="Demon", position = {x = 1056, y = 1056, z = 7}, force = false, npc=true },
            --{ name="Demon", from = {x = 1056, y = 1056, z = 7}, to = {x = 1058, y = 1058, z = 7}, force = false, npc=true },
      
            { name="Grynch Clan Goblin", spawnAmount = 8, from = {x = 5839, y = 1525, z = 7}, to = {x = 5844, y = 1527, z = 7}, delayGroup = 1, force = true },
            { name="Grynch Clan Goblin", spawnAmount = 1, position = {x = 5836, y = 1520, z = 7}, delayGroup = 1, force = true },
        },
    },
	]]
	--[[
		200 = 0.2 * 1440 = 0.28

		100 = 0.1 = 0.14/day
		200 = 0.2 = 0.28/day
		300 = 0.43/day
		500 = 0.72/day
		800 = 1.15/day
		1000 = 1.44/day
	]]
	["Horestis"] = {
		spawnInterval = 250, -- 0.45/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Horestis",
				spawnAmount = 1,
				position = { x = 6573, y = 1454, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Grynch"] = {
		spawnInterval = 200, -- 0.28/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		announcements = {
			{
				delay = 1000,
				message = "Goblins are coming to rob the city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 120000,
				message = "The goblins have come to rob the city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 125000, 360000 },
		creatures = {
			{
				name = "Grynch Clan Goblin",
				spawnAmount = 200,
				from = { x = 5793, y = 1480, z = 7 },
				to = { x = 5973, y = 1598, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Grynch Clan Goblin",
				spawnAmount = 220,
				from = { x = 5793, y = 1480, z = 7 },
				to = { x = 5973, y = 1598, z = 7 },
				delayGroup = 2,
				force = true,
			},
		},
	},
	["Snowman"] = {
		spawnInterval = 400, -- 0.28/day == 50000
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Animated Snowman",
				spawnAmount = 20,
				from = { x = 5793, y = 1480, z = 7 },
				to = { x = 5973, y = 1598, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Snowman Sybir"] = {
		spawnInterval = 400, -- 0.28/day == 8000
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Animated Snowman",
				spawnAmount = 10,
				from = { x = 6478, y = 1815, z = 7 },
				to = { x = 6594, y = 1879, z = 6 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Zomba"] = {
		spawnInterval = 300, -- 0.43/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Lion Raid",
				spawnAmount = 35,
				from = { x = 6603, y = 1233, z = 7 },
				to = { x = 6672, y = 1302, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Zomba",
				spawnAmount = 1,
				from = { x = 6603, y = 1233, z = 7 },
				to = { x = 6672, y = 1302, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Zolwie"] = {
		spawnInterval = 250, -- 0.3/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Tortoise Raid",
				spawnAmount = 35,
				from = { x = 7010, y = 774, z = 6 },
				to = { x = 7066, y = 815, z = 6 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Ribstride"] = {
		spawnInterval = 300, -- 0.43/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Bonebeast Raid",
				spawnAmount = 35,
				from = { x = 6905, y = 1232, z = 7 },
				to = { x = 6966, y = 1279, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ribstride",
				spawnAmount = 1,
				from = { x = 6905, y = 1232, z = 7 },
				to = { x = 6966, y = 1279, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Piracimirko"] = {
		spawnInterval = 200, -- 0.36/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Pirate Buccaneer Raid",
				spawnAmount = 12,
				from = { x = 5966, y = 1495, z = 7 },
				to = { x = 6019, y = 1542, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Pirate Marauder Raid",
				spawnAmount = 10,
				from = { x = 5966, y = 1495, z = 7 },
				to = { x = 6019, y = 1542, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Piraci"] = {
		spawnInterval = 200, -- 0.36/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		announcements = {
			{
				delay = 1000,
				message = "Pirates have attacked Kongo!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 170000,
				message = "Pirates are sending support!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 350000,
				message = "Pirates have sent additional reinforcements!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 180000, 360000 },
		creatures = {
			{
				name = "Pirate Buccaneer Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Marauder Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Cutthroat Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Corsair Raid",
				spawnAmount = 35,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Smuggler Raid",
				spawnAmount = 25,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Buccaneer Raid",
				spawnAmount = 6,
				from = { x = 6971, y = 768, z = 5 },
				to = { x = 6981, y = 789, z = 5 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Marauder Raid",
				spawnAmount = 6,
				from = { x = 6971, y = 768, z = 5 },
				to = { x = 6981, y = 789, z = 5 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Buccaneer Raid",
				spawnAmount = 8,
				from = { x = 6989, y = 737, z = 5 },
				to = { x = 7063, y = 765, z = 5 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Marauder Raid",
				spawnAmount = 8,
				from = { x = 6989, y = 737, z = 5 },
				to = { x = 7063, y = 765, z = 5 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Cutthroat Raid",
				spawnAmount = 8,
				from = { x = 6989, y = 737, z = 5 },
				to = { x = 7063, y = 765, z = 5 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Corsair Raid",
				spawnAmount = 8,
				from = { x = 6989, y = 737, z = 5 },
				to = { x = 7063, y = 765, z = 5 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Pirate Buccaneer Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Pirate Marauder Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Pirate Cutthroat Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Pirate Corsair Raid",
				spawnAmount = 30,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Smuggler Raid",
				spawnAmount = 25,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Pirate Buccaneer Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Pirate Marauder Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Pirate Cutthroat Raid",
				spawnAmount = 40,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Pirate Corsair Raid",
				spawnAmount = 35,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Smuggler Raid",
				spawnAmount = 25,
				from = { x = 6976, y = 741, z = 5 },
				to = { x = 7064, y = 814, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Ron The Ripper",
				spawnAmount = 1,
				position = { x = 7021, y = 804, z = 6 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Lethal Lissy",
				spawnAmount = 1,
				position = { x = 7040, y = 774, z = 6 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Brutus Bloodbeard",
				spawnAmount = 1,
				position = { x = 6982, y = 750, z = 6 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Deadeye Devious",
				spawnAmount = 1,
				position = { x = 7012, y = 763, z = 6 },
				delayGroup = 3,
				force = true,
			},
		},
	},
	["OrcBp"] = {
		spawnInterval = 160, -- 0.23/day
		secondsBetweenRerunning = 6 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Orc Sambackpack",
				spawnAmount = 1,
				from = { x = 5803, y = 1298, z = 7 },
				to = { x = 5808, y = 1302, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Minotaury"] = {
		spawnInterval = 200, -- 0.36/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		announcements = {
			{
				delay = 1000,
				message = "A group of minotaurs has left their camp.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 120000,
				message = "Minotaurs are approaching the city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 180000,
				message = "Minotaurs are attacking the city walls!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 240000,
				message = "The attack will likely cease if their general falls!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 120000, 185000, 245000 },
		creatures = {
			{
				name = "Minotaur Raid",
				spawnAmount = 17,
				from = { x = 5943, y = 1357, z = 7 },
				to = { x = 5975, y = 1383, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Minotaur Guard Raid",
				spawnAmount = 15,
				from = { x = 5943, y = 1357, z = 7 },
				to = { x = 5975, y = 1383, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Minotaur Archer Raid",
				spawnAmount = 18,
				from = { x = 5943, y = 1357, z = 7 },
				to = { x = 5975, y = 1383, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Minotaur Mage Raid",
				spawnAmount = 5,
				from = { x = 5943, y = 1357, z = 7 },
				to = { x = 5975, y = 1383, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Minotaur Raid",
				spawnAmount = 38,
				from = { x = 5891, y = 1411, z = 7 },
				to = { x = 5947, y = 1460, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Minotaur Guard Raid",
				spawnAmount = 38,
				from = { x = 5891, y = 1411, z = 7 },
				to = { x = 5947, y = 1460, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Minotaur Archer Raid",
				spawnAmount = 38,
				from = { x = 5891, y = 1411, z = 7 },
				to = { x = 5947, y = 1460, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Minotaur Mage Raid",
				spawnAmount = 15,
				from = { x = 5891, y = 1411, z = 7 },
				to = { x = 5947, y = 1460, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Minotaur Raid",
				spawnAmount = 38,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Minotaur Guard Raid",
				spawnAmount = 38,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Minotaur Archer Raid",
				spawnAmount = 38,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Minotaur Mage Raid",
				spawnAmount = 15,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Minotaur Raid",
				spawnAmount = 45,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 4,
				force = true,
			},
			{
				name = "Minotaur Guard Raid",
				spawnAmount = 45,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 4,
				force = true,
			},
			{
				name = "Minotaur Archer Raid",
				spawnAmount = 45,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 4,
				force = true,
			},
			{
				name = "Minotaur Mage Raid",
				spawnAmount = 15,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 4,
				force = true,
			},
			{
				name = "General Murius",
				spawnAmount = 1,
				from = { x = 5885, y = 1436, z = 7 },
				to = { x = 5946, y = 1477, z = 7 },
				delayGroup = 4,
				force = true,
			},
		},
	},
	["Lizardape"] = {
		spawnInterval = 200, -- 0.29/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		announcements = {
			{
				delay = 1000,
				message = "Lizardmen are trying to defend themselves against the monkeys' attack on their settlement.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 15000, 120000 },
		creatures = {
			{
				name = "Lizard Sentinel Raid",
				spawnAmount = 30,
				from = { x = 6774, y = 784, z = 7 },
				to = { x = 6826, y = 862, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Lizard Snakecharmer Raid",
				spawnAmount = 20,
				from = { x = 6774, y = 784, z = 7 },
				to = { x = 6826, y = 862, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Lizard Templar Raid",
				spawnAmount = 20,
				from = { x = 6774, y = 784, z = 7 },
				to = { x = 6826, y = 862, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Battlemaster Zunzu Raid",
				spawnAmount = 1,
				from = { x = 6774, y = 784, z = 7 },
				to = { x = 6822, y = 811, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Kongra Raid",
				spawnAmount = 35,
				from = { x = 6744, y = 767, z = 7 },
				to = { x = 6822, y = 811, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Merlkin Raid",
				spawnAmount = 35,
				from = { x = 6744, y = 767, z = 7 },
				to = { x = 6822, y = 811, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Sibang Raid",
				spawnAmount = 35,
				from = { x = 6744, y = 767, z = 7 },
				to = { x = 6822, y = 811, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Lizard Sentinel Raid",
				spawnAmount = 30,
				from = { x = 6761, y = 769, z = 7 },
				to = { x = 6826, y = 862, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Lizard Snakecharmer Raid",
				spawnAmount = 25,
				from = { x = 6761, y = 769, z = 7 },
				to = { x = 6826, y = 862, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Lizard Templar Raid",
				spawnAmount = 25,
				from = { x = 6761, y = 769, z = 7 },
				to = { x = 6826, y = 862, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Fazzrah",
				spawnAmount = 1,
				from = { x = 6769, y = 784, z = 7 },
				to = { x = 6798, y = 794, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Kongra Raid",
				spawnAmount = 35,
				from = { x = 6744, y = 767, z = 7 },
				to = { x = 6822, y = 811, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Merlkin Raid",
				spawnAmount = 35,
				from = { x = 6744, y = 767, z = 7 },
				to = { x = 6822, y = 811, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Sibang Raid",
				spawnAmount = 35,
				from = { x = 6744, y = 767, z = 7 },
				to = { x = 6822, y = 811, z = 7 },
				delayGroup = 2,
				force = true,
			},
		},
	},
	["Kroliki"] = {
		spawnInterval = 200, -- 0.28/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		announcements = {
			{
				delay = 1000,
				message = "Holiday bunnies have swarmed the entire city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 120000,
				message = "Even more rabbits have appeared!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 120000 },
		creatures = {
			{
				name = "Silver Rabbit",
				spawnAmount = 55,
				from = { x = 5801, y = 1475, z = 7 },
				to = { x = 5988, y = 1598, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Silver Rabbit",
				spawnAmount = 65,
				from = { x = 5801, y = 1475, z = 7 },
				to = { x = 5988, y = 1598, z = 7 },
				delayGroup = 2,
				force = false,
			},
		},
	},
	["Jaglak"] = {
		spawnInterval = 10, -- 0.216/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 500,
		announcements = {
			{
				delay = 1000,
				message = "Cyclopes have ordered an extraordinary amount of cereal, perhaps preparing for a visit!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 300000,
				message = "Information about visit to the one-eyed by The Jaglak has been confirmed!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 600000,
				message = "Jaglak has appeared in the vicinity of the southern Cyclops hill!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 600000 },
		creatures = {
			{
				name = "Jaglak",
				spawnAmount = 1,
				position = { x = 5849, y = 1716, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Karakan"] = {
		spawnInterval = 150, -- 0.216/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		announcements = {
			{
				delay = 1000,
				message = "Vermin has once again scattered in the west of MirkoTown!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 120000,
				message = "Toxic bugs are attacking the farms!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 240000,
				message = "Cockroaches are appearing around the farm!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 125000, 245000 },
		creatures = {
			{
				name = "Bug",
				spawnAmount = 150,
				from = { x = 5711, y = 1542, z = 7 },
				to = { x = 5801, y = 1616, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Brimstone Bug Raid",
				spawnAmount = 45,
				from = { x = 5711, y = 1542, z = 7 },
				to = { x = 5801, y = 1616, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Brimstone Bug Raid",
				spawnAmount = 25,
				from = { x = 5711, y = 1542, z = 7 },
				to = { x = 5801, y = 1616, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Karaczan",
				spawnAmount = 7,
				from = { x = 5711, y = 1542, z = 7 },
				to = { x = 5801, y = 1616, z = 7 },
				delayGroup = 3,
				force = true,
			},
		},
	},
	["Gobliny"] = {
		spawnInterval = 500, -- 0.86/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Goblin Raid",
				spawnAmount = 30,
				from = { x = 5894, y = 1678, z = 7 },
				to = { x = 5935, y = 1773, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Goblin Assassin Raid",
				spawnAmount = 18,
				from = { x = 5894, y = 1678, z = 7 },
				to = { x = 5935, y = 1773, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Goblin Scavenger Raid",
				spawnAmount = 15,
				from = { x = 5894, y = 1678, z = 7 },
				to = { x = 5935, y = 1773, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Dryad"] = {
		spawnInterval = 200, -- 0.28/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 3,
		announcements = {
			{
				delay = 1000,
				message = "Dryads are conducting their rituals along the elf fortress.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 15000, 125000 },
		creatures = {
			{
				name = "Forest Fury Raid",
				spawnAmount = 25,
				from = { x = 5915, y = 1817, z = 7 },
				to = { x = 6068, y = 1872, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Dryad",
				spawnAmount = 55,
				from = { x = 5915, y = 1817, z = 7 },
				to = { x = 6068, y = 1872, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Forest Fury Raid",
				spawnAmount = 15,
				from = { x = 5981, y = 1918, z = 7 },
				to = { x = 6073, y = 1954, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Dryad",
				spawnAmount = 35,
				from = { x = 5981, y = 1918, z = 7 },
				to = { x = 6073, y = 1954, z = 7 },
				delayGroup = 2,
				force = true,
			},
		},
	},
	["Wasp"] = {
		spawnInterval = 300, -- 0.72/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		announcements = {
			{
				delay = 1000,
				message = "Enraged bees are buzzing in the east of the city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 120000 },
		creatures = {
			{
				name = "Wasp Raid",
				spawnAmount = 100,
				from = { x = 5969, y = 1498, z = 6 },
				to = { x = 6023, y = 1576, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Willi Wasp",
				spawnAmount = 1,
				from = { x = 5969, y = 1498, z = 6 },
				to = { x = 6023, y = 1576, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Wasp Raid",
				spawnAmount = 90,
				from = { x = 5969, y = 1498, z = 6 },
				to = { x = 6023, y = 1576, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Willi Wasp",
				spawnAmount = 1,
				from = { x = 5969, y = 1498, z = 6 },
				to = { x = 6023, y = 1576, z = 7 },
				delayGroup = 2,
				force = true,
			},
		},
	},
	["Raty"] = {
		spawnInterval = 150, -- 0.3/day
		secondsBetweenRerunning = 18 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		announcements = {
			{
				delay = 1000,
				message = "A plague of rats is spreading through the city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 220000,
				message = "Rats are still emerging from the sewers!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 230000, 420000, 600000 },
		creatures = {
			-- { name="Rat", spawnAmount = 50, from = {x = 5883, y = 1549, z = 7}, to = {x = 5902, y = 1567, z = 7}, delayGroup = 1, force = false },
			{
				name = "Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Cave Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Munster",
				spawnAmount = 1,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Cave Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Cave Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Munster",
				spawnAmount = 1,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 4,
				force = false,
			},
			{
				name = "Cave Rat Raid",
				spawnAmount = 200,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 4,
				force = false,
			},
			{
				name = "Munster",
				spawnAmount = 1,
				from = { x = 5801, y = 1500, z = 4 },
				to = { x = 5973, y = 1610, z = 8 },
				delayGroup = 4,
				force = false,
			},
		},
	},
	["Orki"] = {
		spawnInterval = 220, -- 0.31/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		announcements = {
			{
				delay = 1000,
				message = "Orcs are attacking the city from the south!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 230000,
				message = "Orcs have sent additional reinforcements!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 240000, 280000 },
		creatures = {
			{
				name = "Orc Raid",
				spawnAmount = 30,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Orc Spearman Raid",
				spawnAmount = 30,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Orc Warrior Raid",
				spawnAmount = 30,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Orc Shaman Raid",
				spawnAmount = 30,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Orc Leader Raid",
				spawnAmount = 15,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Orc Raid",
				spawnAmount = 35,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Orc Spearman Raid",
				spawnAmount = 35,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Orc Warrior Raid",
				spawnAmount = 35,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Orc Shaman Raid",
				spawnAmount = 35,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Orc Leader Raid",
				spawnAmount = 35,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Orc Berserker Raid",
				spawnAmount = 35,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Orc Warlord Raid",
				spawnAmount = 20,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Orc Helmet",
				spawnAmount = 1,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Orc Shield",
				spawnAmount = 1,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Orc Armor",
				spawnAmount = 1,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Orc Leader Raid",
				spawnAmount = 8,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Orc Berserker Raid",
				spawnAmount = 8,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Orc Warlord Raid",
				spawnAmount = 8,
				from = { x = 5829, y = 1613, z = 7 },
				to = { x = 5959, y = 1661, z = 7 },
				delayGroup = 3,
				force = false,
			},
		},
	},
	["Old Widow"] = {
		spawnInterval = 200, -- 0.34/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		daySinceStart = 3,
		announcements = {
			{
				delay = 1000,
				message = "Giant spiders have been noticed around the tarantulas' lair!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 10000,
				message = "We advise against going to the hunters' camp!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 360000,
				message = "Braves should try to exterminate the spiders!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 240000, 360000 },
		creatures = {
			{
				name = "Giant Spider Raid",
				spawnAmount = 15,
				from = { x = 5939, y = 1644, z = 7 },
				to = { x = 6039, y = 1712, z = 8 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Tarantula Raid",
				spawnAmount = 20,
				from = { x = 5939, y = 1644, z = 7 },
				to = { x = 6039, y = 1712, z = 8 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Giant Spider Raid",
				spawnAmount = 30,
				from = { x = 5939, y = 1644, z = 7 },
				to = { x = 6039, y = 1712, z = 8 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Tarantula Raid",
				spawnAmount = 40,
				from = { x = 5939, y = 1644, z = 7 },
				to = { x = 6039, y = 1712, z = 8 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "The Old Widow",
				spawnAmount = 1,
				from = { x = 5939, y = 1644, z = 7 },
				to = { x = 6039, y = 1712, z = 8 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Giant Spider Raid",
				spawnAmount = 15,
				from = { x = 5939, y = 1644, z = 7 },
				to = { x = 6039, y = 1712, z = 8 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Tarantula Raid",
				spawnAmount = 20,
				from = { x = 5939, y = 1644, z = 7 },
				to = { x = 6039, y = 1712, z = 8 },
				delayGroup = 3,
				force = true,
			},
		},
	},
	["Malpy"] = {
		spawnInterval = 200, -- 0.34/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		daySinceStart = 2,
		announcements = {
			{
				delay = 1000,
				message = "An increased number of monkeys has been noticed below the Kongo settlement!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 180000,
				message = "Monkeys of focus, commitment, and sheer will are trying to rob Kongo again!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 180000, 320000 },
		creatures = {
			{
				name = "Sibang Raid",
				spawnAmount = 50,
				from = { x = 6900, y = 694, z = 7 },
				to = { x = 6993, y = 767, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Kongra Raid",
				spawnAmount = 50,
				from = { x = 6900, y = 694, z = 7 },
				to = { x = 6993, y = 767, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Merlkin Raid",
				spawnAmount = 50,
				from = { x = 6900, y = 694, z = 7 },
				to = { x = 6993, y = 767, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Hairman the Huge",
				spawnAmount = 1,
				from = { x = 6900, y = 694, z = 7 },
				to = { x = 6993, y = 767, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Sibang Raid",
				spawnAmount = 20,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 6993, y = 816, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Kongra Raid",
				spawnAmount = 20,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 6993, y = 816, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Merlkin Raid",
				spawnAmount = 20,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 6993, y = 816, z = 6 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Sibang Raid",
				spawnAmount = 50,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Kongra Raid",
				spawnAmount = 50,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Merlkin Raid",
				spawnAmount = 50,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Hairman the Huge",
				spawnAmount = 1,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Sibang Raid",
				spawnAmount = 5,
				from = { x = 6970, y = 769, z = 5 },
				to = { x = 6976, y = 791, z = 5 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Kongra Raid",
				spawnAmount = 5,
				from = { x = 6970, y = 769, z = 5 },
				to = { x = 6976, y = 791, z = 5 },
				delayGroup = 2,
				force = false,
			},
			{
				name = "Sibang Raid",
				spawnAmount = 50,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Kongra Raid",
				spawnAmount = 50,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Merlkin Raid",
				spawnAmount = 50,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 3,
				force = false,
			},
			{
				name = "Hairman the Huge",
				spawnAmount = 1,
				from = { x = 6976, y = 749, z = 5 },
				to = { x = 7065, y = 816, z = 6 },
				delayGroup = 3,
				force = true,
			},
		},
	},
	["Ancienty"] = {
		spawnInterval = 220, -- 0.34/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		daySinceStart = 4,
		announcements = {
			{
				delay = 1000,
				message = "Ancient Scarabs surround the desert city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 180000,
				message = "There are more and more Scarabs!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 340000,
				message = "Scarabs have invaded the city!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000, 180000, 340000 },
		creatures = {
			{
				name = "Ancient Scarab Raid",
				spawnAmount = 30,
				from = { x = 6618, y = 1264, z = 7 },
				to = { x = 6670, y = 1378, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Scarab Raid",
				spawnAmount = 50,
				from = { x = 6618, y = 1264, z = 7 },
				to = { x = 6670, y = 1378, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Larva",
				spawnAmount = 60,
				from = { x = 6618, y = 1264, z = 7 },
				to = { x = 6670, y = 1378, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ancient Scarab Raid",
				spawnAmount = 8,
				from = { x = 6740, y = 1259, z = 7 },
				to = { x = 6773, y = 1326, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Scarab Raid",
				spawnAmount = 20,
				from = { x = 6740, y = 1259, z = 7 },
				to = { x = 6773, y = 1326, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Larva",
				spawnAmount = 15,
				from = { x = 6740, y = 1259, z = 7 },
				to = { x = 6773, y = 1326, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ancient Scarab Raid",
				spawnAmount = 25,
				from = { x = 6618, y = 1264, z = 7 },
				to = { x = 6670, y = 1378, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Scarab Raid",
				spawnAmount = 60,
				from = { x = 6618, y = 1264, z = 7 },
				to = { x = 6670, y = 1378, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Larva",
				spawnAmount = 40,
				from = { x = 6618, y = 1264, z = 7 },
				to = { x = 6670, y = 1378, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Ancient Scarab Raid",
				spawnAmount = 15,
				from = { x = 6740, y = 1259, z = 7 },
				to = { x = 6773, y = 1326, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Scarab Raid",
				spawnAmount = 20,
				from = { x = 6740, y = 1259, z = 7 },
				to = { x = 6773, y = 1326, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Larva",
				spawnAmount = 15,
				from = { x = 6740, y = 1259, z = 7 },
				to = { x = 6773, y = 1326, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Ancient Scarab Raid",
				spawnAmount = 45,
				from = { x = 6667, y = 1268, z = 7 },
				to = { x = 6735, y = 1364, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Scarab Raid",
				spawnAmount = 70,
				from = { x = 6667, y = 1268, z = 7 },
				to = { x = 6735, y = 1364, z = 7 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Fleshcrawler",
				spawnAmount = 2,
				from = { x = 6667, y = 1268, z = 7 },
				to = { x = 6735, y = 1364, z = 7 },
				delayGroup = 3,
				force = true,
			},
		},
	},
	["Barbarian"] = {
		spawnInterval = 200, -- 0.34/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		announcements = {
			{
				delay = 1000,
				message = "Barbarians are gathering in their village. It seems they are preparing for something.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 240000,
				message = "A group of barbarians has invaded the surrounding areas!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 120000, 240000 },
		creatures = {
			{
				name = "Barbarian Bloodwalker Raid",
				spawnAmount = 18,
				from = { x = 6450, y = 1739, z = 7 },
				to = { x = 6515, y = 1787, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Barbarian Brutetamer Raid",
				spawnAmount = 18,
				from = { x = 6450, y = 1739, z = 7 },
				to = { x = 6515, y = 1787, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Barbarian Headsplitter Raid",
				spawnAmount = 18,
				from = { x = 6450, y = 1739, z = 7 },
				to = { x = 6515, y = 1787, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Barbarian Skullhunter Raid",
				spawnAmount = 30,
				from = { x = 6450, y = 1739, z = 7 },
				to = { x = 6515, y = 1787, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Barbarian Bloodwalker Raid",
				spawnAmount = 18,
				from = { x = 6502, y = 1783, z = 4 },
				to = { x = 6565, y = 1824, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Barbarian Brutetamer Raid",
				spawnAmount = 18,
				from = { x = 6502, y = 1783, z = 4 },
				to = { x = 6565, y = 1824, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Barbarian Headsplitter Raid",
				spawnAmount = 17,
				from = { x = 6502, y = 1783, z = 4 },
				to = { x = 6565, y = 1824, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Barbarian Skullhunter Raid",
				spawnAmount = 17,
				from = { x = 6502, y = 1783, z = 4 },
				to = { x = 6565, y = 1824, z = 7 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Barbaria",
				spawnAmount = 1,
				from = { x = 6502, y = 1783, z = 4 },
				to = { x = 6565, y = 1824, z = 7 },
				delayGroup = 2,
				force = true,
			},
		},
	},
	["Crystalwolves"] = {
		spawnInterval = 500, -- 0.72/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Crystal Wolf",
				spawnAmount = 8,
				from = { x = 6379, y = 1844, z = 5 },
				to = { x = 6474, y = 1875, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Dragonling"] = {
		spawnInterval = 350, -- 0.5/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Dragonling",
				spawnAmount = 6,
				from = { x = 6531, y = 1721, z = 13 },
				to = { x = 6590, y = 1769, z = 14 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Dragonling2"] = {
		spawnInterval = 350, -- 0.5/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Dragonling",
				spawnAmount = 6,
				from = { x = 5614, y = 1409, z = 12 },
				to = { x = 5711, y = 1494, z = 12 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Walker"] = {
		spawnInterval = 750, -- 0.1/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Walker",
				spawnAmount = 6,
				from = { x = 5728, y = 1160, z = 8 },
				to = { x = 5812, y = 1209, z = 8 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Winterwolves"] = {
		spawnInterval = 350, -- 0.1/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Winter Wolf",
				spawnAmount = 20,
				from = { x = 6531, y = 1827, z = 7 },
				to = { x = 6565, y = 1862, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Icegolem"] = {
		spawnInterval = 250, -- 0.36/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Ice Golem",
				spawnAmount = 4,
				from = { x = 6522, y = 1756, z = 9 },
				to = { x = 6545, y = 1789, z = 9 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ice Golem",
				spawnAmount = 12,
				from = { x = 6545, y = 1738, z = 8 },
				to = { x = 6603, y = 1772, z = 8 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ice Golem",
				spawnAmount = 6,
				from = { x = 6506, y = 1758, z = 8 },
				to = { x = 6525, y = 1798, z = 8 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Hirintror",
				spawnAmount = 1,
				from = { x = 6506, y = 1758, z = 8 },
				to = { x = 6525, y = 1798, z = 8 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ice Golem",
				spawnAmount = 8,
				from = { x = 6529, y = 1789, z = 7 },
				to = { x = 6563, y = 1812, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Shardhead",
				spawnAmount = 1,
				from = { x = 6529, y = 1789, z = 7 },
				to = { x = 6563, y = 1812, z = 7 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ice Golem",
				spawnAmount = 3,
				from = { x = 6541, y = 1802, z = 6 },
				to = { x = 6559, y = 1818, z = 6 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ice Golem",
				spawnAmount = 6,
				from = { x = 6528, y = 1798, z = 5 },
				to = { x = 6562, y = 1813, z = 5 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Ice Golem",
				spawnAmount = 5,
				from = { x = 6548, y = 1796, z = 3 },
				to = { x = 6564, y = 1810, z = 3 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Necropharus3"] = {
		spawnInterval = 220, -- 0.36/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Necropharus",
				spawnAmount = 1,
				position = { x = 6709, y = 1304, z = 12 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Ocyakao"] = {
		spawnInterval = 400, -- 0.57/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Ocyakao",
				spawnAmount = 1,
				position = { x = 6496, y = 1827, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Panda"] = {
		spawnInterval = 1500, -- 1.44/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Panda",
				spawnAmount = 1,
				position = { x = 6597, y = 773, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Panda",
				spawnAmount = 1,
				position = { x = 6593, y = 771, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Panda",
				spawnAmount = 1,
				position = { x = 6593, y = 764, z = 6 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Mole"] = {
		spawnInterval = 1500, -- 1.44/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Mole",
				spawnAmount = 1,
				position = { x = 5915, y = 1825, z = 8 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Mole",
				spawnAmount = 1,
				position = { x = 5917, y = 1813, z = 8 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Mole",
				spawnAmount = 1,
				position = { x = 5926, y = 1815, z = 8 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Rottie"] = {
		spawnInterval = 800, -- 1/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Rottie The Rotworm",
				spawnAmount = 1,
				position = { x = 5992, y = 1550, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Rottie2"] = {
		spawnInterval = 800, -- 1/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Rottie The Rotworm",
				spawnAmount = 1,
				position = { x = 5545, y = 1560, z = 8 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Slug"] = {
		spawnInterval = 1600, -- 2,1/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Slug",
				spawnAmount = 1,
				position = { x = 5642, y = 1664, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Slug",
				spawnAmount = 1,
				position = { x = 5663, y = 1689, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Slug",
				spawnAmount = 1,
				position = { x = 5634, y = 1683, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Slug",
				spawnAmount = 1,
				position = { x = 5678, y = 1668, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Slug",
				spawnAmount = 1,
				position = { x = 5666, y = 1707, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Smuggler_baron_silvertoe"] = {
		spawnInterval = 600, -- 0.86/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Smuggler Baron Silvertoe",
				spawnAmount = 1,
				position = { x = 6054, y = 1400, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Sulphur_Scuttler"] = {
		spawnInterval = 500, -- 0.72/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Sulphur Scuttler",
				spawnAmount = 1,
				position = { x = 6602, y = 1363, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Teleskor"] = {
		spawnInterval = 600, -- 0.86/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Teleskor",
				spawnAmount = 1,
				position = { x = 6064, y = 1565, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["The_Evil_Eye"] = {
		spawnInterval = 300, -- 0.43/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Evil Eye",
				spawnAmount = 1,
				position = { x = 5769, y = 1411, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["The_Handmaiden"] = {
		spawnInterval = 250, -- 0.36/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Handmaiden",
				spawnAmount = 1,
				position = { x = 6087, y = 1844, z = 15 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["The_Imperor"] = {
		spawnInterval = 250, -- 0.36/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Imperor",
				spawnAmount = 1,
				position = { x = 6209, y = 1781, z = 15 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Tiquandas Revenge"] = {
		spawnInterval = 300, -- 0.36/day
		secondsBetweenRerunning = 16 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Tiquandas Revenge",
				spawnAmount = 1,
				position = { x = 6708, y = 590, z = 7 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["The_Many"] = {
		spawnInterval = 250, -- 0.36/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Many",
				spawnAmount = 1,
				position = { x = 6737, y = 637, z = 5 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["The_Old_Widow"] = {
		spawnInterval = 300, -- 0.43/day
		secondsBetweenRerunning = 16 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Old Widow",
				spawnAmount = 1,
				position = { x = 6826, y = 739, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["The_Plasmother"] = {
		spawnInterval = 250, -- 0.46/day
		secondsBetweenRerunning = 16 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Plasmother",
				spawnAmount = 1,
				position = { x = 6147, y = 1890, z = 15 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["The Welter"] = {
		spawnInterval = 150, -- 0.33/day
		secondsBetweenRerunning = 16 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		announcements = {
			{
				delay = 1000,
				message = "A black, three-headed monstrosity has appeared in the forgotten ruins of the jungle!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Welter",
				spawnAmount = 1,
				position = { x = 6686, y = 507, z = 6 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Tromphonyte"] = {
		spawnInterval = 300, -- 0.45/day
		secondsBetweenRerunning = 16 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Tromphonyte",
				spawnAmount = 1,
				position = { x = 5962, y = 1164, z = 8 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Tyrn"] = {
		spawnInterval = 200, -- 0.45/day
		secondsBetweenRerunning = 16 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Tyrn",
				spawnAmount = 1,
				position = { x = 6628, y = 585, z = 4 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Tyrn2"] = {
		spawnInterval = 200, -- 0.45/day
		secondsBetweenRerunning = 16 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Tyrn",
				spawnAmount = 1,
				position = { x = 6406, y = 1263, z = 3 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Undead_Cavebear"] = {
		spawnInterval = 1500, -- 1.44/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 5809, y = 1045, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 5797, y = 1020, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 5843, y = 1049, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 6237, y = 1286, z = 9 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 6246, y = 1263, z = 9 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 6270, y = 1276, z = 9 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 6250, y = 1296, z = 9 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 6240, y = 1276, z = 10 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Xenia"] = {
		spawnInterval = 400, -- 0.45/day
		secondsBetweenRerunning = 18 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Xenia",
				spawnAmount = 1,
				position = { x = 5708, y = 1510, z = 4 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Yaga_the_Crone"] = {
		spawnInterval = 400, -- 0.72/day
		secondsBetweenRerunning = 18 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Yaga the Crone",
				spawnAmount = 1,
				position = { x = 6018, y = 1790, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Zulazza"] = {
		spawnInterval = 180, -- 0.28/day
		secondsBetweenRerunning = 24 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		announcements = {
			{
				delay = 1000,
				message = "Lizardmen are trying to summon their ruler in their village!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 360000,
				message = "The Right Hand of the Lizard Ruler has already arrived in their village!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 720000,
				message = "The Highest Ruler of the lizardmen has been summoned to their tower!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 360000, 720000 },
		creatures = {
			{
				name = "Chizzoron the Distorter",
				spawnAmount = 1,
				position = { x = 6440, y = 910, z = 4 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Zulazza the Corruptor",
				spawnAmount = 1,
				position = { x = 6438, y = 918, z = 1 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Arachir_The_Ancient_One"] = {
		spawnInterval = 300, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Arachir The Ancient One",
				spawnAmount = 1,
				position = { x = 6141, y = 848, z = 5 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Bane_Lord"] = {
		spawnInterval = 250, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Bane Lord",
				spawnAmount = 1,
				position = { x = 6094, y = 1051, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Barbaria"] = {
		spawnInterval = 330, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Barbaria",
				spawnAmount = 1,
				position = { x = 6471, y = 1764, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Black_sheep"] = {
		spawnInterval = 1600, -- 1.44/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Black sheep",
				spawnAmount = 1,
				position = { x = 5534, y = 1593, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Black sheep",
				spawnAmount = 1,
				position = { x = 5543, y = 1580, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Black sheep",
				spawnAmount = 1,
				position = { x = 5538, y = 1586, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Countess_Sorrow"] = {
		spawnInterval = 330, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Countess Sorrow",
				spawnAmount = 1,
				position = { x = 6116, y = 1938, z = 15 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Crustacea_Gigantica"] = {
		spawnInterval = 1600, -- 1.44/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Crustacea Gigantica",
				spawnAmount = 1,
				position = { x = 6701, y = 1071, z = 9 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Crustacea Gigantica",
				spawnAmount = 1,
				position = { x = 6722, y = 1066, z = 9 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Crustacea Gigantica",
				spawnAmount = 1,
				position = { x = 6694, y = 1077, z = 8 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Demodras"] = {
		spawnInterval = 180, -- 0.36/day
		secondsBetweenRerunning = 18 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Demodras",
				spawnAmount = 1,
				from = { x = 5846, y = 1342, z = 3 },
				to = { x = 5877, y = 1369, z = 3 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Dragon Lord",
				spawnAmount = 12,
				from = { x = 5846, y = 1342, z = 3 },
				to = { x = 5877, y = 1369, z = 3 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Demodras2"] = {
		spawnInterval = 180, -- 0.36/day
		secondsBetweenRerunning = 18 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Demodras",
				spawnAmount = 1,
				from = { x = 6702, y = 1117, z = 8 },
				to = { x = 6727, y = 1140, z = 8 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Dragon Lord",
				spawnAmount = 12,
				from = { x = 6702, y = 1117, z = 8 },
				to = { x = 6727, y = 1140, z = 8 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Dharalion"] = {
		spawnInterval = 350, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Dharalion",
				spawnAmount = 1,
				position = { x = 5739, y = 1663, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Dracola"] = {
		spawnInterval = 300, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Dracola",
				spawnAmount = 1,
				position = { x = 6139, y = 1875, z = 15 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Dreadmaw"] = {
		spawnInterval = 500, -- 0.72/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Dreadmaw",
				spawnAmount = 1,
				position = { x = 6454, y = 973, z = 8 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Ekatrix"] = {
		spawnInterval = 400, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Ekatrix",
				spawnAmount = 1,
				position = { x = 5667, y = 1742, z = 4 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Fernfang"] = {
		spawnInterval = 400, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Fernfang",
				spawnAmount = 1,
				position = { x = 5730, y = 1522, z = 14 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Ferumbras"] = {
		spawnInterval = 110, -- 0.16/day
		secondsBetweenRerunning = 40 * 60 * 60, -- 40 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		daySinceStart = 3,
		announcements = {
			{
				delay = 1000,
				message = "Demonic shrieks emanate from the underground near the wizards' village.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 360000,
				message = "Wizards in their underground academy are performing a summoning ceremony for their former Master.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 720000,
				message = "Ferumbras has been summoned at the wizards' academy! Stop him before it's too late!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 720000 },
		creatures = {
			{
				name = "Ferumbras",
				spawnAmount = 1,
				position = { x = 6112, y = 1324, z = 14 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Gochabaal"] = {
		spawnInterval = 140, -- 0.16/day
		secondsBetweenRerunning = 40 * 60 * 60, -- 40 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		daySinceStart = 3,
		announcements = {
			{
				delay = 1000,
				message = "Terrible wails are echoing from the depths of the volcano, north of Mirko Town.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 600000,
				message = "Gochabaal is trying to return from the underworld! Demons have appeared on the volcano above Mirko Town.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 1200000,
				message = "Gochabaal has returned from the depths of hell! A group of heroes should try to stop him before it's too late...",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 600000, 1200000 },
		creatures = {
			{
				name = "Demon",
				spawnAmount = 6,
				from = { x = 5865, y = 1327, z = 3 },
				to = { x = 5901, y = 1368, z = 4 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Demon",
				spawnAmount = 7,
				from = { x = 5865, y = 1327, z = 3 },
				to = { x = 5901, y = 1368, z = 4 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Gochabaal",
				spawnAmount = 1,
				position = { x = 5875, y = 1332, z = 4 },
				delayGroup = 2,
				force = true,
			},
		},
	},
	--[[["Ferumbras"] = {
		spawnInterval = 110, -- 0.16/day
        secondsBetweenRerunning = 24*60*60,-- 24 hours
        secondsBetweenOtherRaids = 9*60,-- 15 min
        minPlayersOnline = 5,
		announcements = {
            { delay = 1000, message = "Demonic shrieks emanate from the underground near the wizards' village.", broadcastType = MESSAGE_EVENT_ADVANCE},
			{ delay = 360000, message = "Wizards in their underground academy are performing a summoning ceremony for their former Master.", broadcastType = MESSAGE_EVENT_ADVANCE},
			{ delay = 720000, message = "Ferumbras has been summoned at the wizards' academy! Stop him before it's too late!", broadcastType = MESSAGE_EVENT_ADVANCE},
        },
        delayGroups = {
            20000,
        },
        creatures = {
			{ name="Ferumbras", spawnAmount = 1, position = {x = 5876, y = 1556, z = 7}, delayGroup = 1, force = true },
        },
    },]]
	["Fleshcrawler"] = {
		spawnInterval = 300, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Fleshcrawler",
				spawnAmount = 1,
				position = { x = 6572, y = 1248, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Furyosa"] = {
		spawnInterval = 120, -- 0.17/day
		secondsBetweenRerunning = 24 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 4,
		announcements = {
			{
				delay = 1000,
				message = "Furyosa has haunted the underground city of Souleaters!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 60000 },
		creatures = {
			{
				name = "Furyosa",
				spawnAmount = 1,
				position = { x = 6258, y = 917, z = 11 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Fury",
				spawnAmount = 15,
				from = { x = 6213, y = 898, z = 11 },
				to = { x = 6265, y = 931, z = 11 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Ghazbaran"] = {
		spawnInterval = 120, -- 0.17/day
		secondsBetweenRerunning = 40 * 60 * 60, -- 40 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		daySinceStart = 4,
		announcements = {
			{
				delay = 1000,
				message = "Primordial evil is awakening deep in the mines of Siberia.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 600000,
				message = "Demonic entities begin to appear in the deepest mines of Siberia.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 1200000,
				message = "The Demonic Master has revealed himself in the mines of Siberia.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 800000, 900000, 1000000, 1100000, 1200000 },
		creatures = {
			{
				name = "Ghazbaran",
				spawnAmount = 1,
				position = { x = 6436, y = 1734, z = 14 },
				delayGroup = 5,
				force = true,
			},
			{
				name = "Deathslicer",
				spawnAmount = 12,
				from = { x = 6421, y = 1722, z = 14 },
				to = { x = 6449, y = 1741, z = 14 },
				delayGroup = 1,
				force = true,
			},
			{
				name = "Juggernaut",
				spawnAmount = 1,
				from = { x = 6421, y = 1722, z = 14 },
				to = { x = 6449, y = 1741, z = 14 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Fury",
				spawnAmount = 1,
				from = { x = 6421, y = 1722, z = 14 },
				to = { x = 6449, y = 1741, z = 14 },
				delayGroup = 3,
				force = true,
			},
			{
				name = "Demon",
				spawnAmount = 1,
				from = { x = 6421, y = 1722, z = 14 },
				to = { x = 6449, y = 1741, z = 14 },
				delayGroup = 4,
				force = true,
			},
		},
	},
	["Grand_Mother_Foulscale"] = {
		spawnInterval = 400, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Grand Mother Foulscale",
				spawnAmount = 1,
				position = { x = 5875, y = 1334, z = 4 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Grand_Mother_Foulscale2"] = {
		spawnInterval = 400, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Grand Mother Foulscale",
				spawnAmount = 1,
				position = { x = 6671, y = 591, z = 6 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Grorlam"] = {
		spawnInterval = 450, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Grorlam",
				spawnAmount = 1,
				position = { x = 6794, y = 1241, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Hatebreeder"] = {
		spawnInterval = 250, -- 0.36/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Hatebreeder",
				spawnAmount = 1,
				position = { x = 6674, y = 928, z = 11 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Hide"] = {
		spawnInterval = 400, -- 0.45/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Hide",
				spawnAmount = 1,
				position = { x = 6826, y = 739, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Ladybug"] = {
		spawnInterval = 1600, -- 0.45/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Ladybug",
				spawnAmount = 1,
				position = { x = 6614, y = 783, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Ladybug",
				spawnAmount = 1,
				position = { x = 6625, y = 770, z = 7 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Ladybug",
				spawnAmount = 1,
				position = { x = 6637, y = 784, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Man_in_the_Cave"] = {
		spawnInterval = 300, -- 0.45/day
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Man in the Cave",
				spawnAmount = 1,
				position = { x = 6531, y = 1778, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Manta Ray"] = {
		spawnInterval = 1600, -- 0.45/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Manta Ray",
				spawnAmount = 1,
				position = { x = 6493, y = 743, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Manta Ray",
				spawnAmount = 1,
				position = { x = 6511, y = 746, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Manta Ray",
				spawnAmount = 1,
				position = { x = 6485, y = 728, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Manta Ray",
				spawnAmount = 1,
				position = { x = 6510, y = 728, z = 10 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Massacre"] = {
		spawnInterval = 250, -- 0.45/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 15 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Massacre",
				spawnAmount = 1,
				position = { x = 6170, y = 1832, z = 15 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Midnight_Panther"] = {
		spawnInterval = 1600, -- 0.45/day
		secondsBetweenRerunning = 2 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Midnight Panther",
				spawnAmount = 1,
				position = { x = 6673, y = 943, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Midnight Panther",
				spawnAmount = 1,
				position = { x = 6668, y = 939, z = 10 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Midnight Panther",
				spawnAmount = 1,
				position = { x = 6680, y = 916, z = 10 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Morgaroth"] = {
		spawnInterval = 130, -- 0.31/day
		secondsBetweenRerunning = 40 * 60 * 60, -- 40 hours
		secondsBetweenOtherRaids = 15 * 60, -- 15 min
		minPlayersOnline = 5,
		daySinceStart = 3,
		announcements = {
			{
				delay = 1000,
				message = "Strange footsteps can be heard in the north of the desert.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 360000,
				message = "The presence of mythical evil can be sensed near the extinct volcano in the desert.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 720000,
				message = "Morgaroth has activated the volcano and revealed himself in its depths!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 360000, 720000 },
		creatures = {
			{
				name = "Morgaroth",
				spawnAmount = 1,
				position = { x = 6728, y = 1158, z = 10 },
				delayGroup = 2,
				force = true,
			},
			{
				name = "Demon",
				spawnAmount = 7,
				from = { x = 6713, y = 1143, z = 10 },
				to = { x = 6749, y = 1173, z = 10 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Mr_Punish"] = {
		spawnInterval = 250, -- 0.45/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 15 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Mr. Punish",
				spawnAmount = 1,
				position = { x = 6065, y = 1809, z = 15 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Necropharus"] = {
		spawnInterval = 220, -- 0.46/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 15 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Necropharus",
				spawnAmount = 1,
				position = { x = 6077, y = 1569, z = 12 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Necropharus2"] = {
		spawnInterval = 220, -- 0.46/day
		secondsBetweenRerunning = 12 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 15 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Necropharus",
				spawnAmount = 1,
				position = { x = 5698, y = 1446, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Feroxa"] = {
		spawnInterval = 150, -- 0.31/day
		secondsBetweenRerunning = 24 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 15 * 60, -- 15 min
		minPlayersOnline = 5,
		announcements = {
			{
				delay = 1000,
				message = "The unrest fills the air around the steppes...",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 30000,
				message = "Werewolves are trying to summon their Queen regent!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
			{
				delay = 60000,
				message = "Feroxa has appeared in the werewolf's underground!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 60000 },
		creatures = {
			{
				name = "Feroxa",
				spawnAmount = 1,
				position = { x = 6228, y = 1107, z = 8 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["Weakened_Shlorg"] = {
		spawnInterval = 300, -- 0.31/day
		secondsBetweenRerunning = 18 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 15 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "weakened shlorg",
				spawnAmount = 1,
				position = { x = 6697, y = 849, z = 13 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Supply 1"] = {
		spawnInterval = 450, -- 0.46/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 1 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Supply Dragon",
				spawnAmount = 1,
				from = { x = 5738, y = 1295, z = 6 },
				to = { x = 6114, y = 1952, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Supply 2"] = {
		spawnInterval = 450, -- 0.46/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 1 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Supply Dragon",
				spawnAmount = 1,
				from = { x = 6519, y = 1067, z = 7 },
				to = { x = 6939, y = 1414, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Supply 3"] = {
		spawnInterval = 450, -- 0.46/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 1 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Supply Dragon",
				spawnAmount = 1,
				from = { x = 6484, y = 579, z = 7 },
				to = { x = 6966, y = 821, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Supply 4"] = {
		spawnInterval = 450, -- 0.46/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 1 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Supply Dragon",
				spawnAmount = 1,
				from = { x = 5984, y = 1006, z = 7 },
				to = { x = 6329, y = 1297, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Supply 5"] = {
		spawnInterval = 450, -- 0.46/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 1 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Supply Dragon",
				spawnAmount = 1,
				from = { x = 6143, y = 823, z = 7 },
				to = { x = 6542, y = 1105, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Supply 6"] = {
		spawnInterval = 450, -- 0.46/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 1 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Supply Dragon",
				spawnAmount = 1,
				from = { x = 6380, y = 1731, z = 7 },
				to = { x = 6597, y = 1911, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Pinata 1"] = {
		spawnInterval = 700, -- 0.46/day
		secondsBetweenRerunning = 4 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 1 * 60, -- 15 min
		minPlayersOnline = 0,
		delayGroups = { 1000 },
		creatures = {
			{
				name = "Pinata Dragon",
				spawnAmount = 2,
				from = { x = 5738, y = 1295, z = 7 },
				to = { x = 6114, y = 1952, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Gaz'haragoth"] = {
		spawnInterval = 110, -- 0.16/day
		secondsBetweenRerunning = 44 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 5,
		daySinceStart = 6,
		announcements = {
			{
				delay = 1000,
				message = "Gaz'haragoth will shatter your dreams in a barrage of nightmares!",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000 },
		creatures = {
			{
				name = "gaz'haragoth",
				spawnAmount = 1,
				position = { x = 6136, y = 700, z = 12 },
				delayGroup = 1,
				force = true,
			},
		},
	},
	["The_Bloodweb"] = {
		spawnInterval = 300, -- 0.45/day
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The Bloodweb",
				spawnAmount = 1,
				position = { x = 6558, y = 1744, z = 8 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Midnight_Spawn"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Midnight Spawn",
				spawnAmount = 1,
				position = { x = 7571, y = 1001, z = 6 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Shadow_Hound"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Shadow_Hound",
				spawnAmount = 1,
				position = { x = 6404, y = 1949, z = 8 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Bane_of_Light"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Bane of Light",
				spawnAmount = 1,
				position = { x = 7674, y = 1407, z = 7 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["The_old_Widow"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "The old Widow",
				spawnAmount = 1,
				position = { x = 7375, y = 1661, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Undead_Cavebear2"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Undead Cavebear",
				spawnAmount = 1,
				position = { x = 7507, y = 1706, z = 11 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Bane_Bringer"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Bane Bringer",
				spawnAmount = 1,
				position = { x = 7599, y = 1693, z = 9 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Doomsday_Cultist"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Doomsday Cultist",
				spawnAmount = 1,
				position = { x = 7715, y = 1661, z = 11 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Acolyte_of_Darkness"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Acolyte of Darkness",
				spawnAmount = 1,
				position = { x = 7580, y = 1795, z = 11 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Nightslayer"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Nightslayer",
				spawnAmount = 1,
				position = { x = 7431, y = 1830, z = 10 },
				delayGroup = 1,
				force = false,
			},
		},
	},
	["Mad_Mage_and_Servants"] = {
		spawnInterval = 450,
		secondsBetweenRerunning = 3 * 60 * 60, -- 24 hours
		secondsBetweenOtherRaids = 9 * 60, -- 15 min
		minPlayersOnline = 1,
		announcements = {
			{
				delay = 1000,
				message = "The Mad Mage has been sighted sneaking into his lair located in the deep underground on the east of Orshaawa.",
				broadcastType = MESSAGE_EVENT_ADVANCE,
			},
		},
		delayGroups = { 10000 },
		creatures = {
			{
				name = "Mad Mage",
				spawnAmount = 1,
				position = { x = 7644, y = 1790, z = 11 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Iron Servant",
				spawnAmount = 1,
				position = { x = 7632, y = 1736, z = 12 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Iron Servant",
				spawnAmount = 1,
				position = { x = 7640, y = 1756, z = 12 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Golden Servant",
				spawnAmount = 1,
				position = { x = 7628, y = 1759, z = 11 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Golden Servant",
				spawnAmount = 1,
				position = { x = 7626, y = 1779, z = 11 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Diamond Servant",
				spawnAmount = 1,
				position = { x = 7653, y = 1782, z = 11 },
				delayGroup = 1,
				force = false,
			},
			{
				name = "Diamond Servant",
				spawnAmount = 1,
				position = { x = 7650, y = 1793, z = 11 },
				delayGroup = 1,
				force = false,
			},
		},
	},
}

-- Dont edit anything below.
local ranLuaRaids = {} -- [1]={ name = "intiri_swamp_raid", startTime = os.time(), creatures = { cid, cid, cid, cid }, despawnEvent = event }

LUA_RAIDS_CHANCE = {
	lastRaidTime = 0,
	raidIntervalToCheckFirst = 1, -- randomly generated, so always check different raid first
	raids = {},
}
local luaRaidsAttemptsToFindValidTileToSpawnCreature = 10

for raidName, _ in pairs(LUA_RAID_CONFIG) do
	if LUA_RAID_CONFIG[raidName].spawnInterval ~= nil then
		LUA_RAIDS_CHANCE.raids[#LUA_RAIDS_CHANCE.raids + 1] = {
			name = raidName,
			spawnInterval = LUA_RAID_CONFIG[raidName].spawnInterval,
		}
	end
end

local function delayedBroadcast(message, broadcastType, translate)
	if broadcastType == nil then
		Game.broadcastMessage(message, MESSAGE_STATUS_WARNING, translate)
	else
		Game.broadcastMessage(message, broadcastType, translate)
	end
end

local function delayedRaidDespawn(raidIndex)
	if ranLuaRaids[raidIndex] == nil then
		print(
			"delayedRaidDespawn() Error: raidIndex of "
				.. raidIndex
				.. " in ranLuaRaids is nil. If you reloaded global ignore this."
		)
		return false
	end
	for creaturesIndex = 1, #ranLuaRaids[raidIndex].creatures do
		local creature = Creature(ranLuaRaids[raidIndex].creatures[creaturesIndex])
		if creature ~= nil then
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			creature:remove()
		end
	end
end

local function spawnCreatureInArea(creatureArr)
	local foundTile = nil
	local forcingSpawnEnabled = false
	local resultCreature = nil
	for findTileTries = 1, luaRaidsAttemptsToFindValidTileToSpawnCreature * 2 do
		foundTile = Tile(
			math.random(creatureArr.from.x, creatureArr.to.x),
			math.random(creatureArr.from.y, creatureArr.to.y),
			math.random(creatureArr.from.z, creatureArr.to.z)
		)

		if
			foundTile ~= nil
			and foundTile:getGround() ~= nil
			and not foundTile:hasProperty(TILESTATE_NONE)
			and not foundTile:hasProperty(TILESTATE_PROTECTIONZONE)
			and (foundTile:getCreatureCount() == 0 or forcingSpawnEnabled)
		then
			if creatureArr.npc == nil or creatureArr.npc == false then
				resultCreature =
					Game.createMonster(creatureArr.name, foundTile:getPosition(), false, forcingSpawnEnabled)
			else
				resultCreature = Game.createNpc(creatureArr.name, foundTile:getPosition(), false, forcingSpawnEnabled)
			end
			if resultCreature ~= nil then
				return resultCreature
			end
		end
		if findTileTries > luaRaidsAttemptsToFindValidTileToSpawnCreature then
			if creatureArr.force then
				forcingSpawnEnabled = true
			else
				break
			end
		end
	end
end

local function spawnRaidGroup(raidName, raidIndex, delayGroup)
	if ranLuaRaids[raidIndex] == nil then
		print(
			"spawnRaidGroup() Error: raidIndex of "
				.. raidIndex
				.. " in ranLuaRaids is nil. If you reloaded global ignore this."
		)
		return false
	end
	for creaturesIndex = 1, #LUA_RAID_CONFIG[raidName].creatures do
		if LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].delayGroup == delayGroup then
			-- Monster
			if
				LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].npc == nil
				or LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].npc == false
			then
				if LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].spawnAmount == nil then
					LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].spawnAmount = 1
				end

				for monsterSpawnLoopIndex = 1, LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].spawnAmount do
					local monster = nil
					if LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].from ~= nil then
						monster = spawnCreatureInArea(LUA_RAID_CONFIG[raidName].creatures[creaturesIndex])
					else
						local position = Position(
							LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].position.x,
							LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].position.y,
							LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].position.z
						)
						if position then
							monster = Game.createMonster(
								LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].name,
								position,
								false,
								LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].force
							)
						end
					end

					if monster ~= nil then
						monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						ranLuaRaids[raidIndex].creatures[#ranLuaRaids[raidIndex].creatures + 1] = monster:getId()
					else
						-- print("spawnRaidGroup() Monster not created: " .. luaRaids[raidName].creatures[creaturesIndex].name ..
						--    " for raid " .. raidName .. " at creatureIndex " .. creaturesIndex)
					end
				end
			else -- NPC
				local npc = nil
				if LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].from ~= nil then
					npc = spawnCreatureInArea(LUA_RAID_CONFIG[raidName].creatures[creaturesIndex])
				else
					local position = Position(
						LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].position.x,
						LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].position.y,
						LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].position.z
					)
					if position then
						npc = Game.createNpc(
							LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].name,
							position,
							false,
							forceSpawn
						)
					end
				end

				if npc ~= nil then
					npc:setMasterPos(npc:getPosition())
					npc:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					ranLuaRaids[raidIndex].creatures[#ranLuaRaids[raidIndex].creatures + 1] = npc:getId()
				else
					print(
						"spawnRaidGroup() Error: Could not spawn NPC "
							.. LUA_RAID_CONFIG[raidName].creatures[creaturesIndex].name
							.. " for raid "
							.. raidName
							.. " at creatureIndex "
							.. creaturesIndex
					)
				end
			end
		end
	end
end

function StartRaid(raidName)
	local chosenRaid = LUA_RAID_CONFIG[raidName]
	if not chosenRaid then
		print(debug.traceback("Cannot start raid with name: " .. raidName .. ". This raid does not exist."))
		return
	end

	chosenRaid.lastRunTime = os.time()
	LUA_RAIDS_CHANCE.lastRaidTime = os.time()
	local newRaidIndex = #ranLuaRaids + 1
	ranLuaRaids[newRaidIndex] = {
		name = raidName,
		startTime = os.time(),
		creatures = {},
	}

	-- despawn
	if LUA_RAID_CONFIG[raidName].msDespawnDelay ~= nil then
		ranLuaRaids[newRaidIndex].despawnEvent =
			addEvent(delayedRaidDespawn, LUA_RAID_CONFIG[raidName].msDespawnDelay, newRaidIndex)
	end

	-- announcements
	if chosenRaid.announcements then
		for _, announcement in pairs(chosenRaid.announcements) do
			addEvent(delayedBroadcast, announcement.delay, announcement.message, announcement.broadcastType, true)
		end
	end

	-- delayGroups
	if chosenRaid.delayGroups then
		for index, delayGroups in ipairs(chosenRaid.delayGroups) do
			addEvent(spawnRaidGroup, delayGroups, raidName, newRaidIndex, index)
		end
	end

	spawnRaidGroup(raidName, newRaidIndex, nil)
	return newRaidIndex
end
