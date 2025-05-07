local raidData = {
	LuaRaid("Ancient_Spawn_Of_Morgathla"):Context({
		perday = 0.1872,
		waves = {
			Wave(60 * 5):creature("Ancient Spawn Of Morgathla", Area(Position(6581, 1341, 9), Position(6581, 1341, 9)), 1, true):Notification(-60 * 5, "Morgathla sent her legate to inspect the breeding grounds."):Notification(-1, "Ancient Spawn of Morgathla is present in ancient scarab caves."),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("DjinnHurghada"):Context({
		perday = 0.2,
		waves = {
			Wave(60):creature("Green Djinn", Area(Position(6516, 1211, 7), Position(6550, 1231, 7)), 10):creature("Blue Djinn", Area(Position(6516, 1211, 7), Position(6550, 1231, 7)), 10):Notification(-60, "The brotherhoods of the blue and green Djinns are organizing Islamic harvest festivals near their palaces. Be careful, they do not tolerate infidels."),
			Wave(60 * 5)
				:creature("Green Djinn", Area(Position(6589, 1234, 7), Position(6628, 1262, 7)), 12)
				:creature("Blue Djinn", Area(Position(6589, 1234, 7), Position(6628, 1262, 7)), 12)
				:creature("Marid", Area(Position(6589, 1234, 7), Position(6628, 1262, 7)), 3)
				:creature("Efreet", Area(Position(6589, 1234, 7), Position(6628, 1262, 7)), 3)
				:Notification(-30, "Hordes of Djinns have arrived at the festival. Caution! They won't let anyone through who doesn't worship the Great Allah or secure them a visa to Germany!"),
			Wave(60 * 10)
				:creature("Marid", Area(Position(6656, 1285, 7), Position(6705, 1332, 7)), 15)
				:creature("Efreet", Area(Position(6656, 1285, 7), Position(6705, 1332, 7)), 15)
				:Notification(-30, "Alarm! Powerful leaders of the Caliphate (Marid + Efreet) are joining the desert party and are looking for a fight. Hurghada is being evacuated — will there be any brave souls to stop the terror of the Djinnhad?"),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("WorkerGolemsMirkoNorth"):Context({
		perday = 0.2,
		waves = {
			Wave(60):creature("Worker golem", Area(Position(5899, 1401, 7), Position(5906, 1415, 7)), 5):Notification(-60, "Loud tremors can be heard from the salt mine north of Mirko Town. Rumor has it that the golem working class has started a rebellion against the city authorities over the lack of a 15th paycheck."),
			Wave(60 * 3):creature("Worker golem", Area(Position(5891, 1417, 7), Position(5909, 1423, 7)), 6):creature("War golem", Area(Position(5891, 1417, 7), Position(5909, 1423, 7)), 1):Notification(-30, "The enraged golems have emerged from the depths. We strongly advise all citizens to avoid the vicinity of the mine — this uprising will not stop at burning tires. Flying boulders are imminent."),
			Wave(60 * 8):creature("Worker golem", Area(Position(5892, 1420, 7), Position(5910, 1427, 7)), 9):creature("War golem", Area(Position(5892, 1420, 7), Position(5910, 1427, 7)), 2):Notification(-30, "The jokes are over — deadly war golems have joined the rebellion. Fight or flee, unless you want to be stoned to death!"),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("AmazonsKnurowo"):Context({
		perday = 0.2,
		waves = {
			Wave(60):creature("Amazon", Area(Position(5532, 1539, 7), Position(5569, 1578, 7)), 8):creature("Valkyrie", Area(Position(5532, 1539, 7), Position(5569, 1578, 7)), 5):Notification(-30, "Knurowo is in trouble! A band of Amazons has attacked the town in search of breeding bulls and women's lingerie. Residents are barricading themselves in their homes — someone, please help them!"),
			Wave(60 * 4):creature("Amazon", Area(Position(5532, 1539, 7), Position(5569, 1578, 7)), 14):creature("Valkyrie", Area(Position(5532, 1539, 7), Position(5569, 1578, 7)), 7),
			Wave(60 * 7):creature("Amazon", Area(Position(5532, 1539, 7), Position(5569, 1578, 7)), 19):creature("Valkyrie", Area(Position(5532, 1539, 7), Position(5569, 1578, 7)), 14),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("NomadsHurghada"):Context({
		perday = 0.2,
		waves = {
			Wave(60 * 2)
				:creature("Nomad", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 10)
				:creature("Nomad Blue", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 10)
				:creature("Nomad Female", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 10)
				:creature("Smuggler", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 5)
				:Notification(-60 * 2, "Shitskins are storming the border fence, abducting women to take them to Dubai. The pyramid of the Hurghada are in grave danger!"),
			Wave(60 * 5)
				:creature("Crypt Defiler", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 10)
				:creature("Grave Robber ", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 10)
				:creature("Nomad", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 20)
				:creature("Nomad Female", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 20)
				:creature("Nomad Blue", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 20)
				:creature("Hunter", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 5)
				:creature("Bandit", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 8)
				:creature("Gang Member", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 5)
				:creature("Assassin", Area(Position(6769, 1268, 7), Position(6839, 1335, 7)), 3)
				:Notification(-30, "Borderland nomads are blessing the pyramids with their so-called cultural enrichment. This is hybrid warfare!"),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("ChakoyaSyberia"):Context({
		perday = 0.2,
		waves = {
			Wave(60 * 3)
				:creature("Ocyakao", Area(Position(6432, 1796, 7), Position(6402, 1846, 7)), 1)
				:creature("Chakoya Windcaller", Area(Position(6432, 1796, 7), Position(6402, 1846, 7)), 11)
				:creature("Chakoya Toolshaper", Area(Position(6432, 1796, 7), Position(6402, 1846, 7)), 14)
				:creature("Chakoya Tribewarden", Area(Position(6432, 1796, 7), Position(6402, 1846, 7)), 22)
				:creature("Dwarf Soldier", Area(Position(6432, 1796, 7), Position(6402, 1846, 7)), 5)
				:creature("Dwarf Guard  ", Area(Position(6432, 1796, 7), Position(6402, 1846, 7)), 8)
				:Notification(-60 * 3, "The Fur Gang in Siberia has launched Operation Degeneration at the Dwarf camp near the mine. A bloody massacre is guaranteed."),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Supply_1"):Context({
		perDay = 0.648,
		waves = {
			Wave(1000):creature("Supply Dragon", Area(Position(5738, 1295, 6), Position(6114, 1952, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Gobliny"):Context({
		perDay = 0.72,
		waves = {
			Wave(10000):creature("Goblin", Area(Position(5894, 1678, 7), Position(5935, 1773, 7)), 30, true):creature("Goblin Assassin", Area(Position(5894, 1678, 7), Position(5935, 1773, 7)), 18, true):creature("Goblin Scavenger", Area(Position(5894, 1678, 7), Position(5935, 1773, 7)), 15, true),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Countess_Sorrow"):Context({
		perDay = 0.4752,
		waves = {
			Wave(10000):creature("Countess Sorrow", Area(Position(6116, 1938, 15), Position(6116, 1938, 15)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Bane_of_Light"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000):creature("Bane of Light", Area(Position(7674, 1407, 7), Position(7674, 1407, 7)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Dreadmaw"):Context({
		perDay = 0.72,
		waves = {
			Wave(10000):creature("Dreadmaw", Area(Position(6454, 973, 8), Position(6454, 973, 8)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_Welter"):Context({
		perDay = 0.216,
		waves = {
			Wave(10000):creature("The Welter", Area(Position(6686, 507, 6), Position(6686, 507, 6)), 1, true):Notification(-9000, "A black, three-headed monstrosity has appeared in the forgotten ruins of the jungle!"),
		},
		cooldown = 57600,
		minPlayersOnline = 1,
	}),
	LuaRaid("Horestis"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("Horestis", Area(Position(6573, 1454, 7), Position(6573, 1454, 7)), 1, false),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Tyrn"):Context({
		perDay = 0.8,
		waves = {
			Wave(10000):creature("Tyrn", Area(Position(6628, 585, 4), Position(6628, 585, 4)), 1, false),
		},
		cooldown = 57600,
		minPlayersOnline = 1,
	}),
	LuaRaid("Ribstride"):Context({
		perDay = 1.5,
		waves = {
			Wave(10000):creature("Bonebeast", Area(Position(6905, 1232, 7), Position(6966, 1279, 7)), 35, true):creature("Ribstride", Area(Position(6905, 1232, 7), Position(6966, 1279, 7)), 1, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Sulphur_Scuttler"):Context({
		perDay = 0.72,
		waves = {
			Wave(10000):creature("Sulphur Scuttler", Area(Position(6602, 1363, 9), Position(6602, 1363, 9)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Ghazbaran"):Context({
		perDay = 0.1728,
		waves = {
			Wave(800000):creature("Deathslicer", Area(Position(6421, 1722, 14), Position(6449, 1741, 14)), 12, true):Notification(-799000, "Primordial evil is awakening deep in the mines of Siberia."):Notification(-200000, "Demonic entities begin to appear in the deepest mines of Siberia."),
			Wave(900000):creature("Juggernaut", Area(Position(6421, 1722, 14), Position(6449, 1741, 14)), 1, true):Notification(-1, "Demonic entities begin to appear in the deepest mines of Siberia."),
			Wave(1000000):creature("Fury", Area(Position(6421, 1722, 14), Position(6449, 1741, 14)), 1, true),
			Wave(1100000):creature("Demon", Area(Position(6421, 1722, 14), Position(6449, 1741, 14)), 1, true),
			Wave(1200000):creature("Ghazbaran", Area(Position(6436, 1734, 14), Position(6436, 1734, 14)), 1, true):Notification(-1, "The Demonic Master has revealed himself in the mines of Siberia."),
		},
		cooldown = 144000,
		minPlayersOnline = 5,
	}),
	LuaRaid("Dracola"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Dracola", Area(Position(6139, 1875, 15), Position(6139, 1875, 15)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Lizardape"):Context({
		perDay = 0.288,
		waves = {
			Wave(15000)
				:creature("Lizard Sentinel", Area(Position(6774, 784, 7), Position(6826, 862, 7)), 30, true)
				:creature("Lizard Snakecharmer", Area(Position(6774, 784, 7), Position(6826, 862, 7)), 20, true)
				:creature("Lizard Templar", Area(Position(6774, 784, 7), Position(6826, 862, 7)), 20, true)
				:creature("Battlemaster Zunzu", Area(Position(6774, 784, 7), Position(6822, 811, 7)), 1, true)
				:creature("Kongra", Area(Position(6744, 767, 7), Position(6822, 811, 7)), 35, true)
				:creature("Merlkin", Area(Position(6744, 767, 7), Position(6822, 811, 7)), 35, true)
				:creature("Sibang", Area(Position(6744, 767, 7), Position(6822, 811, 7)), 35, true)
				:Notification(-14000, "Lizardmen are trying to defend themselves against the monkeys' attack on their settlement."),
			Wave(120000)
				:creature("Lizard Sentinel", Area(Position(6761, 769, 7), Position(6826, 862, 7)), 30, true)
				:creature("Lizard Snakecharmer", Area(Position(6761, 769, 7), Position(6826, 862, 7)), 25, true)
				:creature("Lizard Templar", Area(Position(6761, 769, 7), Position(6826, 862, 7)), 25, true)
				:creature("Fazzrah", Area(Position(6769, 784, 7), Position(6798, 794, 7)), 1, true)
				:creature("Kongra", Area(Position(6744, 767, 7), Position(6822, 811, 7)), 35, true)
				:creature("Merlkin", Area(Position(6744, 767, 7), Position(6822, 811, 7)), 35, true)
				:creature("Sibang", Area(Position(6744, 767, 7), Position(6822, 811, 7)), 35, true),
		},
		cooldown = 43200,
		minPlayersOnline = 5,
	}),
	LuaRaid("OrcBp"):Context({
		perDay = 0.2304,
		waves = {
			Wave(10000):creature("Orc Sambackpack", Area(Position(5803, 1298, 7), Position(5808, 1302, 7)), 1, false),
		},
		cooldown = 21600,
		minPlayersOnline = 1,
	}),
	LuaRaid("Yaga_the_Crone"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Yaga the Crone", Area(Position(6018, 1790, 7), Position(6018, 1790, 7)), 1, false),
		},
		cooldown = 64800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Winterwolves"):Context({
		perDay = 0.504,
		waves = {
			Wave(10000):creature("Winter Wolf", Area(Position(6531, 1827, 7), Position(6565, 1862, 7)), 20, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Necropharus"):Context({
		perDay = 0.3168,
		waves = {
			Wave(10000):creature("Necropharus", Area(Position(6077, 1569, 12), Position(6077, 1569, 12)), 1, false),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Midnight_Panther"):Context({
		perDay = 2.304,
		waves = {
			Wave(10000):creature("Midnight Panther", Area(Position(6673, 943, 10), Position(6673, 943, 10)), 1, false):creature("Midnight Panther", Area(Position(6668, 939, 10), Position(6668, 939, 10)), 1, false):creature("Midnight Panther", Area(Position(6680, 916, 10), Position(6680, 916, 10)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Piracimirko"):Context({
		perDay = 0.288,
		waves = {
			Wave(10000):creature("Pirate Buccaneer", Area(Position(5966, 1495, 7), Position(6019, 1542, 7)), 12, true):creature("Pirate Marauder", Area(Position(5966, 1495, 7), Position(6019, 1542, 7)), 10, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Feroxa"):Context({
		perDay = 0.216,
		waves = {
			Wave(60000):creature("Feroxa", Area(Position(6228, 1107, 8), Position(6228, 1107, 8)), 1, true):Notification(-59000, "The unrest fills the air around the steppes..."):Notification(-30000, "Werewolves are trying to summon their Queen regent!"),
		},
		cooldown = 86400,
		minPlayersOnline = 5,
	}),
	LuaRaid("Ancienty"):Context({
		perDay = 0.3168,
		waves = {
			Wave(10000)
				:creature("Ancient Scarab", Area(Position(6618, 1264, 7), Position(6670, 1378, 7)), 30, true)
				:creature("Scarab", Area(Position(6618, 1264, 7), Position(6670, 1378, 7)), 50, true)
				:creature("Larva", Area(Position(6618, 1264, 7), Position(6670, 1378, 7)), 60, true)
				:creature("Ancient Scarab", Area(Position(6740, 1259, 7), Position(6773, 1326, 7)), 8, true)
				:creature("Scarab", Area(Position(6740, 1259, 7), Position(6773, 1326, 7)), 20, true)
				:creature("Larva", Area(Position(6740, 1259, 7), Position(6773, 1326, 7)), 15, true)
				:Notification(-9000, "Ancient Scarabs surround the desert city!"),
			Wave(180000)
				:creature("Ancient Scarab", Area(Position(6618, 1264, 7), Position(6670, 1378, 7)), 25, true)
				:creature("Scarab", Area(Position(6618, 1264, 7), Position(6670, 1378, 7)), 60, true)
				:creature("Larva", Area(Position(6618, 1264, 7), Position(6670, 1378, 7)), 40, true)
				:creature("Ancient Scarab", Area(Position(6740, 1259, 7), Position(6773, 1326, 7)), 15, true)
				:creature("Scarab", Area(Position(6740, 1259, 7), Position(6773, 1326, 7)), 20, true)
				:creature("Larva", Area(Position(6740, 1259, 7), Position(6773, 1326, 7)), 15, true),
			Wave(340000):creature("Ancient Scarab", Area(Position(6667, 1268, 7), Position(6735, 1364, 7)), 45, true):creature("Scarab", Area(Position(6667, 1268, 7), Position(6735, 1364, 7)), 70, true):creature("Fleshcrawler", Area(Position(6667, 1268, 7), Position(6735, 1364, 7)), 2, true):Notification(-160000, "There are more and more Scarabs!"),
		},
		cooldown = 43200,
		minPlayersOnline = 5,
	}),
	LuaRaid("Dragonling"):Context({
		perDay = 0.504,
		waves = {
			Wave(1000):creature("Dragonling", Area(Position(6531, 1721, 13), Position(6590, 1769, 14)), 6, true),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Snowman_Sybir"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Animated Snowman", Area(Position(6478, 1815, 7), Position(6594, 1879, 6)), 10, false),
		},
		cooldown = 7200,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_Bloodweb"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("The Bloodweb", Area(Position(6558, 1744, 8), Position(6558, 1744, 8)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_Plasmother"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("The Plasmother", Area(Position(6147, 1890, 15), Position(6147, 1890, 15)), 1, false),
		},
		cooldown = 57600,
		minPlayersOnline = 1,
	}),
	LuaRaid("Weakened_Shlorg"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("weakened shlorg", Area(Position(6697, 849, 13), Position(6697, 849, 13)), 1, false),
		},
		cooldown = 64800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Old_Widow"):Context({
		perDay = 0.288,
		waves = {
			Wave(10000):creature("Giant Spider", Area(Position(5939, 1644, 7), Position(6039, 1712, 8)), 15, true):creature("Tarantula", Area(Position(5939, 1644, 7), Position(6039, 1712, 8)), 20, true):Notification(-9000, "Giant spiders have been noticed around the tarantulas' lair!"),
			Wave(240000):creature("Giant Spider", Area(Position(5939, 1644, 7), Position(6039, 1712, 8)), 30, true):creature("Tarantula", Area(Position(5939, 1644, 7), Position(6039, 1712, 8)), 40, true):Notification(-230000, "We advise against going to the hunters' camp!"),
			Wave(360000):creature("The Old Widow", Area(Position(5939, 1644, 7), Position(6039, 1712, 8)), 1, true):creature("Giant Spider", Area(Position(5939, 1644, 7), Position(6039, 1712, 8)), 15, true):creature("Tarantula", Area(Position(5939, 1644, 7), Position(6039, 1712, 8)), 20, true),
		},
		cooldown = 43200,
		minPlayersOnline = 5,
	}),
	LuaRaid("Supply_2"):Context({
		perDay = 0.648,
		waves = {
			Wave(1000):creature("Supply Dragon", Area(Position(6519, 1067, 7), Position(6939, 1414, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Supply_6"):Context({
		perDay = 0.648,
		waves = {
			Wave(1000):creature("Supply Dragon", Area(Position(6380, 1731, 7), Position(6597, 1911, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Dryad"):Context({
		perDay = 0.288,
		waves = {
			Wave(15000):creature("Forest Fury", Area(Position(5915, 1817, 7), Position(6068, 1872, 7)), 25, true):creature("Dryad", Area(Position(5915, 1817, 7), Position(6068, 1872, 7)), 55, true):Notification(-14000, "Dryads are conducting their rituals along the elf fortress."),
			Wave(125000):creature("Forest Fury", Area(Position(5981, 1918, 7), Position(6073, 1954, 7)), 15, true):creature("Dryad", Area(Position(5981, 1918, 7), Position(6073, 1954, 7)), 35, true),
		},
		cooldown = 43200,
		minPlayersOnline = 3,
	}),
	LuaRaid("Supply_4"):Context({
		perDay = 0.648,
		waves = {
			Wave(1000):creature("Supply Dragon", Area(Position(5984, 1006, 7), Position(6329, 1297, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Rottie2"):Context({
		perDay = 1.152,
		waves = {
			Wave(10000):creature("Rottie The Rotworm", Area(Position(5545, 1560, 8), Position(5545, 1560, 8)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_Imperor"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("The Imperor", Area(Position(6209, 1781, 15), Position(6209, 1781, 15)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Dharalion"):Context({
		perDay = 0.504,
		waves = {
			Wave(10000):creature("Dharalion", Area(Position(5739, 1663, 9), Position(5739, 1663, 9)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Zolwie"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("Tortoise", Area(Position(7010, 774, 6), Position(7066, 815, 6)), 35, true),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Zulazza"):Context({
		perDay = 0.2592,
		waves = {
			Wave(360000):creature("Chizzoron the Distorter", Area(Position(6440, 910, 4), Position(6440, 910, 4)), 1, true):creature("Zulazza the Corruptor", Area(Position(6438, 918, 1), Position(6438, 918, 1)), 1, true):Notification(-359000, "Lizardmen are trying to summon their ruler in their village!"),
			Wave(720000):Notification(-360000, "The Right Hand of the Lizard Ruler has already arrived in their village!"),
		},
		cooldown = 86400,
		minPlayersOnline = 5,
	}),
	LuaRaid("Furyosa"):Context({
		perDay = 0.1728,
		waves = {
			Wave(60000):creature("Furyosa", Area(Position(6258, 917, 11), Position(6258, 917, 11)), 1, true):creature("Fury", Area(Position(6213, 898, 11), Position(6265, 931, 11)), 15, true):Notification(-59000, "Furyosa has haunted the underground city of Souleaters!"),
		},
		cooldown = 86400,
		minPlayersOnline = 4,
	}),
	LuaRaid("Arachir_The_Ancient_One"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Arachir The Ancient One", Area(Position(6141, 848, 5), Position(6141, 848, 5)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Piraci"):Context({
		perDay = 0.288,
		waves = {
			Wave(10000)
				:creature("Pirate Buccaneer", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Marauder", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Cutthroat", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Corsair", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 35, false)
				:creature("Smuggler", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 25, false)
				:creature("Pirate Buccaneer", Area(Position(6971, 768, 5), Position(6981, 789, 5)), 6, false)
				:creature("Pirate Marauder", Area(Position(6971, 768, 5), Position(6981, 789, 5)), 6, false)
				:creature("Pirate Buccaneer", Area(Position(6989, 737, 5), Position(7063, 765, 5)), 8, false)
				:creature("Pirate Marauder", Area(Position(6989, 737, 5), Position(7063, 765, 5)), 8, false)
				:creature("Pirate Cutthroat", Area(Position(6989, 737, 5), Position(7063, 765, 5)), 8, false)
				:creature("Pirate Corsair", Area(Position(6989, 737, 5), Position(7063, 765, 5)), 8, false)
				:Notification(-9000, "Pirates have attacked Kongo!"),
			Wave(180000)
				:creature("Pirate Buccaneer", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Marauder", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Cutthroat", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Corsair", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 30, false)
				:creature("Smuggler", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 25, false)
				:Notification(-10000, "Pirates are sending support!"),
			Wave(360000)
				:creature("Pirate Buccaneer", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Marauder", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Cutthroat", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 40, false)
				:creature("Pirate Corsair", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 35, false)
				:creature("Smuggler", Area(Position(6976, 741, 5), Position(7064, 814, 6)), 25, false)
				:creature("Ron The Ripper", Area(Position(7021, 804, 6), Position(7021, 804, 6)), 1, true)
				:creature("Lethal Lissy", Area(Position(7040, 774, 6), Position(7040, 774, 6)), 1, true)
				:creature("Brutus Bloodbeard", Area(Position(6982, 750, 6), Position(6982, 750, 6)), 1, true)
				:creature("Deadeye Devious", Area(Position(7012, 763, 6), Position(7012, 763, 6)), 1, true)
				:Notification(-10000, "Pirates have sent additional reinforcements!"),
		},
		cooldown = 43200,
		minPlayersOnline = 5,
	}),
	LuaRaid("Minotaury"):Context({
		perDay = 0.288,
		waves = {
			Wave(10000)
				:creature("Minotaur", Area(Position(5943, 1357, 7), Position(5975, 1383, 7)), 17, true)
				:creature("Minotaur Guard", Area(Position(5943, 1357, 7), Position(5975, 1383, 7)), 15, true)
				:creature("Minotaur Archer", Area(Position(5943, 1357, 7), Position(5975, 1383, 7)), 18, true)
				:creature("Minotaur Mage", Area(Position(5943, 1357, 7), Position(5975, 1383, 7)), 5, true)
				:Notification(-9000, "A group of minotaurs has left their camp."),
			Wave(120000):creature("Minotaur", Area(Position(5891, 1411, 7), Position(5947, 1460, 7)), 38, true):creature("Minotaur Guard", Area(Position(5891, 1411, 7), Position(5947, 1460, 7)), 38, true):creature("Minotaur Archer", Area(Position(5891, 1411, 7), Position(5947, 1460, 7)), 38, true):creature("Minotaur Mage", Area(Position(5891, 1411, 7), Position(5947, 1460, 7)), 15, true),
			Wave(185000)
				:creature("Minotaur", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 38, true)
				:creature("Minotaur Guard", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 38, true)
				:creature("Minotaur Archer", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 38, true)
				:creature("Minotaur Mage", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 15, true)
				:Notification(-65000, "Minotaurs are approaching the city!")
				:Notification(-5000, "Minotaurs are attacking the city walls!"),
			Wave(245000)
				:creature("Minotaur", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 45, true)
				:creature("Minotaur Guard", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 45, true)
				:creature("Minotaur Archer", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 45, true)
				:creature("Minotaur Mage", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 15, true)
				:creature("General Murius", Area(Position(5885, 1436, 7), Position(5946, 1477, 7)), 1, true)
				:Notification(-5000, "The attack will likely cease if their general falls!"),
		},
		cooldown = 43200,
		minPlayersOnline = 5,
	}),
	LuaRaid("Kroliki"):Context({
		perDay = 0.288,
		waves = {
			Wave(10000):creature("Silver Rabbit", Area(Position(5801, 1475, 7), Position(5988, 1598, 7)), 55, false):Notification(-9000, "Holiday bunnies have swarmed the entire city!"),
			Wave(120000):creature("Silver Rabbit", Area(Position(5801, 1475, 7), Position(5988, 1598, 7)), 65, false),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Zomba"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Lion", Area(Position(6603, 1233, 7), Position(6672, 1302, 7)), 35, true):creature("Zomba", Area(Position(6603, 1233, 7), Position(6672, 1302, 7)), 1, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Morgaroth"):Context({
		perDay = 0.1872,
		waves = {
			Wave(360000):creature("Demon", Area(Position(6713, 1143, 10), Position(6749, 1173, 10)), 7, true):Notification(-359000, "Strange footsteps can be heard in the north of the desert."),
			Wave(720000):creature("Morgaroth", Area(Position(6728, 1158, 10), Position(6728, 1158, 10)), 1, true):Notification(-360000, "The presence of mythical evil can be sensed near the extinct volcano in the desert."):Notification(-1, "Morgaroth has activated the volcano and revealed himself in its depths!"),
		},
		cooldown = 144000,
		minPlayersOnline = 5,
	}),
	LuaRaid("Jaglak"):Context({
		perDay = 0.0144,
		waves = {
			Wave(600000):creature("Jaglak", Area(Position(5849, 1716, 7), Position(5849, 1716, 7)), 1, false):Notification(-599000, "Cyclopes have ordered an extraordinary amount of cereal, perhaps preparing for a visit!"):Notification(-300000, "Information about visit to the one-eyed by The Jaglak has been confirmed!"),
		},
		cooldown = 43200,
		minPlayersOnline = 500,
	}),
	LuaRaid("Malpy"):Context({
		perDay = 0.288,
		waves = {
			Wave(10000)
				:creature("Sibang", Area(Position(6900, 694, 7), Position(6993, 767, 7)), 50, false)
				:creature("Kongra", Area(Position(6900, 694, 7), Position(6993, 767, 7)), 50, false)
				:creature("Merlkin", Area(Position(6900, 694, 7), Position(6993, 767, 7)), 50, true)
				:creature("Hairman the Huge", Area(Position(6900, 694, 7), Position(6993, 767, 7)), 1, true)
				:creature("Sibang", Area(Position(6976, 749, 5), Position(6993, 816, 6)), 20, false)
				:creature("Kongra", Area(Position(6976, 749, 5), Position(6993, 816, 6)), 20, false)
				:creature("Merlkin", Area(Position(6976, 749, 5), Position(6993, 816, 6)), 20, false)
				:Notification(-9000, "An increased number of monkeys has been noticed below the Kongo settlement!"),
			Wave(180000)
				:creature("Sibang", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 50, false)
				:creature("Kongra", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 50, false)
				:creature("Merlkin", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 50, false)
				:creature("Hairman the Huge", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 1, true)
				:creature("Sibang", Area(Position(6970, 769, 5), Position(6976, 791, 5)), 5, false)
				:creature("Kongra", Area(Position(6970, 769, 5), Position(6976, 791, 5)), 5, false),
			Wave(320000)
				:creature("Sibang", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 50, false)
				:creature("Kongra", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 50, false)
				:creature("Merlkin", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 50, false)
				:creature("Hairman the Huge", Area(Position(6976, 749, 5), Position(7065, 816, 6)), 1, true)
				:Notification(-140000, "Monkeys of focus, commitment, and sheer will are trying to rob Kongo again!"),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Dragonling2"):Context({
		perDay = 0.504,
		waves = {
			Wave(1000):creature("Dragonling", Area(Position(5614, 1409, 12), Position(5711, 1494, 12)), 6, true),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Slug"):Context({
		perDay = 2.304,
		waves = {
			Wave(10000)
				:creature("Slug", Area(Position(5642, 1664, 7), Position(5642, 1664, 7)), 1, false)
				:creature("Slug", Area(Position(5663, 1689, 7), Position(5663, 1689, 7)), 1, false)
				:creature("Slug", Area(Position(5634, 1683, 7), Position(5634, 1683, 7)), 1, false)
				:creature("Slug", Area(Position(5678, 1668, 7), Position(5678, 1668, 7)), 1, false)
				:creature("Slug", Area(Position(5666, 1707, 7), Position(5666, 1707, 7)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 0,
	}),
	LuaRaid("Crystalwolves"):Context({
		perDay = 0.72,
		waves = {
			Wave(1000):creature("Crystal Wolf", Area(Position(6379, 1844, 5), Position(6474, 1875, 7)), 8, true),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Icegolem"):Context({
		perDay = 0.8,
		waves = {
			Wave(10000)
				:creature("Ice Golem", Area(Position(6522, 1756, 9), Position(6545, 1789, 9)), 4, true)
				:creature("Ice Golem", Area(Position(6545, 1738, 8), Position(6603, 1772, 8)), 12, true)
				:creature("Ice Golem", Area(Position(6506, 1758, 8), Position(6525, 1798, 8)), 6, true)
				:creature("Hirintror", Area(Position(6506, 1758, 8), Position(6525, 1798, 8)), 1, true)
				:creature("Ice Golem", Area(Position(6529, 1789, 7), Position(6563, 1812, 7)), 8, true)
				:creature("Shardhead", Area(Position(6529, 1789, 7), Position(6563, 1812, 7)), 1, true)
				:creature("Ice Golem", Area(Position(6541, 1802, 6), Position(6559, 1818, 6)), 3, true)
				:creature("Ice Golem", Area(Position(6528, 1798, 5), Position(6562, 1813, 5)), 6, true)
				:creature("Ice Golem", Area(Position(6548, 1796, 3), Position(6564, 1810, 3)), 5, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Acolyte_of_Darkness"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000):creature("Acolyte of Darkness", Area(Position(7580, 1795, 11), Position(7580, 1795, 11)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Grand_Mother_Foulscale2"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Grand Mother Foulscale", Area(Position(6671, 591, 6), Position(6671, 591, 6)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Necropharus3"):Context({
		perDay = 0.3168,
		waves = {
			Wave(10000):creature("Necropharus", Area(Position(6709, 1304, 12), Position(6709, 1304, 12)), 1, false),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Ocyakao"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Ocyakao", Area(Position(6496, 1827, 7), Position(6496, 1827, 7)), 1, false),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Mole"):Context({
		perDay = 2.16,
		waves = {
			Wave(10000):creature("Mole", Area(Position(5915, 1825, 8), Position(5915, 1825, 8)), 1, false):creature("Mole", Area(Position(5917, 1813, 8), Position(5917, 1813, 8)), 1, false):creature("Mole", Area(Position(5926, 1815, 8), Position(5926, 1815, 8)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 0,
	}),
	LuaRaid("Smuggler_baron_silvertoe"):Context({
		perDay = 0.864,
		waves = {
			Wave(10000):creature("Smuggler Baron Silvertoe", Area(Position(6054, 1400, 7), Position(6054, 1400, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_old_Widow"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000):creature("The old Widow", Area(Position(7375, 1661, 9), Position(7375, 1661, 9)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Shadow_Hound"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000):creature("Shadow Hound", Area(Position(6404, 1949, 8), Position(6404, 1949, 8)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_Many"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("The Many", Area(Position(6737, 637, 5), Position(6737, 637, 5)), 1, false),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Ferumbras"):Context({
		perDay = 0.1584,
		waves = {
			Wave(720000):creature("Ferumbras", Area(Position(6112, 1324, 14), Position(6112, 1324, 14)), 1, true):Notification(-719000, "Demonic shrieks emanate from the underground near the wizards' village."):Notification(-360000, "Wizards in their underground academy are performing a summoning ceremony for their former Master."),
		},
		cooldown = 144000,
		minPlayersOnline = 5,
	}),
	LuaRaid("Rottie"):Context({
		perDay = 1.152,
		waves = {
			Wave(10000):creature("Rottie The Rotworm", Area(Position(5992, 1550, 9), Position(5992, 1550, 9)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Tiquandas_Revenge"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Tiquandas Revenge", Area(Position(6708, 590, 7), Position(6708, 590, 7)), 1, true),
		},
		cooldown = 57600,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_Handmaiden"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("The Handmaiden", Area(Position(6087, 1844, 15), Position(6087, 1844, 15)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Orki"):Context({
		perDay = 0.3168,
		waves = {
			Wave(10000)
				:creature("Orc", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 30, false)
				:creature("Orc Spearman", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 30, false)
				:creature("Orc Warrior", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 30, false)
				:creature("Orc Shaman", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 30, false)
				:creature("Orc Leader", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 15, false)
				:Notification(-9000, "Orcs are attacking the city from the south!"),
			Wave(240000)
				:creature("Orc", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 35, false)
				:creature("Orc Spearman", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 35, false)
				:creature("Orc Warrior", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 35, false)
				:creature("Orc Shaman", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 35, false)
				:creature("Orc Leader", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 35, false)
				:creature("Orc Berserker", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 35, false)
				:creature("Orc Warlord", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 20, false)
				:Notification(-10000, "Orcs have sent additional reinforcements!"),
			Wave(280000)
				:creature("Orc Helmet", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 1, true)
				:creature("Orc Shield", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 1, true)
				:creature("Orc Armor", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 1, true)
				:creature("Orc Leader", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 8, false)
				:creature("Orc Berserker", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 8, false)
				:creature("Orc Warlord", Area(Position(5829, 1613, 7), Position(5959, 1661, 7)), 8, false),
		},
		cooldown = 43200,
		minPlayersOnline = 5,
	}),
	LuaRaid("Wasp"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Wasp", Area(Position(5969, 1498, 6), Position(6023, 1576, 7)), 100, false):creature("Willi Wasp", Area(Position(5969, 1498, 6), Position(6023, 1576, 7)), 1, true):Notification(-9000, "Enraged bees are buzzing in the east of the city!"),
			Wave(120000):creature("Wasp", Area(Position(5969, 1498, 6), Position(6023, 1576, 7)), 90, false):creature("Willi Wasp", Area(Position(5969, 1498, 6), Position(6023, 1576, 7)), 1, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Tromphonyte"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Tromphonyte", Area(Position(5962, 1164, 8), Position(5962, 1164, 8)), 1, false),
		},
		cooldown = 57600,
		minPlayersOnline = 1,
	}),
	LuaRaid("Ladybug"):Context({
		perDay = 2.304,
		waves = {
			Wave(10000):creature("Ladybug", Area(Position(6614, 783, 7), Position(6614, 783, 7)), 1, false):creature("Ladybug", Area(Position(6625, 770, 7), Position(6625, 770, 7)), 1, false):creature("Ladybug", Area(Position(6637, 784, 7), Position(6637, 784, 7)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 0,
	}),
	LuaRaid("Undead_Cavebear"):Context({
		perDay = 2.16,
		waves = {
			Wave(10000)
				:creature("Undead Cavebear", Area(Position(5809, 1045, 10), Position(5809, 1045, 10)), 1, false)
				:creature("Undead Cavebear", Area(Position(5797, 1020, 10), Position(5797, 1020, 10)), 1, false)
				:creature("Undead Cavebear", Area(Position(5843, 1049, 10), Position(5843, 1049, 10)), 1, false)
				:creature("Undead Cavebear", Area(Position(6237, 1286, 9), Position(6237, 1286, 9)), 1, false)
				:creature("Undead Cavebear", Area(Position(6246, 1263, 9), Position(6246, 1263, 9)), 1, false)
				:creature("Undead Cavebear", Area(Position(6270, 1276, 9), Position(6270, 1276, 9)), 1, false)
				:creature("Undead Cavebear", Area(Position(6250, 1296, 9), Position(6250, 1296, 9)), 1, false)
				:creature("Undead Cavebear", Area(Position(6240, 1276, 10), Position(6240, 1276, 10)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Manta_Ray"):Context({
		perDay = 2.304,
		waves = {
			Wave(10000):creature("Manta Ray", Area(Position(6493, 743, 10), Position(6493, 743, 10)), 1, false):creature("Manta Ray", Area(Position(6511, 746, 10), Position(6511, 746, 10)), 1, false):creature("Manta Ray", Area(Position(6485, 728, 10), Position(6485, 728, 10)), 1, false):creature("Manta Ray", Area(Position(6510, 728, 10), Position(6510, 728, 10)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Xenia"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Xenia", Area(Position(5708, 1510, 4), Position(5708, 1510, 4)), 1, false),
		},
		cooldown = 64800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Raty"):Context({
		perDay = 0.216,
		waves = {
			Wave(10000):creature("Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):creature("Cave Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):creature("Munster", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 1, false):Notification(-9000, "A plague of rats is spreading through the city!"),
			Wave(230000):creature("Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):creature("Cave Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):Notification(-10000, "Rats are still emerging from the sewers!"),
			Wave(420000):creature("Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):creature("Cave Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):creature("Munster", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 1, false),
			Wave(600000):creature("Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):creature("Cave Rat", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 200, false):creature("Munster", Area(Position(5801, 1500, 4), Position(5973, 1610, 8)), 1, false),
		},
		cooldown = 64800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Gaz_haragoth"):Context({
		perDay = 0.1584,
		waves = {
			Wave(10000):creature("gaz'haragoth", Area(Position(6136, 700, 12), Position(6136, 700, 12)), 1, true):Notification(-9000, "Gaz'haragoth will shatter your dreams in a barrage of nightmares!"),
		},
		cooldown = 158400,
		minPlayersOnline = 5,
	}),
	LuaRaid("Fleshcrawler"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Fleshcrawler", Area(Position(6572, 1248, 9), Position(6572, 1248, 9)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Barbaria"):Context({
		perDay = 0.4752,
		waves = {
			Wave(10000):creature("Barbaria", Area(Position(6471, 1764, 7), Position(6471, 1764, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Grand_Mother_Foulscale"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Grand Mother Foulscale", Area(Position(5875, 1334, 4), Position(5875, 1334, 4)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Gochabaal"):Context({
		perDay = 0.2016,
		waves = {
			Wave(600000):creature("Demon", Area(Position(5865, 1327, 3), Position(5901, 1368, 4)), 6, true):Notification(-599000, "Terrible wails are echoing from the depths of the volcano, north of Mirko Town."),
			Wave(1200000):creature("Demon", Area(Position(5865, 1327, 3), Position(5901, 1368, 4)), 7, true):creature("Gochabaal", Area(Position(5875, 1332, 4), Position(5875, 1332, 4)), 1, true):Notification(-600000, "Gochabaal is trying to return from the underworld! Demons have appeared on the volcano above Mirko Town."),
		},
		cooldown = 144000,
		minPlayersOnline = 5,
	}),
	LuaRaid("Grorlam"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000):creature("Grorlam", Area(Position(6794, 1241, 9), Position(6794, 1241, 9)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Crustacea_Gigantica"):Context({
		perDay = 2.304,
		waves = {
			Wave(10000):creature("Crustacea Gigantica", Area(Position(6701, 1071, 9), Position(6701, 1071, 9)), 1, false):creature("Crustacea Gigantica", Area(Position(6722, 1066, 9), Position(6722, 1066, 9)), 1, false):creature("Crustacea Gigantica", Area(Position(6694, 1077, 8), Position(6694, 1077, 8)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Barbarian"):Context({
		perDay = 0.288,
		waves = {
			Wave(120000)
				:creature("Barbarian Bloodwalker", Area(Position(6450, 1739, 7), Position(6515, 1787, 7)), 18, true)
				:creature("Barbarian Brutetamer", Area(Position(6450, 1739, 7), Position(6515, 1787, 7)), 18, true)
				:creature("Barbarian Headsplitter", Area(Position(6450, 1739, 7), Position(6515, 1787, 7)), 18, true)
				:creature("Barbarian Skullhunter", Area(Position(6450, 1739, 7), Position(6515, 1787, 7)), 30, true)
				:Notification(-119000, "Barbarians are gathering in their village. It seems they are preparing for something."),
			Wave(240000)
				:creature("Barbarian Bloodwalker", Area(Position(6502, 1783, 4), Position(6565, 1824, 7)), 18, true)
				:creature("Barbarian Brutetamer", Area(Position(6502, 1783, 4), Position(6565, 1824, 7)), 18, true)
				:creature("Barbarian Headsplitter", Area(Position(6502, 1783, 4), Position(6565, 1824, 7)), 17, true)
				:creature("Barbarian Skullhunter", Area(Position(6502, 1783, 4), Position(6565, 1824, 7)), 17, true)
				:creature("Barbaria", Area(Position(6502, 1783, 4), Position(6565, 1824, 7)), 1, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Demodras"):Context({
		perDay = 0.2592,
		waves = {
			Wave(10000):creature("Demodras", Area(Position(5846, 1342, 3), Position(5877, 1369, 3)), 1, true):creature("Dragon Lord", Area(Position(5846, 1342, 3), Position(5877, 1369, 3)), 12, true),
		},
		cooldown = 64800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Grynch"):Context({
		perDay = 0.288,
		waves = {
			Wave(125000):creature("Grynch Clan Goblin", Area(Position(5793, 1480, 7), Position(5973, 1598, 7)), 200, true):Notification(-124000, "Goblins are coming to rob the city!"):Notification(-5000, "The goblins have come to rob the city!"),
			Wave(360000):creature("Grynch Clan Goblin", Area(Position(5793, 1480, 7), Position(5973, 1598, 7)), 220, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Demodras2"):Context({
		perDay = 0.2592,
		waves = {
			Wave(10000):creature("Demodras", Area(Position(6702, 1117, 8), Position(6727, 1140, 8)), 1, true):creature("Dragon Lord", Area(Position(6702, 1117, 8), Position(6727, 1140, 8)), 12, true),
		},
		cooldown = 64800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Ekatrix"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Ekatrix", Area(Position(5667, 1742, 4), Position(5667, 1742, 4)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),

	LuaRaid("Karakan"):Context({
		perDay = 0.216,
		waves = {
			Wave(10000):creature("Bug", Area(Position(5711, 1542, 7), Position(5801, 1616, 7)), 150, true):Notification(-9000, "Vermin has once again scattered in the west of MirkoTown!"),
			Wave(125000):creature("Bug", Area(Position(5711, 1542, 7), Position(5801, 1616, 7)), 45, true):Notification(-5000, "Toxic bugs are attacking the farms!"),
			Wave(245000):creature("Bug", Area(Position(5711, 1542, 7), Position(5801, 1616, 7)), 25, true):creature("Karaczan", Area(Position(5711, 1542, 7), Position(5801, 1616, 7)), 7, true):Notification(-5000, "Cockroaches are appearing around the farm!"),
		},
		cooldown = 43200,
		minPlayersOnline = 5,
	}),
	LuaRaid("Supply_3"):Context({
		perDay = 0.648,
		waves = {
			Wave(1000):creature("Supply Dragon", Area(Position(6484, 579, 7), Position(6966, 821, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Black_sheep"):Context({
		perDay = 2.304,
		waves = {
			Wave(10000):creature("Black sheep", Area(Position(5534, 1593, 7), Position(5534, 1593, 7)), 1, false):creature("Black sheep", Area(Position(5543, 1580, 7), Position(5543, 1580, 7)), 1, false):creature("Black sheep", Area(Position(5538, 1586, 7), Position(5538, 1586, 7)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 0,
	}),
	LuaRaid("The_Old_Widow"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("The Old Widow", Area(Position(6826, 739, 9), Position(6826, 739, 9)), 1, false),
		},
		cooldown = 57600,
		minPlayersOnline = 1,
	}),
	LuaRaid("Hatebreeder"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("Hatebreeder", Area(Position(6674, 928, 11), Position(6674, 928, 11)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Tyrn2"):Context({
		perDay = 0.8,
		waves = {
			Wave(10000):creature("Tyrn", Area(Position(6406, 1263, 3), Position(6406, 1263, 3)), 1, false),
		},
		cooldown = 57600,
		minPlayersOnline = 1,
	}),
	LuaRaid("Man_in_the_Cave"):Context({
		perDay = 0.432,
		waves = {
			Wave(10000):creature("Man in the Cave", Area(Position(6531, 1778, 9), Position(6531, 1778, 9)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Mr_Punish"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("Mr. Punish", Area(Position(6065, 1809, 15), Position(6065, 1809, 15)), 1, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Massacre"):Context({
		perDay = 0.36,
		waves = {
			Wave(10000):creature("Massacre", Area(Position(6170, 1832, 15), Position(6170, 1832, 15)), 1, true),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Necropharus2"):Context({
		perDay = 0.3168,
		waves = {
			Wave(10000):creature("Necropharus", Area(Position(5698, 1446, 9), Position(5698, 1446, 9)), 1, false),
		},
		cooldown = 43200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Fernfang"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Fernfang", Area(Position(5730, 1522, 14), Position(5730, 1522, 14)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Supply_5"):Context({
		perDay = 0.648,
		waves = {
			Wave(1000):creature("Supply Dragon", Area(Position(6143, 823, 7), Position(6542, 1105, 7)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Snowman"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Animated Snowman", Area(Position(5793, 1480, 7), Position(5973, 1598, 7)), 20, true),
		},
		cooldown = 7200,
		minPlayersOnline = 1,
	}),
	LuaRaid("Bane_Bringer"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000):creature("Bane Bringer", Area(Position(7599, 1693, 9), Position(7599, 1693, 9)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Undead_Cavebear2"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000):creature("Undead Cavebear", Area(Position(7507, 1706, 11), Position(7507, 1706, 11)), 1, false),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("Panda"):Context({
		perDay = 2.16,
		waves = {
			Wave(10000):creature("Panda", Area(Position(6597, 773, 7), Position(6597, 773, 7)), 1, false):creature("Panda", Area(Position(6593, 771, 7), Position(6593, 771, 7)), 1, false):creature("Panda", Area(Position(6593, 764, 6), Position(6593, 764, 6)), 1, false),
		},
		cooldown = 7200,
		minPlayersOnline = 0,
	}),
	LuaRaid("Pinata_1"):Context({
		perDay = 1.008,
		waves = {
			Wave(1000):creature("Pinata Dragon", Area(Position(5738, 1295, 7), Position(6114, 1952, 7)), 2, false),
		},
		cooldown = 14400,
		minPlayersOnline = 0,
	}),
	LuaRaid("Mad_Mage_and_Servants"):Context({
		perDay = 0.648,
		waves = {
			Wave(10000)
				:creature("Mad Mage", Area(Position(7644, 1790, 11), Position(7644, 1790, 11)), 1, false)
				:creature("Iron Servant", Area(Position(7632, 1736, 12), Position(7632, 1736, 12)), 1, false)
				:creature("Iron Servant", Area(Position(7640, 1756, 12), Position(7640, 1756, 12)), 1, false)
				:creature("Golden Servant", Area(Position(7628, 1759, 11), Position(7628, 1759, 11)), 1, false)
				:creature("Golden Servant", Area(Position(7626, 1779, 11), Position(7626, 1779, 11)), 1, false)
				:creature("Diamond Servant", Area(Position(7653, 1782, 11), Position(7653, 1782, 11)), 1, false)
				:creature("Diamond Servant", Area(Position(7650, 1793, 11), Position(7650, 1793, 11)), 1, false)
				:Notification(-9000, "The Mad Mage has been sighted sneaking into his lair located in the deep underground on the east of Orshaawa."),
		},
		cooldown = 10800,
		minPlayersOnline = 1,
	}),
	LuaRaid("The_Evil_Eye"):Context({
		perDay = 0.7,
		waves = {
			Wave(10000):creature("The Evil Eye", Area(Position(5769, 1411, 9), Position(5769, 1411, 9)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Walker"):Context({
		perDay = 1.08,
		waves = {
			Wave(1000):creature("Walker", Area(Position(5728, 1160, 8), Position(5812, 1209, 8)), 6, true),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
	LuaRaid("Hide"):Context({
		perDay = 0.576,
		waves = {
			Wave(10000):creature("Hide", Area(Position(6826, 739, 9), Position(6826, 739, 9)), 1, false),
		},
		cooldown = 14400,
		minPlayersOnline = 1,
	}),
}

for _, raid in pairs(raidData) do
	LuaRaidRegistry:Register(raid)
end

local weekdayRaids = {
	["Monday"] = {
		["21:00"] = { "Piraci" },
	},
	["Tuesday"] = {
		["21:00"] = { "Grynch" },
	},
	["Wednesday"] = {
		["21:00"] = { "Dryad" },
	},
	["Thursday"] = {
		["21:00"] = { "Gobliny" },
	},
	["Friday"] = {
		["21:00"] = { "Lizardape" },
	},
	["Saturday"] = {
		["21:00"] = { "Piracimirko" },
	},
	["Sunday"] = {
		["21:00"] = { "barbarian" },
	},
}

local monthDayRaids = {
	["31/10"] = {
		["21:00"] = { "wolfy" },
	},
}

local globalevent = GlobalEvent("RaidsByWeekday")
function globalevent.onThink(...)
	local weekDay = os.date("%A")
	local hourMinuteNow = getRealTime()

	local todayRaids = weekdayRaids[weekDay] or {}
	local thisHourMinuteRaids = todayRaids[hourMinuteNow] or {}

	for _, raidName in pairs(thisHourMinuteRaids) do
		LuaRaidRegistry:StartByName(raidName, false)
	end
	return true
end

globalevent:interval(1 * 60 * 1000) --1min
globalevent:register()

local raidByMonthDay = GlobalEvent("RaidsByMonthDay")

function raidByMonthDay.onThink(...)
	local date = getRealDate()
	local hourMinuteNow = getRealTime()

	local todayRaids = monthDayRaids[date] or {}
	local thisHourMinuteRaids = todayRaids[hourMinuteNow] or {}

	for _, raidName in pairs(thisHourMinuteRaids) do
		LuaRaidRegistry:StartByName(raidName, false)
	end
	return true
end

raidByMonthDay:interval(1 * 60 * 1000) --1min
raidByMonthDay:register()
