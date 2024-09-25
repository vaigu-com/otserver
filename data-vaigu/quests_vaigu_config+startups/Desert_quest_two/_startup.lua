BANJO_KROLA_SZCZUROW:Script(function(storageToRequiredState)
local static = {
	{ position = Position(5899, 1573, 9), id = 2772, aid = Storage.DesertQuestTwo.Puzzles.Chess.ClearLever },
}

local puzzles = {
	{ pos = { -13, 31, 0 }, id = 1757, aid = Storage.DesertQuestTwo.RewardRoomTp },
	{ pos = { 16, -74, 0 }, id = 775, aid = Storage.DesertQuestHub.ToHub },
	{ pos = { 13, -74, 2 }, id = 775, aid = Storage.DesertQuestHub.ToHub },
	{ pos = { 43, -71, 0 }, id = 775, aid = Storage.DesertQuestHub.ToHub },

	{ pos = { 0, -22, 0 }, id = 12782, aid = Storage.DesertQuestTwo.Puzzles.TrickSign, desc = "TRICK_SIGN" },
	{ pos = { 34, -70, 0 }, id = 134, aid = Storage.DesertQuestTwo.Puzzles.TrickGrave, desc = "TRICK_GRAVE" },
	{ pos = { 4, -16, -1 }, id = 4515, aid = Storage.DesertQuestTwo.Puzzles.TrickTeleport },

	{ pos = { 26, -44, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.WaterPipesLever },

	{ pos = { -25, 1, 1 }, id = 410, aid = Storage.DesertQuestTwo.Puzzles.FireBlockageTile },
	{ pos = { -25, 2, 1 }, id = 410, aid = Storage.DesertQuestTwo.Puzzles.FireBlockageTile },
	{ pos = { -25, 3, 1 }, id = 410, aid = Storage.DesertQuestTwo.Puzzles.FireBlockageTile },

	{ pos = { -1, 0, 0 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.FiftenPuzzleLever },
	{ pos = { 9, -7, 0 }, id = 20888, aid = Storage.DesertQuestTwo.Puzzles.FiftenPuzzleMove },

	{ pos = { 42, -6, 0 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.FastMoaLever },

	{ pos = { 17, -18, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RgbColors },

	{ pos = { 7, -32, -5 }, id = 2772, aid = Storage.DesertQuestTwo.Teleports.ToIdenticalRoom },
	{ pos = { -85, -21, 0 }, id = 5542, aid = Storage.DesertQuestTwo.Teleports.FromIdenticalRoom },

	{ pos = { -109, 4, 1 }, id = 5542, aid = Storage.DesertQuestTwo.Teleports.FromIdenticalRoom },
	{ pos = { -97, 12, 1 }, id = 5542, aid = Storage.DesertQuestTwo.Teleports.FromIdenticalRoom },
	{ pos = { -73, -42, 1 }, id = 5542, aid = Storage.DesertQuestTwo.Teleports.FromIdenticalRoom },
	{ pos = { -89, -54, 1 }, id = 5542, aid = Storage.DesertQuestTwo.Teleports.FromIdenticalRoom },

	{ pos = { -2, -52, -1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.OrbsReset },
	{ pos = { -9, -58, -2 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.OrbsReset },
	{ pos = { -11, -54, -1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.OrbsReset },
	{ pos = { -19, -58, -1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.OrbsReset },
}

local rubiksCube = {
	{ pos = { -3, 0, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Back },
	{ pos = { -3, 1, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Xaxis },
	{ pos = { -3, 2, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Front },

	{ pos = { 2, 6, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Right },
	{ pos = { 1, 6, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Yaxis },
	{ pos = { 0, 6, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Left },

	{ pos = { 4, -1, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Top },
	{ pos = { 5, 0, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Zaxis },
	{ pos = { 6, 1, 1 }, id = 2772, aid = Storage.DesertQuestTwo.Puzzles.RubiksCube.Bottom },
}

local expReward = {
	{ pos = { 11, -77, 2 }, id = 28179, aid = Storage.DesertQuestTwo.Rewards.ExpReward, expReward = 1000 * 500, rewards = {} },
	{ pos = { 10, -76, 2 }, id = 5674, aid = Storage.DesertQuestTwo.Rewards.ChestOne, expReward = 1000 * 500, rewards = { { id = 3029, count = 50 }, { id = 5785 }, { id = 3438 } } },
	{ pos = { 8, -73, 2 }, id = 5674, aid = Storage.DesertQuestTwo.Rewards.ChestTwo, expReward = 1000 * 500, rewards = { { id = 3043, count = 4 } } },
	--{ pos = { 8, -73, 2 }, id = 5674, aid = Storage.DesertQuestTwo.Rewards.ChestTwo, expReward = 1000 * 500, rewards = { { id = 2971, aid = Storage.DesertQuestThree.AccessKey }, { id = 6118, aid = Storage.DesertQuestThree.AccessMap } } },
}

local monsters = {
	{ pos = { 51, -16, 0 }, name = "fast moa" },
}

local desertQuestTwoInit = GlobalEvent("desertQuestTwoInit")
function desertQuestTwoInit.onStartup()
	LoadStartupItems(static)
	LoadStartupItems(rubiksCube, RUBIKS_CUBE_ANCHOR)

	LoadStartupItems(puzzles, DESERT_QUEST_TWO_ANCHOR)
	LoadStartupMonsters(monsters, DESERT_QUEST_TWO_ANCHOR)
	LoadStartupItems(expReward, DESERT_QUEST_TWO_ANCHOR)

	InitializeDQ2chests()
	InitializeDQ2Labryrinth()
	InitializeDQ2FifteenPuzzle()
	InitializeDQ2PipePuzzle()
	InitializeDQ2IndeticalRooms()
	InitializeDQ2RubiksCube()
	InitializeDQ2orbs()
end
desertQuestTwoInit:register()
end)
