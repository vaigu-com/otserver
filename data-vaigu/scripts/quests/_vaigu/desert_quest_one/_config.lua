DESERT_QUEST_ONE_KEY_ITEMS = {}

-- #region tables format: [actionid] = {pos}

DESERT_QUEST_ONE_SKIPS = {
	[Storage.DesertQuestOne.QuestState.q2] = Vector(71, 88, 0), -- main hub -> past 4 mwalls
	[Storage.DesertQuestOne.QuestState.q3] = Vector(-9, -4, 1), -- brazier -> key shaft
	[Storage.DesertQuestOne.QuestState.q5] = Vector(-21, 69, 2), -- void castle -> ice skating
	[Storage.DesertQuestOne.QuestState.q7] = Vector(-27, 110, 2), -- dont break ice -> monster guiding
	[Storage.DesertQuestOne.QuestState.q8] = Vector(17, 160, 1), -- monster guiding -> water flow
	[Storage.DesertQuestOne.QuestState.q9] = Vector(-59, 148, 2), -- water flow -> movable tiles
	[Storage.DesertQuestOne.QuestState.q10] = Vector(-39, -9, 1), -- movable tiles -> rainbow room
}

DESERT_QUEST_ONE_PORTALS = {
	[Storage.DesertQuestOne.Portals.ToBrazier] = Vector(73, 118, 1), -- past 4 mwalls -> brazier
	[Storage.DesertQuestOne.Portals.FinalPuzzle] = Vector(-115, 138, 2), -- rainbow room -> final problem
	[Storage.DesertQuestOne.Portals.PenaltyRoom1] = Vector(36, 22, 2), -- penalty room 1
	[Storage.DesertQuestOne.Portals.PenaltyRoom2] = Vector(62, 30, 2), -- penalty room 2, since after first mwalls
	[Storage.DesertQuestOne.Portals.PenaltyRoom3] = Vector(96, 36, 2), -- penalty room 4, since rainbow room
	[Storage.DesertQuestOne.Portals.EkEdRoom] = Vector(-35, 65, 0), -- eked
	[Storage.DesertQuestOne.Portals.RpMsRoom] = Vector(-84, -13, -1), -- rpms
	[Storage.DesertQuestOne.Portals.MainHub] = Vector(71, 80, 0), -- hub
	[Storage.DesertQuestOne.Portals.IceRoomStart] = Vector(-23, 67, 3), -- icestart
	[Storage.DesertQuestOne.Portals.IceRoomReward] = Vector(-19, 64, 3), -- icereward
	[Storage.DesertQuestOne.Portals.FinalPuzzle] = Vector(-115, 138, 2), -- final problem
	[Storage.DesertQuestOne.Portals.RewardRoom] = Vector(-125, 135, 4), -- reward room
}

DESERT_QUEST_ONE_PERSONAL_MWALLS = {
	[Storage.DesertQuestOne.Puzzles.VocPuzzle.EkLever] = Vector(71, 84, 0),
	[Storage.DesertQuestOne.Puzzles.VocPuzzle.EdLever] = Vector(71, 85, 0),
	[Storage.DesertQuestOne.Puzzles.VocPuzzle.MsLever] = Vector(71, 86, 0),
	[Storage.DesertQuestOne.Puzzles.VocPuzzle.RpLever] = Vector(71, 87, 0),
}

DESERT_QUEST_ONE_SPAWN_KEY_SHAFT = {
	{ offPos = Vector(0, 0, 0), id = 6252 },
	{ offPos = Vector(1, 0, 0), id = 6252 },
	{ offPos = Vector(2, 0, 0), id = 6252 },
	{ offPos = Vector(3, 0, 0), id = 6252 },
	{ offPos = Vector(4, 0, 0), id = 6252 },
	{ offPos = Vector(5, 0, 0), id = 6252 },
	{ offPos = Vector(6, 0, 0), id = 6252 },
	{ offPos = Vector(7, 0, 0), id = 6252 },
	{ offPos = Vector(8, 0, 0), id = 6252 },
	{ offPos = Vector(9, 0, 0), id = 6252 },
	{ offPos = Vector(10, 0, 0), id = 6252 },
	{ offPos = Vector(11, 0, 0), id = 6252 },
}

DESERT_QUEST_ONE_KEY_SHAFT_COMBINATION = {
	{ offPos = Vector(0, 0, 0), id = 6252 },
	{ offPos = Vector(1, 0, 0), id = 6253 },
	{ offPos = Vector(2, 0, 0), id = 6252 },
	{ offPos = Vector(3, 0, 0), id = 6252 },
	{ offPos = Vector(4, 0, 0), id = 6253 },
	{ offPos = Vector(5, 0, 0), id = 6252 },
	{ offPos = Vector(6, 0, 0), id = 6252 },
	{ offPos = Vector(7, 0, 0), id = 6253 },
	{ offPos = Vector(8, 0, 0), id = 6252 },
	{ offPos = Vector(9, 0, 0), id = 6253 },
	{ offPos = Vector(10, 0, 0), id = 6252 },
	{ offPos = Vector(11, 0, 0), id = 6253 },
}

DESERT_QUEST_ONE_KEY_BOW_VERTICAL_UNMOVED = {
	{ offPos = Vector(-1, 0, 0), id = 2162 },
	{ offPos = Vector(12, 0, 0), id = 1295 },
	{ offPos = Vector(13, 0, 0), id = 1295 },
	{ offPos = Vector(14, 0, 0), id = 470 },
	{ offPos = Vector(15, 0, 0), id = 1295 },
	{ offPos = Vector(13, 0, -1), id = 1295 },
	{ offPos = Vector(14, 0, -1), id = 1295 },
	{ offPos = Vector(15, 0, -1), id = 1295 },
	{ offPos = Vector(13, 0, 1), id = 1295 },
	{ offPos = Vector(14, 0, 1), id = 1295 },
	{ offPos = Vector(15, 0, 1), id = 1295 },
	{ offPos = Vector(-1, 0, 0), id = 28912 },
	{ offPos = Vector(0, 0, 0), id = 28912 },
	{ offPos = Vector(1, 0, 0), id = 28912 },
}
DESERT_QUEST_ONE_KEY_BOW_VERTICAL_MOVED = {
	{ offPos = Vector(-3, 0, 0), id = 1295 },
	{ offPos = Vector(-2, 0, 0), id = 1295 },
	{ offPos = Vector(0, 0, 0), id = 1295 },

	{ offPos = Vector(-2, 0, -1), id = 1295 },
	{ offPos = Vector(-1, 0, -1), id = 1295 },
	{ offPos = Vector(0, 0, -1), id = 1295 },

	{ offPos = Vector(-2, 0, 1), id = 1295 },
	{ offPos = Vector(-1, 0, 1), id = 1295 },
	{ offPos = Vector(0, 0, 1), id = 1295 },
}

DESERT_QUEST_ONE_KEY_BOW_HORIZONTAL = {
	{ offPos = Vector(-2, -1, 0), id = 4514 },
	{ offPos = Vector(-1, -1, 0), id = 4511 },
	{ offPos = Vector(-1, -1, 0), id = 4512 },
	{ offPos = Vector(0, -1, 0), id = 4513 },
	{ offPos = Vector(1, -1, 0), id = 298 },
	{ offPos = Vector(-3, 0, 0), id = 4403 },
	{ offPos = Vector(-2, 0, 0), id = 4513 },
	{ offPos = Vector(-2, 0, 0), id = 4511 },
	{ offPos = Vector(-1, 0, 0), id = 4510 },
	{ offPos = Vector(-1, 0, 0), id = 4507 },
	{ offPos = Vector(-1, 0, 0), id = 4508 },
	{ offPos = Vector(-1, 0, 0), id = 4509 },
	{ offPos = Vector(0, 0, 0), id = 4512 },
	{ offPos = Vector(0, 0, 0), id = 4514 },
	{ offPos = Vector(1, 0, 0), id = 295 },
	{ offPos = Vector(-2, 1, 0), id = 4512 },
	{ offPos = Vector(-1, 1, 0), id = 4514 },
	{ offPos = Vector(-1, 1, 0), id = 4513 },
	{ offPos = Vector(0, 1, 0), id = 4511 },
	{ offPos = Vector(1, 1, 0), id = 296 },
}

DESERT_QUEST_ONE_IRON_WALL = {
	{ offPos = Vector(5, -7, 0), id = 8349 },
	{ offPos = Vector(6, -7, 0), id = 8349 },
	{ offPos = Vector(7, -7, 0), id = 8349 },
	{ offPos = Vector(5, -7, 1), id = 8349 },
	{ offPos = Vector(6, -7, 1), id = 8349 },
	{ offPos = Vector(7, -7, 1), id = 8349 },
	{ offPos = Vector(5, -7, -1), id = 8349 },
	{ offPos = Vector(6, -7, -1), id = 8349 },
	{ offPos = Vector(7, -7, -1), id = 8349 },
}

DESERT_QUEST_ONE_EK_ED_STATUES = {
	{ offPos = Vector(-27, 53, 0), id = 2061 },
	{ offPos = Vector(-23, 53, 0), id = 2059 },
	{ offPos = Vector(-25, 55, 0), id = 2060 },
	{ offPos = Vector(-25, 51, 0), id = 2025 },
}

DESERT_QUEST_ONE_EK_ED_SPAWN_STATUES = {
	{ offPos = Vector(-48, 55, 0), id = 2025 },
	{ offPos = Vector(-34, 51, 0), id = 2025 },
	{ offPos = Vector(-46, 68, 0), id = 2025 },
	{ offPos = Vector(-24, 59, 0), id = 2025 },
}
DESERT_QUEST_ONE_EK_ED_MWALLS = {
	{ offPos = Vector(-60, 38, 0), id = 2129 },
	{ offPos = Vector(-60, 77, 0), id = 2129 },
}

DESERT_QUEST_ONE_MS_RP_MWALLS = {
	["MWALL"] = { offPos = Vector(-85, -73, 0), id = 2129 },
	["STONE"] = { offPos = Vector(-117, -33, -1), id = 1791 },
}

DESERT_QUEST_ONE_CASTLE_WALLS = {
	{ offPos = Vector(9, -47, -2), id = 1451 },
	{ offPos = Vector(10, -47, -2), id = 8375 },
	{ offPos = Vector(11, -47, -2), id = 8219 },
}

DESERT_QUEST_ONE_CASTLE_NEW_WALLS = {
	{ offPos = Vector(9, -47, -2), id = 1493 },
	{ offPos = Vector(11, -47, -2), id = 8378 },
}

DESERT_QUEST_ONE_CASTLE_TORCHES_LIT = {
	{ offPos = Vector(18, -54, -2), id = 2929 },
	{ offPos = Vector(12, -49, -1), id = 2929 },
	{ offPos = Vector(10, -43, -1), id = 2929 },
	{ offPos = Vector(9, -42, 0), id = 2929 },
	{ offPos = Vector(14, -49, 1), id = 2929 },
	{ offPos = Vector(26, -53, 1), id = 2929 },
	{ offPos = Vector(20, -42, 2), id = 2929 },
}

DESERT_QUEST_ONE_CASTLE_TORCHES_UNLIT = {
	{ offPos = Vector(18, -54, -2), id = 2928 },
	{ offPos = Vector(12, -49, -1), id = 2928 },
	{ offPos = Vector(10, -43, -1), id = 2928 },
	{ offPos = Vector(9, -42, 0), id = 2928 },
	{ offPos = Vector(14, -49, 1), id = 2928 },
	{ offPos = Vector(26, -53, 1), id = 2928 },
	{ offPos = Vector(20, -42, 2), id = 2928 },
}

DESERT_QUEST_ONE_BASIN_OFFERINGS = {
	{ offPos = Vector(78, 113, 1), id = 3059 },
	{ offPos = Vector(68, 113, 1), id = 3585 },
	{ offPos = Vector(73, 117, 1), id = 3264 },
	{ offPos = Vector(73, 108, 1), id = 3349 },
}

DESERT_QUEST_ONE_BASIN_PLAYERS = {
	Vector(76, 113, 1),
	Vector(70, 113, 1),
	Vector(73, 116, 1),
	Vector(73, 110, 1),
}

DESERT_QUEST_ONE_CASTLE_LEVER_POS_ITEMS = {
	{ offPos = Vector(5, -43, -2), id = 2129 },
	{ offPos = Vector(19, -51, -2), id = 162 },
	{ offPos = Vector(14, -46, 0), id = 2129 },
	{ offPos = Vector(9, -39, 0), id = 2129 },
	{ offPos = Vector(11, -42, 2), id = 2129 },
	{ offPos = Vector(26, -46, 1), id = 2129 },
	{ offPos = Vector(26, -51, 1), id = 2129 },
}

DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED = {
	{ offPos = Vector(86, 61, -2), id = 5262 },
	{ offPos = Vector(86, 61, -2), id = 8342 },
	{ offPos = Vector(86, 61, -2), id = 1616 },
	{ offPos = Vector(86, 61, -2), id = 8347 },
}

DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN = {

	{ offPos = Vector(87, 60, -2), id = 5262 },
	{ offPos = Vector(87, 60, -2), id = 1611 },

	{ offPos = Vector(87, 60, -2), id = 8349 },
}

DESERT_QUEST_ONE_CASTLE_SWAP_LIST = {
	[2129] = 0,
	[162] = 167,
	[2182] = 0,
	[2772] = 2773,
	[2773] = 2772,
	[1971] = 1972,
	[1972] = 1971,
}
DESERT_QUEST_ONE_MONSTER_GUIDING = {
	top_left = Vector(-33, 98, 2),
	down_right = Vector(-28, 106, 2),
	monster = { name = "wisp", spawn_pos = Vector(-32, 100, 2), pressure_plate_pos = { x = -33, y = 106, z = 2 } },
	fence = { pos = Vector(-24, 91, 2), id = 2182 },

	stonesAnchor = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -22, y = 98, z = 1 }),
	stones_pos = {
		origin = {
			[8] = { offPos = Vector(-23, 98, 1), id = 1841 },
			-- [2] = nil,
			[3] = { offPos = Vector(-23, 100, 1), id = 1842 },
			[9] = { offPos = Vector(-23, 101, 1), id = 1791 },
			[6] = { offPos = Vector(-23, 102, 1), id = 1841 },
			[7] = { offPos = Vector(-23, 103, 1), id = 1842 },
			[1] = { offPos = Vector(-23, 104, 1), id = 1791 },
			[5] = { offPos = Vector(-23, 105, 1), id = 1841 },
			[4] = { offPos = Vector(-23, 106, 1), id = 1842 },
		},
		destination = {
			[8] = { offPos = Vector(-31, 98, 2), id = 1841 },
			-- [2] = nil,
			[3] = { offPos = Vector(-28, 100, 2), id = 1842 },
			[9] = { offPos = Vector(-30, 101, 2), id = 1791 },
			[6] = { offPos = Vector(-28, 102, 2), id = 1841 },
			[7] = { offPos = Vector(-30, 103, 2), id = 1842 },
			[1] = { offPos = Vector(-32, 104, 2), id = 1791 },
			[5] = { offPos = Vector(-32, 105, 2), id = 1841 },
			[4] = { offPos = Vector(-30, 106, 2), id = 1842 },
		},
	},
}

DESERT_QUEST_ONE_DONT_BREAK_ICE = {
	start_pos = Vector(-3, 44, 2),
	boards = {
		top_left = {
			[409] = Vector(-5, 8, 2),
			[429] = Vector(-8, 18, 2),
			[20712] = Vector(-6, 26, 2),
			[936] = Vector(-5, 32, 2),
			[923] = Vector(-5, 38, 2),
		},
		down_right = {
			[409] = Vector(2, 14, 2),
			[429] = Vector(2, 22, 2),
			[20712] = Vector(0, 28, 2),
			[936] = Vector(-1, 34, 2),
			[923] = Vector(-1, 42, 2),
		},
	},
	ice_y_to_board = {
		[8] = 409,
		[9] = 409,
		[10] = 409,
		[11] = 409,
		[12] = 409,
		[13] = 409,
		[14] = 409,

		[18] = 429,
		[19] = 429,
		[20] = 429,
		[21] = 429,
		[22] = 429,

		[26] = 20712,
		[27] = 20712,
		[28] = 20712,

		[32] = 936,
		[33] = 936,
		[34] = 936,

		[38] = 923,
		[39] = 923,
		[40] = 923,
		[41] = 923,
		[42] = 923,
	},
}

DESERT_QUEST_ONE_ICE_SKATING = {
	players_pos = { Vector(-17, 61, 2), Vector(-22, 54, 2), { x = -29, y = 46, z = 2 } },
	stone = { pos = Vector(-21, 57, 2), id = 6720 },
	skating_floor = { id = 6967 },
	black_marble = { id = 410 },
}

DESERT_QUEST_ONE_WATER_FLOW = {
	watering_rate = 6,
	pipe_ready = 20673,
	pipe_cooldown = 20675,
	pipe_pos = Vector(11, 142, 1),
	dry_id = 464,
	nothing_special = 470,
	water_id = 622,
	start_pos = Vector(12, 142, 1),
	dead_tree_id = 3698,
	vivid_tree_id = 3699,
	vivid_tree_positions = {
		{ offPos = Vector(0, 130, 2), id = 3699 },
		{ offPos = Vector(22, 130, 2), id = 3699 },
		{ offPos = Vector(0, 152, 2), id = 3699 },
		{ offPos = Vector(22, 152, 2), id = 3699 },
	},
	final_gate = {
		{ offPos = { x = 17, y = 158, z = 1, stackpos = 0 }, id = 18580 },
		{ offPos = { x = 17, y = 158, z = 1, stackpos = 0 }, id = 18587 },
	},
	tileArrayTopLeft = DESERT_QUEST_ONE_ANCHOR:Moved(0, 130, 2),
	tileArrayDownRight = DESERT_QUEST_ONE_ANCHOR:Moved(22, 152, 2),
	idToRevealedPositions = { [936] = {}, [410] = {}, [20712] = {}, [409] = {}, [13436] = {}, [15468] = {} },
}

DESERT_QUEST_ONE_VOC_DOORS = {
	["ms"] = Storage.DesertQuestOne.VocTiles.MsTile,
	["rp"] = Storage.DesertQuestOne.VocTiles.RpTile,
	["ed"] = Storage.DesertQuestOne.VocTiles.EdTile,
	["ek"] = Storage.DesertQuestOne.VocTiles.EkTile,
}

DESERT_QUEST_ONE_LEVER_SWAP_LIST = {
	[2772] = 2773,
	[2773] = 2772,
}

DESERT_QUEST_ONE_HOIST = { up = Vector(6, -26, -2), down = { x = 6, y = -26, z = 1 } }

DESERT_QUEST_ONE_BASIN_OPENING = { pos = Vector(73, 113, 1), sealedId = 429, stairsId = 566 }

DESERT_QUEST_ONE_CASTLE_LEVER_GROUPS = {
	[Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever1] = { 1, 7, 6 },
	[Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever2] = { 2, 1, 7 },
	[Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever3] = { 3, 2, 1 },
	[Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever4] = { 4, 3, 2 },
	[Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever5] = { 5, 4, 3 },
	[Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever6] = { 6, 5, 4 },
	[Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever7] = { 7, 6, 5 },
}

DESERT_QUEST_ONE_CASTLE_SWAP_LIST = {
	[2129] = 0,
	[162] = 167,
	[2182] = 0,
	[2772] = 2773,
	[2773] = 2772,
	[1971] = 1972,
	[1972] = 1971,
}