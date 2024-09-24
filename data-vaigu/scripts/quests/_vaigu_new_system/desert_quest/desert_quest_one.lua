local quest = Quest("desert_quest_one")
quest
	:Constant(function()
		DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED = 8261
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
			monster = {
				name = "wisp",
				spawn_pos = Vector(-32, 100, 2),
				pressure_plate_pos = { x = -33, y = 106, z = 2 },
			},
			fence = { pos = Vector(-24, 91, 2), id = 2182 },

			stonesAnchor = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -22, y = 98, z = 1 }),
			stonesPos = {
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
			playersPos = { Vector(-17, 61, 2), Vector(-22, 54, 2), { x = -29, y = 46, z = 2 } },
			stone = { pos = Vector(-21, 57, 2), id = 6720 },
			skatingFloor = { id = 6967 },
			blackMarble = { id = 410 },
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
			finalGate = {
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
	end)
	:Storage(function()
		Storage.DesertQuestHub.ToDesertQuestOne = NextStorage()
		Storage.Finished.DesertQuestOne = NextStorage()
		Storage.DesertQuestOne = {
			Questline = NextStorage(),
			QuestState = {
				q1 = NextStorage(),
				q2 = NextStorage(),
				q3 = NextStorage(),
				q4 = NextStorage(),
				q5 = NextStorage(),
				q6 = NextStorage(),
				q7 = NextStorage(),
				q8 = NextStorage(),
				q9 = NextStorage(),
				q10 = NextStorage(),
				q11 = NextStorage(),
				q12 = NextStorage(),
			},
			DoorKeys = {
				Library = NextStorage(),
				VocKey1 = NextStorage(),
				VocKey2 = NextStorage(),
			},
			VocTiles = {
				MsTile = NextStorage(),
				EkTile = NextStorage(),
				EdTile = NextStorage(),
				RpTile = NextStorage(),
			},
			Portals = {
				PenaltyRoom1 = NextStorage(),
				PenaltyRoom2 = NextStorage(),
				PenaltyRoom3 = NextStorage(),
				IceRoomStart = NextStorage(),
				IceRoomReward = NextStorage(),
				FinalPuzzle = NextStorage(),
				RewardRoom = NextStorage(),
				MainHub = NextStorage(),
				EkEdRoom = NextStorage(),
				RpMsRoom = NextStorage(),
				ToBrazier = NextStorage(),
			},
			Rewards = {
				VocRoomsKey1 = NextStorage(),
				VocRoomsKey2 = NextStorage(),
				LibraryKey = NextStorage(),

				FinalChestChessbox = NextStorage(),
				FinalChestCrystals = NextStorage(),
				FinalExpBox = NextStorage(),
				HiddenLibraryBush = NextStorage(),
				HiddenInBoxesRoom = NextStorage(),
				HiddenLibraryFloor = NextStorage(),
				HiddenFloatingKey = NextStorage(),
				HiddenUnderIgloo = NextStorage(),
				HiddenUnderTree = NextStorage(),
			},
			Readable = {
				FloorBooks = NextStorage(),
				ToStartSign = NextStorage(),
				ShortcutSign = NextStorage(),
			},
			Puzzles = {
				VocPuzzle = {
					GoodSign = NextStorage(),
					BadSign = NextStorage(),
					PortalIdenticalRooms = NextStorage(),
					EkEdStatue = NextStorage(),
					MsRpPressure = NextStorage(),
					EkLever = NextStorage(),
					EdLever = NextStorage(),
					MsLever = NextStorage(),
					RpLever = NextStorage(),
				},
				BasinPuzzle = { Lever = NextStorage(), StairsGlobal = NextStorage() },
				KeyshaftPuzzle = {
					LeverPutIn = NextStorage(),
					LeverTurn = NextStorage(),
				},
				CastlePuzzle = {
					Lever1 = NextStorage(),
					Lever2 = NextStorage(),
					Lever3 = NextStorage(),
					Lever4 = NextStorage(),
					Lever5 = NextStorage(),
					Lever6 = NextStorage(),
					Lever7 = NextStorage(),
					Gravestone = NextStorage(),
					ElevatorToDown = NextStorage(),
					ElevatorToUp = NextStorage(),
				},
				SkatingPuzzle = {
					IceTile = NextStorage(),
					StopTile = NextStorage(),
					Lever = NextStorage(),
				},
				BreakIcePuzzle = {
					IceTile = NextStorage(),
					TeleportTile = NextStorage(),
				},
				GuidingPuzzle = {
					SacrificeGp = NextStorage(),
					SacrificeWisp = NextStorage(),
					ManipulateStone = NextStorage(),
				},
				WaterFlowPuzzle = {
					PipeValve = NextStorage(),
					RevealingTile = NextStorage(),
					TreeLever = NextStorage(),
				},
				MovableTilesPuzzle = { Lever = NextStorage() },
				ChoosePortalPuzzle = { CorrectPortal = NextStorage() },
				DirectionalPortalPuzzle = { Tile = NextStorage() },
			},
		}
	end)
	:Questlog(function()
		-- None
	end)
	:Scripts(function()
		local startupItems = {
			questDoors = {
				{
					pos = { 68, 81, 0 },
					aid = Storage.DesertQuestOne.QuestState.q2,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { 73, 121, 1 },
					aid = Storage.DesertQuestOne.QuestState.q3,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { 14, -3, 1 },
					aid = Storage.DesertQuestOne.QuestState.q4,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { 5, -36, -2 },
					aid = Storage.DesertQuestOne.QuestState.q5,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { -13, 67, 2 },
					aid = Storage.DesertQuestOne.QuestState.q6,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { 3, 44, 2 },
					aid = Storage.DesertQuestOne.QuestState.q7,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { -36, 96, 2 },
					aid = Storage.DesertQuestOne.QuestState.q8,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { 15, 154, 2 },
					aid = Storage.DesertQuestOne.QuestState.q9,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
				{
					pos = { -59, 139, 2 },
					aid = Storage.DesertQuestOne.QuestState.q10,
					id = DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED,
				},
			},

			keysDoors = {
				{ pos = { 99, 85, -1 }, id = 9560, aid = Storage.DesertQuestOne.DoorKeys.Library },
				{ pos = { 36, 69, 1 }, id = 8252, aid = Storage.DesertQuestOne.DoorKeys.VocKey1 },
				{ pos = { 36, 71, 1 }, id = 8252, aid = Storage.DesertQuestOne.DoorKeys.VocKey2 },
			},

			questTiles = {
				{ pos = { 93, 61, -1 }, id = 355, aid = Storage.DesertQuestOne.QuestState.q1 },
				{ pos = { 71, 88, 0 }, id = 353, aid = Storage.DesertQuestOne.QuestState.q2 },
				{ pos = { 5, -7, 1 }, id = 231, aid = Storage.DesertQuestOne.QuestState.q4 },
				{ pos = { 6, -7, 1 }, id = 231, aid = Storage.DesertQuestOne.QuestState.q4 },
				{ pos = { 7, -7, 1 }, id = 231, aid = Storage.DesertQuestOne.QuestState.q4 },
				{ pos = { -21, 69, 2 }, id = 6581, aid = Storage.DesertQuestOne.QuestState.q5 },

				{ pos = { -19, 57, 2 }, id = 6582, aid = Storage.DesertQuestOne.QuestState.q6 },

				{ pos = { -27, 110, 2 }, id = 17506, aid = Storage.DesertQuestOne.QuestState.q7 },
				{ pos = { 17, 160, 1 }, id = 16488, aid = Storage.DesertQuestOne.QuestState.q8 },
				{ pos = { -59, 148, 2 }, id = 429, aid = Storage.DesertQuestOne.QuestState.q9 },
				{ pos = { -39, -9, 1 }, id = 409, aid = Storage.DesertQuestOne.QuestState.q10 },
				{ pos = { -115, 138, 2 }, id = 8230, aid = Storage.DesertQuestOne.QuestState.q11 },
			},

			portals = {
				{ pos = { 69, 129, 1 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { 75, 125, 1 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { 54, 81, 1 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { 60, 81, 1 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { 57, 84, 1 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -87, 38, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -111, 38, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -135, 38, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -183, 38, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -189, 80, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -165, 80, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -117, 80, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -93, 80, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -140, -60, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -116, -34, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -140, -34, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -140, -60, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -164, -60, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -164, -34, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -188, -60, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -212, -60, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { -212, -34, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },
				{ pos = { 32, 74, 2 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom1 },

				{ pos = { 73, 113, 2 }, id = 1949, aid = Storage.DesertQuestOne.Portals.PenaltyRoom2 },

				{ pos = { -33, -14, 1 }, id = 10840, aid = Storage.DesertQuestOne.Portals.PenaltyRoom3 },
				{ pos = { -30, -13, 1 }, id = 23484, aid = Storage.DesertQuestOne.Portals.PenaltyRoom3 },
				{ pos = { -36, -11, 1 }, id = 23482, aid = Storage.DesertQuestOne.Portals.PenaltyRoom3 },
				{ pos = { -31, -10, 1 }, id = 22761, aid = Storage.DesertQuestOne.Portals.PenaltyRoom3 },
				{ pos = { -32, -9, 1 }, id = 19799, aid = Storage.DesertQuestOne.Portals.PenaltyRoom3 },
				{ pos = { -33, -8, 1 }, id = 23483, aid = Storage.DesertQuestOne.Portals.PenaltyRoom3 },

				{ pos = { 24, 82, 2 }, id = 1949, aid = Storage.DesertQuestOne.Portals.RpMsRoom },
				{ pos = { 17, 67, 2 }, id = 1949, aid = Storage.DesertQuestOne.Portals.EkEdRoom },
				{ pos = { -136, 80, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.MainHub },
				{ pos = { -159, 34, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.MainHub },
				{ pos = { -116, -58, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.MainHub },
				{ pos = { -190, -30, 0 }, id = 1949, aid = Storage.DesertQuestOne.Portals.MainHub },

				{ pos = { -24, 63, 3 }, id = 1949, aid = Storage.DesertQuestOne.Portals.IceRoomStart },

				{ pos = { 73, 128, 1 }, id = 1949, aid = Storage.DesertQuestOne.Portals.ToBrazier },
				{ pos = { -1, 4, 2 }, id = 1949, aid = Storage.DesertQuestOne.QuestState.q7 },
				{ pos = { -24, 90, 2 }, id = 1949, aid = Storage.DesertQuestOne.QuestState.q8 },
				{ pos = { 17, 158, 1 }, id = 1949, aid = Storage.DesertQuestOne.QuestState.q9 },
				{ pos = { -55, 158, 2 }, id = 1949, aid = Storage.DesertQuestOne.QuestState.q10 },

				{ pos = { -16, 65, 0 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -21, 72, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { 39, 33, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -44, -7, 1 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { 12, -35, -2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { 96, 41, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -50, -82, -1 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { 61, 42, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { 19, 161, 1 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { 74, 106, 1 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -11, -5, 1 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -46, 141, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -105, 168, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -8, 44, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -23, 108, 2 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
				{ pos = { -87, 135, 4 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },

				{ pos = { -106, 108, 2 }, id = 1949, aid = Storage.DesertQuestOne.Portals.RewardRoom },
			},
			normalSings = {
				{
					pos = { 69, 81, 0 },
					id = 2023,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},
				{
					pos = { 2, 45, 2 },
					id = 2024,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},
				{
					pos = { 14, 155, 2 },
					id = 2024,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},
				{
					pos = { 13, -2, 1 },
					id = 2024,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},
				{
					pos = { 6, -36, -2 },
					id = 2023,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},
				{
					pos = { -14, 67, 2 },
					id = 2023,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},
				{
					pos = { -38, 96, 2 },
					id = 2023,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},
				{
					pos = { -60, 140, 2 },
					id = 2024,
					aid = Storage.DesertQuestOne.Readable.ShortcutSign,
					desc = "SHORTCUT_SIGN",
				},

				{
					pos = { 18, 161, 1 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -17, 65, 0 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { 72, 106, 1 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -24, 108, 2 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -45, -7, 1 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { 11, -35, -2 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -12, -5, 1 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -106, 168, 2 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -9, 44, 2 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -22, 72, 2 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
				{
					pos = { -47, 141, 2 },
					id = 2014,
					aid = Storage.DesertQuestOne.Readable.ToStartSign,
					desc = "TO_START_SIGN",
				},
			},
			vocTiles = {
				{ pos = { -95, -61, -1 }, id = 409, aid = Storage.DesertQuestOne.VocTiles.RpTile },
				{ pos = { 12, 129, 1 }, id = 409, aid = Storage.DesertQuestOne.VocTiles.RpTile },
				{ pos = { -27, 141, 2 }, id = 409, aid = Storage.DesertQuestOne.VocTiles.RpTile },
				{ pos = { 24, 79, 2 }, id = 409, aid = Storage.DesertQuestOne.VocTiles.RpTile },

				{ pos = { 25, 79, 2 }, id = 5815, aid = Storage.DesertQuestOne.VocTiles.MsTile },
				{ pos = { -95, -41, 0 }, id = 5815, aid = Storage.DesertQuestOne.VocTiles.MsTile },
				{ pos = { -36, 144, 2 }, id = 12379, aid = Storage.DesertQuestOne.VocTiles.MsTile },
				{ pos = { -34, 138, 2 }, id = 12379, aid = Storage.DesertQuestOne.VocTiles.MsTile },
				{ pos = { -32, 143, 2 }, id = 12379, aid = Storage.DesertQuestOne.VocTiles.MsTile },
				{ pos = { -29, 137, 2 }, id = 12379, aid = Storage.DesertQuestOne.VocTiles.MsTile },
				{ pos = { -28, 137, 2 }, id = 12379, aid = Storage.DesertQuestOne.VocTiles.MsTile },

				{ pos = { -36, 133, 2 }, id = 13431, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { -32, 134, 2 }, id = 13431, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { -33, 139, 2 }, id = 13431, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { -29, 140, 2 }, id = 13431, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { -28, 140, 2 }, id = 13431, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { 25, 142, 1 }, id = 108, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { 25, 142, 1 }, id = 108, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { 21, 72, 2 }, id = 108, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { -57, 40, 0 }, id = 108, aid = Storage.DesertQuestOne.VocTiles.EdTile },

				{ pos = { 21, 71, 2 }, id = 410, aid = Storage.DesertQuestOne.VocTiles.EkTile },
				{ pos = { -1, 142, 1 }, id = 410, aid = Storage.DesertQuestOne.VocTiles.EkTile },
				{ pos = { -27, 136, 2 }, id = 410, aid = Storage.DesertQuestOne.VocTiles.EkTile },
				{ pos = { -59, 74, 0 }, id = 410, aid = Storage.DesertQuestOne.VocTiles.EkTile },
			},

			vocPuzzle = {
				{
					pos = { -117, -59, 1 },
					id = 2017,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign,
				},
				{
					pos = { -189, -32, 1 },
					id = 2017,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign,
				},
				{ pos = { -142, 81, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign },
				{ pos = { -160, 40, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign },

				{ pos = { -70, 81, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign },
				{ pos = { -64, 40, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign },
				{ pos = { -93, -32, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign },
				{ pos = { -93, -59, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.GoodSign },

				{ pos = { -94, 81, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -118, 81, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -166, 81, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -190, 81, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -184, 40, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -136, 40, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -112, 40, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -88, 40, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -117, -32, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -141, -32, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -165, -32, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -213, -32, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -213, -59, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -189, -59, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -165, -59, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },
				{ pos = { -141, -59, 1 }, id = 2017, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.BadSign },

				{
					pos = { -72, 89, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -96, 89, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -120, 89, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -144, 89, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -168, 89, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -66, 47, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -90, 47, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -114, 47, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -138, 47, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -162, 47, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -95, -25, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -119, -25, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -143, -25, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -167, -25, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -191, -25, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -95, -51, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -119, -51, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -143, -51, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -167, -51, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -191, -51, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -186, 47, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -192, 89, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -215, -51, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},
				{
					pos = { -215, -25, 1 },
					id = 1949,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms,
				},

				{ pos = { -25, 53, 0 }, id = 2031, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.EkEdStatue },

				{
					pos = { -112, -29, -1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.MsRpPressure,
				},
				{
					pos = { -82, -73, 0 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.VocPuzzle.MsRpPressure,
				},
				{ pos = { -140, 84, 0 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.EkLever },
				{ pos = { -163, 38, 0 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.EdLever },
				{ pos = { -186, -38, 0 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.MsLever },
				{ pos = { -117, -62, 0 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.VocPuzzle.RpLever },
			},

			basinPuzzle = {
				{ pos = { 73, 110, 1 }, id = 10145, aid = Storage.DesertQuestOne.VocTiles.RpTile },
				{ pos = { 70, 113, 1 }, id = 10145, aid = Storage.DesertQuestOne.VocTiles.EdTile },
				{ pos = { 76, 113, 1 }, id = 10145, aid = Storage.DesertQuestOne.VocTiles.MsTile },
				{ pos = { 73, 116, 1 }, id = 10145, aid = Storage.DesertQuestOne.VocTiles.EkTile },
				{ pos = { 73, 111, 1 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.BasinPuzzle.Lever },
			},

			keyshaftPuzzle = {
				{
					pos = { 5, 9, -1 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.KeyshaftPuzzle.LeverPutIn,
				},
				{
					pos = { 15, 5, -1 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.KeyshaftPuzzle.LeverTurn,
				},
			},

			castlePuzzle = {
				{
					pos = { 7, -26, 1 },
					id = 17944,
					actionid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.ElevatorToUp,
				},
				{
					pos = { 7, -26, -2 },
					id = 17940,
					actionid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.ElevatorToDown,
				},
				{ pos = { 19, -50, -1 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever1 },
				{ pos = { 4, -48, -2 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever2 },
				{ pos = { 11, -43, -1 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever3 },
				{ pos = { 7, -38, 0 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever4 },
				{ pos = { 10, -38, 1 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever5 },
				{ pos = { 23, -41, 2 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever6 },
				{ pos = { 25, -49, 1 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever7 },
				{
					pos = { 9, -43, -2 },
					id = 1982,
					actionid = Storage.DesertQuestOne.Puzzles.CastlePuzzle.Gravestone,
				},
			},

			skatingPuzzle = {
				{ pos = { -2, 64, 2 }, id = 2772, aid = Storage.DesertQuestOne.Puzzles.SkatingPuzzle.Lever },
			},

			breakIcePuzzle = {
				{
					pos = { -1, 7, 2 },
					id = 409,
					actionid = Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.TeleportTile,
				},
				{
					pos = { -3, 17, 2 },
					id = 429,
					actionid = Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.TeleportTile,
				},
				{
					pos = { -3, 25, 2 },
					id = 20712,
					actionid = Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.TeleportTile,
				},
				{
					pos = { -3, 31, 2 },
					id = 936,
					actionid = Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.TeleportTile,
				},
				{
					pos = { -3, 37, 2 },
					id = 923,
					actionid = Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.TeleportTile,
				},
			},

			guidingPuzzle = {
				{
					pos = { -34, 100, 2 },
					id = 2342,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.SacrificeGp,
				},
				{
					pos = { -33, 106, 2 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.SacrificeWisp,
				},
				{
					pos = { -22, 98, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
				{
					pos = { -22, 100, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
				{
					pos = { -22, 101, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
				{
					pos = { -22, 101, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
				{
					pos = { -22, 102, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
				{
					pos = { -22, 103, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
				{
					pos = { -22, 104, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
				{
					pos = { -22, 105, 1 },
					id = 431,
					actionid = Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone,
				},
			},
			waterFlowPuzzle = {
				{
					pos = { 10, 142, 1 },
					id = 21045,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.PipeValve,
				},
				{
					pos = { 18, 159, 1 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.TreeLever,
				},
				{
					pos = { -3, 143, 1 },
					id = 410,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile,
				},
				{
					pos = { -3, 141, 1 },
					id = 936,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile,
				},
				{
					pos = { 11, 127, 1 },
					id = 20712,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile,
				},
				{
					pos = { 13, 127, 1 },
					id = 409,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile,
				},
				{
					pos = { 27, 141, 1 },
					id = 13436,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile,
				},
				{
					pos = { 27, 143, 1 },
					id = 15468,
					actionid = Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile,
				},
			},

			movableTilesPuzzle = {
				{
					pos = { -36, 134, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -36, 135, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -36, 136, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -36, 138, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -36, 139, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -36, 141, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -36, 142, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -36, 143, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 134, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 135, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 136, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 138, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 139, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 141, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 142, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -28, 143, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -33, 131, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -32, 131, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -31, 131, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -33, 146, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -32, 146, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
				{
					pos = { -31, 146, 2 },
					id = 2772,
					actionid = Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever,
				},
			},
			choosePortalPuzzle = {
				{
					pos = { -36, -12, 1 },
					id = 22077,
					actionid = Storage.DesertQuestOne.Puzzles.ChoosePortalPuzzle.CorrectPortal,
				},
			},
			directionalPortalPuzzle = {
				{
					pos = { -115, 136, 2 },
					id = 410,
					actionid = Storage.DesertQuestOne.Puzzles.DirectionalPortalPuzzle.Tile,
				},
				{
					pos = { -113, 138, 2 },
					id = 410,
					actionid = Storage.DesertQuestOne.Puzzles.DirectionalPortalPuzzle.Tile,
				},
				{
					pos = { -117, 138, 2 },
					id = 410,
					actionid = Storage.DesertQuestOne.Puzzles.DirectionalPortalPuzzle.Tile,
				},
				{
					pos = { -115, 140, 2 },
					id = 410,
					actionid = Storage.DesertQuestOne.Puzzles.DirectionalPortalPuzzle.Tile,
				},
			},
			rewardChests = {
				{
					pos = { 97, 84, -1 },
					id = 2472,
					actionid = Storage.DesertQuestOne.Rewards.VocRoomsKey1,
					uid = 1000,
					rewards = { { id = 2969, aid = Storage.DesertQuestOne.DoorKeys.VocKey1 } },
				},
				{
					pos = { 43, 59, -1 },
					id = 2472,
					actionid = Storage.DesertQuestOne.Rewards.VocRoomsKey2,
					uid = 1000,
					rewards = { { id = 2968, aid = Storage.DesertQuestOne.DoorKeys.VocKey2 } },
				},
				{
					pos = { 57, 81, 1 },
					id = 2472,
					actionid = Storage.DesertQuestOne.Rewards.LibraryKey,
					uid = 1000,
					rewards = { { id = 2970, aid = Storage.DesertQuestOne.DoorKeys.Library } },
				},
				{
					pos = { -125, 131, 4 },
					id = 2472,
					actionid = Storage.DesertQuestOne.Rewards.FinalChestChessbox,
					uid = 1000,
					rewards = { { id = 18339 } },
				},
				{
					pos = { -123, 132, 4 },
					id = 2478,
					actionid = Storage.DesertQuestOne.Rewards.FinalChestCrystals,
					uid = 1000,
					rewards = { { id = 3068 }, { id = 3043, count = 4 }, { id = 3008 }, { id = 3007 }, { id = 3061 } },
				},
				{
					pos = { 89, 106, 1 },
					id = 2472,
					actionid = Storage.DesertQuestOne.Rewards.HiddenLibraryBush,
					uid = 1000,
					rewards = { { id = 3035, count = 30 } },
				},
				{
					pos = { 46, 49, 1 },
					id = 2472,
					actionid = Storage.DesertQuestOne.Rewards.HiddenInBoxesRoom,
					uid = 1000,
					rewards = { { id = 3035, count = 25 }, { id = 3052 }, { id = 3046 } },
				},
				{
					pos = { 101, 89, 0 },
					id = 2472,
					actionid = Storage.DesertQuestOne.Rewards.HiddenLibraryFloor,
					uid = 1000,
					rewards = { { id = 3035, count = 30 }, { id = 268, count = 10 } },
				},
				{
					pos = { 3, -13, 1 },
					id = 2472,
					aid = Storage.DesertQuestOne.Rewards.HiddenFloatingKey,
					uid = 1000,
					rewards = { { id = 3035, count = 40 } },
				},
				{
					pos = { -20, 62, 3 },
					id = 2478,
					actionid = Storage.DesertQuestOne.Rewards.HiddenUnderIgloo,
					uid = 1000,
					rewards = { { id = 3029, count = 30 }, { id = 3041 } },
				},
				{
					pos = { 19, 160, 2 },
					id = 2471,
					actionid = Storage.DesertQuestOne.Rewards.HiddenUnderTree,
					uid = 1000,
					rewards = { { id = 3035, count = 30 } },
				},
				{
					pos = { -120, 133, 4 },
					id = 21743,
					actionid = Storage.DesertQuestOne.Rewards.FinalExpBox,
					expReward = 1000 * 1000 * 1,
					rewards = {},
					nextState = { [Storage.Finished.CaveExplorerOnShield] = 1 },
				},
			},
		}

		local desertQuestInit = GlobalEvent("desertQuestOneInit")
		function desertQuestInit.onStartup()
			for key, value in pairs(startupItems) do
				LoadStartupItems(value, DESERT_QUEST_ONE_ANCHOR)
			end

			LoadDesertQuestBooks()
			LoadDesertQuestIceSkating()
			LoadDesertQuestBreakIce()
			FixRevealingTileArrays()
		end
		desertQuestInit:register()
	end)
	:Scripts(function()
		local portal = MoveEvent()

		function portal.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[item.actionid]))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		for _, actionId in pairs(Storage.DesertQuestOne.Portals) do
			portal:aid(actionId)
		end
		portal:type("stepin")
		portal:register()
	end)
	:Script(function(storageToRequiredState)
		local vectorToMessage = {
			["90, 66, -1"] = "I just discovered a pattern that will help me identify correct hints. Phantasms can use our human language, but they aren't fluent at it. Phantasms' hints can be identified by many linguistic errors  more or less obvious. Therefore if you encounter a message with a lot of errors, you can be sure it was forged by a phantasm. However, if you find a message with no mistakes at all, you can't be sure about its genuinity. It only works one way. \n\n~Page 57 of Germi Journal.",
			["71, 54, -1"] = "I tested the information left by Fifonz Kuciapa with my dog companion's assistance, and thanks to it we made it out alive with no problem at all. \n\n~Patrycja Suchodolska",
			["117, 103, -2"] = "I measured every array for every tile until I found the correct combination. The correct sign was the one located at the place second from the bottom. \n\n~Page 89 from Eustachy Wiertara journal",
			["96, 84, -1"] = "I analyzed a few things and I conclude that Patrycja Suchodolska's notes are trustworthy. ~Miroslaw of Ankhar",
			["54, 72, 0"] = "Main labyrinth with rewards. \n\n~Bogdan Boner",
			["52, 71, 0"] = "This hole leads to four sections for each class. \n\n~Sierotka Marysia.",
			["58, 75, 0"] = "One person has to watch over the one  going down this hole. \n\n~Patrycja Suchodolska",
			["51, 75, 0"] = "Way intended only for a druid. \n\n~Jan Pawel Drugi",
			["58, 72, 0"] = "The only people who can go there are those of the Intelligentsia group and read Olga Tokarczuk. \n\n~Anna Niewypchnieta",
			["61, 73, 0"] = "Way for all four classes. Stay close together. \n\n~Bogdan Boner",
			["55, 78, 0"] = "Sections for every individual class. \n\n~Anna Niewypchana",
			["47, 53, 1"] = "Milked a bull already?",
			["44, 50, 1"] = "Exani hur up x2 near stained glass.",
			["39, 66, 1"] = "Message left by Wojciech Szpara is intended to misdirect them from staying alive. \n\n~Sierotka Marysia",
			["25, 70, 2"] = "From my map i derived that nearby tiles will let through only people of certain professions. Past those, we found a portal leading to the room with a puzzle. If you pass the puzzle, you will be further split. At the end you will find yourself on an island with a lever. \n\n PS lever deactivates the magic wall in the main room of this dungeon, but only for about a minute. \n\n~page 65 from Germi journal",
			["34, 74, 2"] = "Upper doors is barred. Pleased use the door on the south. \n\n~Edward Tatarata",
			["55, 81, 1"] = "This teleport leeds back to the room above. \n\n~Bogdan Boner",
			["59, 81, 1"] = "This teleport leads back to room above. \n\n~Jan Pawel Drugi",
			["57, 83, 1"] = "You can have use this teleport to be escaped from the caves. \n\n~Wojciech Szpara",
			["57, 76, 1"] = "Turn out that Messages left by Sierotka Marysia are correct. \n\n~Miroslaw of Ankhar",
			["51, 109, -1"] = "In next room, for each portal not locatered next to a dead bush, its the correct portal.",
			["73, 114, 1"] = "Reward room entrence. \n\n~Bogdan Boner",
			["8, -46, -2"] = "Come back when its dimmed here.",
			["-2, 61, 2"] = "Something weird is happening to Cezary. The longer we stay there, the more he grows insane. If it wasn't for this i would probably marry him after we escape these tunnels... Sierotka Baryka Marysia... Anyway, I can still say that hints he is leaving are still intact and helpful. \n\n~Sierotka Marysia",
			["-35, 49, 2"] = "I realized about two facts: I have never heard about anyone making it out alive from this dungeon and there were a lot of hints left in past rooms. I couldn't find anything in this room yet. I should  be on guard. I'm writing this in the ice labyrinth. \n\n~Fifonz kuciapa",
			["-52, 125, 2"] = "##My ears are ringing still.\nI managed to turn off all portals but one.\n##I can't keep my balance, can't walk on my own.\nI think that no sound is coming out of that portal.\n\n##I'm gonna kill that useless loser, she is just slowing us down.\n\nI believe that I was there with someone. Perhaps it just my delusions.",
			["-21, 132, 2"] = "I found even more mysterious portals. There are voices coming from within persuading me to go in. My senses are going crazy. \n\n~Sierotka Marysia",
			["-59, -18, 1"] = "Below I'm gonna present how I came to conclusions on the previous page. On the starting signs (with colored floor) there are tables with numbers 0, 1, 2 and letter x. The letter x means a center position. The numbers mean how many chains are going across a given tile, relative to the x tile. \n\nAs I mentioned on earlier pages, tiles have 0, 1 or 2 chains going over them. Usually, there is only 1 chain going over a tile. \n\nI tried to find a place where the surrounding tiles would have same numbers of chains as on one of the tables on signs.\n\n~Pages 89, 90 of Eustachy Wiertary journal.",
			["-53, -33, 1"] = "I noticed that there is a total of 7 signs in this room, each with different colored tiles. Each sign points to the next sign, which is pointing to another one, ultimately ending on the last sign with white floor. This way someone set 7 different chains of signs. \n\nI also noticed that every chain goes over black marble tiles. However, not every black marble has a chain going across it, and some have up to two chains going across. This knowledge might be essential later.\n\n~Pages 85, 86 of Eustachy Wiertara journal.",
			["-37, -7, 1"] = "Choosing the wrong portal is not going to put you in a safe place.",
			["-25, 54, 0"] = "Here lies an attention whore. She always dreamed of whiteknightning cucks.",
			["-35, 53, 0"] = "Let eight ghosts surround you, take off your sword and cast exori. This will help you pass this room.\n\n~engraved with nails. there is clotted blood in the crevices.",
			["-21, 37, 0"] = "Ghouls ideas are idiotic, and you should rather trust Eustachy Wiertara. \n\n~Miroslaw o Ankhar",
			["-69, 59, 0"] = "To proceed further, you need to move the knight statues, so they are placed on special tiles, facing the Oracle. After that, grab her ass.\n\n~Eustachy Wiertara",
			["-118, -35, -1"] = "Talking from my experience, standing on the plate makes another person able to pass through a magic wall. `\n\n~Germi",
			["-89, -57, 0"] = "Messages left by Janusz Cyc are misleading and malicious. \n\n~Germi",
			["12, 155, 1"] = "This puzzle is meant for four and four adventurers only, each of distinct vocations. Doom upon thee who dares to... \n\n???",
			["-85, 139, 2"] = "Stairs seen near center of the room are dubious. Use those at west side of room. \n\n ~printed with typewriter",
		}

		local randomReadableItemId = { 21425, 21468, 21424, 22794, 2815, 2819, 639 }

		local function getRandomBookId()
			return randomReadableItemId[math.random(1, #randomReadableItemId)]
		end

		function LoadDesertQuestBooks()
			local desertQuestBookOffsets = {}
			for offset, _ in pairs(vectorToMessage) do
				local parts = {}
				for part in offset:gmatch("([^,]+)") do
					table.insert(parts, part)
				end

				local numbers = {}
				for i = 1, #parts do
					table.insert(numbers, tonumber(parts[i]))
				end

				desertQuestBookOffsets[#desertQuestBookOffsets + 1] = { x = numbers[1], y = numbers[2], z = numbers[3] }
			end

			for _, offset in pairs(desertQuestBookOffsets) do
				local pos = DESERT_QUEST_ONE_ANCHOR:Moved(offset.x, offset.y, offset.z)
				local randomId = getRandomBookId()
				local book = Game.createItem(randomId, 1, pos)
				book:setActionId(Storage.DesertQuestOne.Readable.FloorBooks)
				book:setUniqueId(1000)
			end
		end

		local book = Action()

		function book.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end
			player:registerEvent("DesertQuestBook_Modal_Window")

			local message = vectorToMessage[toPosition:VectorBetween(DESERT_QUEST_ONE_ANCHOR):ToStringShort()]
			local translatedMessage = player:Localizer(Storage.DesertQuestOne.Questline):Get(message)
			local title = "You read the following."

			local window = ModalWindow(item.actionid, title, translatedMessage)
			window:addButton(101, "Close")
			window:setDefaultEscapeButton(101)
			window:sendToPlayer(player)
			player:unregisterEvent("DesertQuestBook_Modal_Window")
			return true
		end

		book:aid(Storage.DesertQuestOne.Readable.FloorBooks)
		book:register()
	end)
	:Script(function(storageToRequiredState)
		local config = { ["mysteriando"] = "Desert Quest: credit for puzzle ", ["granted"] = " - granted." }

		local questline = Storage.DesertQuestOne.Questline

		local function playerCompletedCurrentMysteriando(player, currentActionid)
			return player:getStorageValue(currentActionid) == 1
		end

		local function playerCompletedNoMysteriandos(player)
			return player:getStorageValue(questline) == -1
		end

		local function giveMysteriandoCredit(player, aid, nextQuestlineValue)
			player:setStorageValue(questline, nextQuestlineValue)
			player:setStorageValue(aid, 1)
			local localizer = player:Localizer(Storage.DesertQuestOne.Questline)
			local mysteriandoString = localizer:Get(config["mysteriando"])
			local grantedString = localizer:Get(config["granted"])

			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, mysteriandoString .. nextQuestlineValue .. grantedString)
			player:getPosition():sendMagicEffect(CONST_ME_PURPLEENERGY)
		end

		function TryProgressDesertQuest(creature, itemOrAid)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local aid = 0
			if type(itemOrAid) == "number" then
				aid = itemOrAid
			else
				aid = itemOrAid:getActionId()
			end

			local mysteriandoActionid = aid
			local nextQuestlineValue = aid - questline

			if playerCompletedNoMysteriandos(player) then
				player:setStorageValue(questline, 0)
			end

			if playerCompletedCurrentMysteriando(player, mysteriandoActionid) then
				return false
			end

			giveMysteriandoCredit(player, aid, nextQuestlineValue)
			return true
		end

		local validPortals = { [1949] = true, [8262] = true, [8261] = true }

		local function isPortal(item)
			local id = item:getId()
			return validPortals[id]
		end

		local skipDoor = MoveEvent()

		function skipDoor.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if not isPortal(item) then
				TryProgressDesertQuest(creature, item)
				return
			end

			local aid = item:getActionId()
			local toPosOffset = DESERT_QUEST_ONE_SKIPS[aid]
			if not toPosOffset then
				return
			end

			player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(toPosOffset))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end

		for _, actionId in pairs(Storage.DesertQuestOne.QuestState) do
			skipDoor:aid(actionId)
		end
		skipDoor:type("stepin")
		skipDoor:register()
	end)
	:Script(function(storageToRequiredState)
		local correctPortal = MoveEvent()

		function correctPortal.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local toPos =
				DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[Storage.DesertQuestOne.Portals.FinalPuzzle])
			player:teleportTo(toPos)
		end

		correctPortal:aid(Storage.DesertQuestOne.Puzzles.ChoosePortalPuzzle.CorrectPortal)
		correctPortal:type("stepin")
		correctPortal:register()
	end)
	:Script(function(storageToRequiredState)
		local N = NORTH
		local W = WEST
		local E = EAST
		local S = SOUTH

		local progressStorage = Storage.DesertQuestOne.DirectionalPortal
		local labyrinthCenter = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -115, y = 138, z = 2 })
		local COMBINATION = { E, N, W, N, W, S, W, S, E, S, E }

		local function progressFinalLabyrinth(player, currentProgress)
			player:setStorageValue(progressStorage, currentProgress + 1)
			player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
		end

		local function resetProgress(player)
			player:setStorageValue(progressStorage, 1)
		end

		local function tryFixProgress(player)
			local currentProgess = player:getStorageValue(progressStorage)
			if currentProgess < 1 then
				resetProgress(player)
			end
		end

		local function playerCompletedQuest(player)
			if
				player:getStorageValue(Storage.DesertQuestOne.Questline) > TableSize(Storage.DesertQuestOne.QuestState)
			then
				return true
			end
		end

		local tile = MoveEvent()

		function tile.onStepIn(creature, tileItem, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if playerCompletedQuest(player) then
				return
			end
			tryFixProgress(player)

			local playerMoveDir = fromPosition:DirectionTo(toPosition)
			local currentProgress = player:getStorageValue(progressStorage)
			if currentProgress > #COMBINATION then
				TryProgressDesertQuest(player, Storage.DesertQuestOne.QuestState.q12)
				return true
			end

			if playerMoveDir == COMBINATION[currentProgress] then
				progressFinalLabyrinth(player, currentProgress)
			else
				player:getPosition():sendMagicEffect(CONST_ME_DIVINE_DAZZLE)
				resetProgress(player)
			end

			player:teleportTo(labyrinthCenter, true)
			return true
		end

		tile:aid(Storage.DesertQuestOne.Puzzles.DirectionalPortalPuzzle.Tile)
		tile:type("stepin")
		tile:register()
	end)
	:Script(function(storageToRequiredState)
		local portal = MoveEvent()

		function portal.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()

			if not player then
				return false
			end

			local pos = Position(fromPosition)
			pos = pos:Moved(-24, 0, 0)
			if Tile(pos) and Tile(pos):getGround() then
				player:teleportTo(pos, true)
			else
				pos = pos:Moved(120, 0, 0)
				player:teleportTo(pos, true)
			end

			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this portal.") -- trolleg
			return true
		end
		portal:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.PortalIdenticalRooms)
		portal:type("stepin")
		portal:register()
	end)
	:Script(function(storageToRequiredState)
		local pressure_plate_enter = MoveEvent()

		function pressure_plate_enter.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local mwall = DESERT_QUEST_ONE_MS_RP_MWALLS["MWALL"]
			local mwall_pos = DESERT_QUEST_ONE_ANCHOR:Moved(mwall.offPos)
			local mwall_id = mwall.id

			local stone = DESERT_QUEST_ONE_MS_RP_MWALLS["STONE"]
			local stone_pos = DESERT_QUEST_ONE_ANCHOR:Moved(stone.offPos)
			local stone_id = stone.id

			local mwall_tile = Tile(mwall_pos):getItemById(mwall_id)
			if mwall_tile then
				mwall_tile:remove()
			end

			local stone_tile = Tile(stone_pos):getItemById(stone_id)
			if stone_tile then
				stone_tile:remove()
			end

			item:transform(430)
			player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)

			return true
		end

		pressure_plate_enter:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.MsRpPressure)
		pressure_plate_enter:type("stepin")
		pressure_plate_enter:register()

		local pressure_plate_exit = MoveEvent()

		function pressure_plate_exit.onStepOut(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local mwall_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MS_RP_MWALLS["MWALL"].offPos)
			local mwall_id = DESERT_QUEST_ONE_MS_RP_MWALLS["MWALL"].id
			local origin = Tile(fromPosition)
			local mwall_tile = Tile(mwall_pos):getItemById(mwall_id)

			local stone_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MS_RP_MWALLS["STONE"].offPos)
			local stone_id = DESERT_QUEST_ONE_MS_RP_MWALLS["STONE"].id
			local stone_tile = Tile(stone_pos):getItemById(stone_id)

			if not mwall_tile then
				if not origin:getTopCreature() then
					Game.createItem(mwall_id, 1, mwall_pos)
				end
			end

			if not stone_tile then
				Game.createItem(stone_id, 1, stone_pos)
			end

			item:transform(431)

			return true
		end

		pressure_plate_exit:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.MsRpPressure)
		pressure_plate_exit:type("stepout")
		pressure_plate_exit:register()
	end)
	:Script(function(storageToRequiredState)
		local config = {
			["disappeared"] = "The magic walls disappeared for one minute",
		}

		local statue = Action()

		function statue.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_EK_ED_STATUES, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_EK_ED_MWALLS, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end
			if fromPosition.y <= player:getPosition().y then
				return false
			end

			RemoveItems(DESERT_QUEST_ONE_EK_ED_STATUES, DESERT_QUEST_ONE_ANCHOR)
			RemoveItems(DESERT_QUEST_ONE_EK_ED_MWALLS, DESERT_QUEST_ONE_ANCHOR)
			RemoveItems(DESERT_QUEST_ONE_EK_ED_SPAWN_STATUES, DESERT_QUEST_ONE_ANCHOR)

			player:say(config["disappeared"], TALKTYPE_MONSTER_SAY)

			addEvent(function()
				CreateItems(DESERT_QUEST_ONE_EK_ED_MWALLS, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_EK_ED_SPAWN_STATUES, DESERT_QUEST_ONE_ANCHOR)
				ChangeItemsActionId(DESERT_QUEST_ONE_EK_ED_SPAWN_STATUES, 1000, DESERT_QUEST_ONE_ANCHOR)
			end, 60 * 1000)
			return true
		end

		statue:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.EkEdStatue)
		statue:register()
	end)
	:Script(function(storageToRequiredState)
		local step_tile = MoveEvent()

		local msAid = DESERT_QUEST_ONE_VOC_DOORS["ms"]
		local rpAid = DESERT_QUEST_ONE_VOC_DOORS["rp"]
		local edAid = DESERT_QUEST_ONE_VOC_DOORS["ed"]
		local ekAid = DESERT_QUEST_ONE_VOC_DOORS["ek"]
		
		function step_tile.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			local aid = item.actionid

			if
				(aid == msAid and player:isSorcerer())
				or (aid == rpAid and player:isPaladin())
				or (aid == edAid and player:isDruid())
				or (aid == ekAid and player:isKnight())
			then
				return true
			end
			player:teleportTo(fromPosition)
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
			player:sendTextMessage(MESSAGE_FAILURE, "You don't have the required profession.")
			return false
		end

		for _, value in pairs(Storage.DesertQuestOne.VocTiles) do
			step_tile:aid(value)
		end
		step_tile:type("stepin")
		step_tile:register()
	end)
	:Script(function(storageToRequiredState)
		local goodNames = { "Eustachy Wiertara", "Fifonz Kuciapa", "Sierotka Marysia", "Miroslaw z Ankharu" }
		local badNames =
			{ "Wojciech Szpara", "Edward Tatarata", "Bogdan Boner", "Anna Niewypchnieta", "Jan Pawel Drugi" }

		DesertQuestOneVocTrickSign = function(context)
			local player = context.player

			local translatedMessage =
				player:Localizer(Storage.DesertQuestOne.Questline):Get("You can safely exit to the surface. \n\n~")
			local randIndex = math.random(1, #badNames)
			local randomTrickster = badNames[randIndex]
			return translatedMessage .. randomTrickster
		end
		DesertQuestOneVocGoodSign = function(context)
			local player = context.player

			local translatedMessage =
				player:Localizer(Storage.DesertQuestOne.Questline):Get("You can safely exit to the surface. \n\n~")
			local randIndex = math.random(1, #goodNames)
			local randomHelper = goodNames[randIndex]
			return translatedMessage .. randomHelper
		end
	end)
	:Script(function(storageToRequiredState)
		local config = { ["SUCCESS"] = "One of the magic walls disappeared", ["FAIL"] = "You cannot use this yet" }

		local lever = Action()

		local MWALL = 2129

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local aid = item.actionid
			local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PERSONAL_MWALLS[aid])
			local tile = Tile(pos):getItemById(MWALL)

			if tile then
				item:transform(DESERT_QUEST_ONE_LEVER_SWAP_LIST[item.itemid])

				tile:remove()
				player:say(config["SUCCESS"], TALKTYPE_MONSTER_SAY)
				addEvent(function()
					Game.createItem(MWALL, 1, pos)
				end, 1000 * 60)
			else
				player:say(config["FAIL"], TALKTYPE_MONSTER_SAY)
			end

			return true
		end

		lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.EkLever)
		lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.EdLever)
		lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.MsLever)
		lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.RpLever)
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local stairTimer = 15

		local config = {
			["stairsAreGonna"] = "Stairs are gonna disappear in ",
			["stairsSeconds"] = " seconds.",
			["missingPeople"] = "You need four professions to activate the mechanism.",
			["missingItems"] = "You need four sacrifices to activate the mechanism.",
		}

		local lever = Action()

		local stairsStorage = Storage.DesertQuestOne.Puzzles.BasinPuzzle.Lever

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if Game.getStorageValue(stairsStorage) > os.time() then
				return false
			end
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_BASIN_OFFERINGS, DESERT_QUEST_ONE_ANCHOR) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["missingItems"])
				return false
			end
			if not PlayersPresentAtAllPositions(DESERT_QUEST_ONE_BASIN_PLAYERS, DESERT_QUEST_ONE_ANCHOR) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["missingPeople"])
				return false
			end

			RemoveItems(DESERT_QUEST_ONE_BASIN_OFFERINGS, DESERT_QUEST_ONE_ANCHOR)

			for _, offset in pairs(DESERT_QUEST_ONE_BASIN_PLAYERS) do
				local beneficiary = Tile(DESERT_QUEST_ONE_ANCHOR:Moved(offset)):getTopCreature()
				if beneficiary then
					TryProgressDesertQuest(beneficiary, Storage.DesertQuestOne.QuestState.q3)
				end
			end

			Game.setStorageValue(stairsStorage, os.time() + stairTimer)
			local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_BASIN_OPENING.pos)
			local stairs = Tile(pos):getItemById(DESERT_QUEST_ONE_BASIN_OPENING.sealedId)
			if not stairs then
				return true
			end
			stairs:transform(DESERT_QUEST_ONE_BASIN_OPENING.stairsId)

			local stairsMessage = player:Localizer(Storage.DesertQuestOne.Questline):Get(config["stairsAreGonna"])
				.. stairTimer
				.. player:Localizer(Storage.DesertQuestOne.Questline):Get(config["stairsSeconds"])
			player:say(player:Localizer(Storage.DesertQuestOne.Questline):Get(stairsMessage), TALKTYPE_MONSTER_SAY)
			addEvent(function()
				stairs = Tile(pos):getItemById(DESERT_QUEST_ONE_BASIN_OPENING.stairsId)
				stairs:transform(DESERT_QUEST_ONE_BASIN_OPENING.sealedId)
			end, 1000 * stairTimer)

			return true
		end

		lever:aid(Storage.DesertQuestOne.Puzzles.BasinPuzzle.Lever)
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local lever = Action()

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_KEY_SHAFT_COMBINATION, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end

			item:transform(DESERT_QUEST_ONE_LEVER_SWAP_LIST[item.itemid])

			RemoveItems(DESERT_QUEST_ONE_KEY_SHAFT_COMBINATION, DESERT_QUEST_ONE_ANCHOR)
			RemoveItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_UNMOVED, DESERT_QUEST_ONE_ANCHOR)
			CreateItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_MOVED, DESERT_QUEST_ONE_ANCHOR)

			local plaque_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = 15, y = 0, z = 0 })
			Tile(plaque_pos):getItemById(2023):remove()
			return true
		end

		lever:aid(Storage.DesertQuestOne.Puzzles.KeyshaftPuzzle.LeverPutIn)
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local config = {
			["youHaveSeconds"] = "You have 60 seconds to walk though the gate",
		}

		local lever = Action()

		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_MOVED, DESERT_QUEST_ONE_ANCHOR) then
				return
			end

			item:transform(DESERT_QUEST_ONE_LEVER_SWAP_LIST[item.itemid])

			RemoveItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_MOVED, DESERT_QUEST_ONE_ANCHOR)
			RemoveItems(DESERT_QUEST_ONE_IRON_WALL, DESERT_QUEST_ONE_ANCHOR)
			CreateItems(DESERT_QUEST_ONE_KEY_BOW_HORIZONTAL, DESERT_QUEST_ONE_ANCHOR)

			player:say(
				player:Localizer(Storage.DesertQuestOne.Questline):Get(config["youHaveSeconds"]),
				TALKTYPE_MONSTER_SAY
			)

			addEvent(function()
				RemoveItems(DESERT_QUEST_ONE_KEY_BOW_HORIZONTAL, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_SPAWN_KEY_SHAFT, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_KEY_BOW_VERTICAL_UNMOVED, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_IRON_WALL, DESERT_QUEST_ONE_ANCHOR)
				local plaque_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = 15, y = 0, z = 0 })
				local plaque = Game.createItem(2023, 1, plaque_pos)
				plaque:setText("0xB6A")
			end, 1000 * 60)

			return true
		end

		lever:aid(Storage.DesertQuestOne.Puzzles.KeyshaftPuzzle.LeverTurn)
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local config = {
			["youHearStones"] = "You hear stones rumbling nearby",
		}

		local gravestone = Action()

		function gravestone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_CASTLE_TORCHES_UNLIT, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end

			if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_CASTLE_WALLS, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end

			RemoveItems(DESERT_QUEST_ONE_CASTLE_TORCHES_UNLIT, DESERT_QUEST_ONE_ANCHOR)
			RemoveItems(DESERT_QUEST_ONE_CASTLE_TORCHES_LIT, DESERT_QUEST_ONE_ANCHOR)
			CreateItems(DESERT_QUEST_ONE_CASTLE_TORCHES_LIT, DESERT_QUEST_ONE_ANCHOR)

			player:say(config["youHearStones"], TALKTYPE_MONSTER_SAY)

			local portal
			addEvent(function()
				RemoveItems(DESERT_QUEST_ONE_CASTLE_WALLS, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_CASTLE_NEW_WALLS, DESERT_QUEST_ONE_ANCHOR)
				portal =
					Game.createItem(1949, 1, DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_CASTLE_WALLS[2].offPos))
				portal:setActionId(Storage.DesertQuestOne.QuestState.q5)
			end, 1000 * 5)
			addEvent(function()
				portal:remove()
				RemoveItems(DESERT_QUEST_ONE_CASTLE_NEW_WALLS, DESERT_QUEST_ONE_ANCHOR)
				CreateItems(DESERT_QUEST_ONE_CASTLE_WALLS, DESERT_QUEST_ONE_ANCHOR)
			end, 1000 * 65)

			return true
		end

		gravestone:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Gravestone)
		gravestone:register()
	end)
	:Script(function(storageToRequiredState)
		local elevatorToUp = Action()

		function elevatorToUp.onUse(creature, item, fromPosition, itemEx, toPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end

			local up = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_HOIST["up"])

			player:teleportTo(up)

			player:getPosition():sendMagicEffect(CONST_ME_POFF)

			return true
		end

		elevatorToUp:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.ElevatorToUp)
		elevatorToUp:register()

		local elevatorToDown = Action()

		function elevatorToDown.onUse(creature, item, fromPosition, itemEx, toPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end

			local down = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_HOIST["down"])
			player:teleportTo(down)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)

			return true
		end

		elevatorToDown:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.ElevatorToDown)
		elevatorToDown:register()
	end)
	:Script(function(storageToRequiredState)
		local lever = Action()

		function lever.onUse(cid, item, fromPosition, itemEx, toPosition)
			item:transform(DESERT_QUEST_ONE_CASTLE_SWAP_LIST[item:getId()])

			local items = DESERT_QUEST_ONE_CASTLE_LEVER_GROUPS[item:getActionId()]
			for j = 1, #items do
				local index = items[j]
				local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_CASTLE_LEVER_POS_ITEMS[index].offPos)

				local id = DESERT_QUEST_ONE_CASTLE_LEVER_POS_ITEMS[index].id
				local swapid = DESERT_QUEST_ONE_CASTLE_SWAP_LIST[id]

				local tile = Tile(pos):getItemById(id)
				local swaptile = Tile(pos):getItemById(swapid)

				if tile then
					tile:remove()
					Game.createItem(swapid, 1, pos)
				elseif swaptile then
					swaptile:remove()
					Game.createItem(id, 1, pos)
				elseif not swaptile and not tile then
					Game.createItem(id, 1, pos)
				end
			end
			return true
		end

		lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever1)
		lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever2)
		lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever3)
		lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever4)
		lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever5)
		lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever6)
		lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever7)
		lever:register()

		-- crateitem(id, count, pos)
	end)
	:Script(function(storageToRequiredState)
		local skating_id = DESERT_QUEST_ONE_ICE_SKATING.skating_floor.id
		local black_marble_id = DESERT_QUEST_ONE_ICE_SKATING.black_marble.id

		local lever = Action()

		function lever.onUse(creature, item, fromPosition, itemEx, toPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end

			local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_ICE_SKATING.stone.pos)
			local id = DESERT_QUEST_ONE_ICE_SKATING.stone.id
			if Tile(pos):getItemById(id) then
				return false
			end

			if not PlayersPresentAtAllPositions(DESERT_QUEST_ONE_ICE_SKATING.players_pos, DESERT_QUEST_ONE_ANCHOR) then
				return false
			end

			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

			local stone = Game.createItem(id, 1, pos)
			local tile = Tile(pos):getItemById(skating_id)
			tile:transform(black_marble_id)
			addEvent(function()
				stone:remove()
				tile:transform(skating_id)
			end, 1000 * 60)

			return true
		end

		lever:aid(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.Lever)
		lever:register()
	end)
	:Script(function(storageToRequiredState)
		local stopid = { [6594] = true, [799] = true, [431] = true, [430] = true }

		local corner1 = DESERT_QUEST_ONE_ANCHOR:Moved(-42, 46, 2)
		local corner2 = DESERT_QUEST_ONE_ANCHOR:Moved(-1, 73, 3)

		local iceId = { [800] = true, [6967] = true, [6683] = true, [6684] = true, [6685] = true, [6686] = true }
		function LoadDesertQuestIceSkating()
			IterateBetweenPositions(corner1, corner2, function(context)
				local tile = Tile(context.pos)
				if not tile then
					return
				end
				local ground = tile:getGround()
				if not ground then
					return
				end

				local groundId = ground:getId()
				if iceId[groundId] then
					ground:setActionId(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.IceTile)
				end
				if stopid[groundId] then
					ground:setActionId(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.StopTile)
				end
			end)
		end

		local function isDirLegal(dir)
			return 0 <= dir and dir <= 3
		end

		local function isNextPosWalkable(nextPos)
			local groundId = Tile(nextPos):getGround():getId()
			return stopid[groundId] or iceId[groundId]
		end

		local function icyRelocate(player, fromPosition, toPos)
			local playerMoveDir = fromPosition:DirectionTo(toPos)

			if not isDirLegal(playerMoveDir) then
				player:teleportTo(fromPosition)
				return
			end

			local offset = Vector.FromDirection(playerMoveDir)
			local nextPos = toPos:Moved(offset)

			if not isNextPosWalkable(nextPos) then
				return false
			end
			addEvent(function()
				player:teleportTo(nextPos)
			end, 10)
		end

		local function snowyRelocate(player, fromPosition, dir)
			if not isDirLegal(dir) then
				player:teleportTo(fromPosition)
			end
		end

		local stopTile = MoveEvent()

		function stopTile.onStepIn(creature, _, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			local playerMoveDir = fromPosition:DirectionTo(toPosition)

			snowyRelocate(player, fromPosition, playerMoveDir)
			return true
		end

		stopTile:aid(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.StopTile)
		stopTile:type("stepin")
		stopTile:register()

		local iceTile = MoveEvent()

		function iceTile.onStepIn(creature, _, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			icyRelocate(player, fromPosition, toPosition)
			return true
		end

		iceTile:aid(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.IceTile)
		iceTile:type("stepin")
		iceTile:register()
	end)
	:Script(function(storageToRequiredState)
		local corner1 = DESERT_QUEST_ONE_ANCHOR:Moved(2, 42, 2)
		local corner2 = DESERT_QUEST_ONE_ANCHOR:Moved(-8, 8, 2)

		local iceId = { [800] = true }
		function LoadDesertQuestBreakIce()
			IterateBetweenPositions(corner1, corner2, function(context)
				local tile = Tile(context.pos)
				if not tile then
					return
				end
				local ground = tile:getGround()
				if not ground then
					return
				end

				local groundId = ground:getId()
				if iceId[groundId] then
					ground:setActionId(Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.IceTile)
				end
			end)
		end

		local function allIceHasCracks(top_left, down_right, scan_id, ground_id)
			for i = top_left.x, down_right.x do
				for j = top_left.y, down_right.y do
					local pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = i, y = j, z = top_left.z })
					local cracks = Tile(pos):getItemById(scan_id)
					local ice = Tile(pos):getItemById(ground_id)

					if cracks == nil and ice ~= nil then
						return false
					end
				end
			end
			return true
		end

		local function removeAllCracks(top_left, down_right, scan_id, ground_id)
			for i = top_left.x, down_right.x do
				for j = top_left.y, down_right.y do
					local pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = i, y = j, z = top_left.z })
					local cracks = Tile(pos):getItemById(scan_id)
					local ice = Tile(pos):getItemById(ground_id)

					if cracks and ice ~= nil then
						cracks:remove()
					end
				end
			end
			return true
		end

		local teleportTile = MoveEvent()
		function teleportTile.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end

			local id = item.itemid
			local top_left = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.top_left[id]
			local down_right = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.down_right[id]
			local cracks_id = 6298
			local ice_id = 800

			if allIceHasCracks(top_left, down_right, cracks_id, ice_id) == true then
				local pos = player:getPosition()
				pos.y = pos.y - 2
				player:teleportTo(pos)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			else
				player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_DONT_BREAK_ICE.start_pos))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
			removeAllCracks(top_left, down_right, cracks_id, ice_id)
			return true
		end

		teleportTile:aid(Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.TeleportTile)
		teleportTile:type("stepin")
		teleportTile:register()

		local iceTile = MoveEvent()
		function iceTile.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end

			local cracks_id = 6298
			local tile = Tile(item:getPosition())

			if not tile:getItemById(cracks_id) then
				Game.createItem(cracks_id, 1, item:getPosition())
			else
				player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_DONT_BREAK_ICE.start_pos))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				local id = DESERT_QUEST_ONE_DONT_BREAK_ICE.ice_y_to_board[toPosition.y - DESERT_QUEST_ONE_ANCHOR.y]
				local top_left = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.top_left[id]
				local down_right = DESERT_QUEST_ONE_DONT_BREAK_ICE.boards.down_right[id]
				local cracks_id = 6298
				local ice_id = 800
				removeAllCracks(top_left, down_right, cracks_id, ice_id)
			end
		end

		iceTile:aid(Storage.DesertQuestOne.Puzzles.BreakIcePuzzle.IceTile)
		iceTile:type("stepin")
		iceTile:register()
	end)
	:Script(function(storageToRequiredState)
		local function moveStone(creature, dir, item, pos)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local i = pos.y - DESERT_QUEST_ONE_MONSTER_GUIDING.stonesAnchor.y + 1
			RemoveItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.origin[i] }, DESERT_QUEST_ONE_ANCHOR)
			RemoveItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.destination[i] }, DESERT_QUEST_ONE_ANCHOR)

			if dir == "create" then
				CreateItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.destination[i] }, DESERT_QUEST_ONE_ANCHOR)
				item:transform(430)
			elseif dir == "remove" then
				CreateItems({ DESERT_QUEST_ONE_MONSTER_GUIDING.stones_pos.origin[i] }, DESERT_QUEST_ONE_ANCHOR)
				item:transform(431)
			end
		end

		local enter = MoveEvent()
		function enter.onStepIn(creature, item, toPosition, fromPosition)
			moveStone(creature, "create", item, toPosition)
			return true
		end
		enter:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone)
		enter:type("stepin")
		enter:register()

		local exit = MoveEvent()
		function exit.onStepOut(creature, item, position, fromPosition)
			moveStone(creature, "remove", item, fromPosition)
			return true
		end
		exit:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.ManipulateStone)
		exit:type("stepout")
		exit:register()
	end)
	:Script(function(storageToRequiredState)
		local function createSubstituteMonster(top_left, down_right, spawn_pos, name)
			local z = top_left.z
			for x = top_left.x, down_right.x do
				for y = top_left.y, down_right.y do
					local pos = Position(x, y, z)
					if Tile(pos):getTopCreature() then
						Tile(pos):getTopCreature():remove()
						break
					end
				end
			end
			Game.createMonster(name, spawn_pos)
			return true
		end

		local gpAltar = MoveEvent()

		function gpAltar.onAddItem(moveitem, tileitem, position)
			if not moveitem then
				return false
			else
				if moveitem.itemid ~= 3031 then
					return false
				end
			end
			moveitem:remove()
			createSubstituteMonster(
				DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.top_left),
				DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.down_right),
				DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.monster.spawn_pos),
				DESERT_QUEST_ONE_MONSTER_GUIDING.monster.name
			)
			return true
		end

		gpAltar:type("additem")
		gpAltar:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.SacrificeGp)
		gpAltar:register()

		local wispAltar = MoveEvent()
		function wispAltar.onStepIn(creature, item, toPosition, fromPosition)
			if creature:isPlayer() then
				return false
			end

			local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.fence.pos)
			local id = DESERT_QUEST_ONE_MONSTER_GUIDING.fence.id

			if Tile(pos):getItemById(id) then
				local monster_pressure_plate_pos =
					DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.monster.pressure_plate_pos)
				Tile(monster_pressure_plate_pos):getTopCreature():remove()
				Position(pos):removeItem(id)
				Position(pos):sendMagicEffect(CONST_ME_MAGIC_BLUE)
				Position(monster_pressure_plate_pos):sendMagicEffect(CONST_ME_FIREATTACK)
				addEvent(function()
					Game.createItem(id, 1, pos)
				end, 1000 * 60)
			end
			return true
		end

		wispAltar:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.SacrificeWisp)
		wispAltar:type("stepin")
		wispAltar:register()
	end)
	:Script(function(storageToRequiredState)
		local function tryPunishCheeser(pos, cheeser)
			local playersPositions = { pos:Moved(0, 2, 0), pos:Moved(0, -2, 0) }
			local penaltyRoomPos =
				DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[Storage.DesertQuestOne.Portals.PenaltyRoom3])
			for _, cheeserPos in pairs(playersPositions) do
				local innocentPlayer = cheeserPos:GetTopCreature()
				if innocentPlayer and innocentPlayer:isPlayer() then
					cheeser:teleportTo(penaltyRoomPos)
					return
				end
			end
		end

		local function isTileArrayFixed()
			local _, table = next(DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions, nil)
			return #table ~= 0
		end
		function FixRevealingTileArrays()
			if isTileArrayFixed() then
				return
			end
			IterateBetweenPositions(
				DESERT_QUEST_ONE_WATER_FLOW.tileArrayTopLeft,
				DESERT_QUEST_ONE_WATER_FLOW.tileArrayDownRight,
				function(context)
					local pos = context.pos
					local tile = Tile(pos)
					if not tile then
						return
					end
					local ground = tile:getGround()
					if not ground then
						return
					end
					local groundId = ground:getId()
					if DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId] then
						table.insert(DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId], pos)
					end
				end
			)
		end

		local revealTiles = MoveEvent()

		function revealTiles.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local groundId = item:getId()
			local revealedPositions = DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId]
			if not revealedPositions then
				return false
			end

			for _, pos in pairs(revealedPositions) do
				local blockage = Tile(pos):getItemById(groundId)
				if blockage then
					blockage:transform(DESERT_QUEST_ONE_WATER_FLOW.dry_id)
				end
			end
			tryPunishCheeser(toPosition, creature)
		end

		revealTiles:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile)
		revealTiles:type("stepin")
		revealTiles:register()

		local vanisherOut = MoveEvent()

		function vanisherOut.onStepOut(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			local groundId = item:getId()
			local revealedPositions = DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId]
			if not revealedPositions then
				return false
			end
			for _, pos in pairs(revealedPositions) do
				local dry = Tile(pos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.dry_id)
				if dry then
					dry:transform(groundId)
				end
			end
		end

		vanisherOut:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile)
		vanisherOut:type("stepout")
		vanisherOut:register()

		FixRevealingTileArrays()
	end)
	:Script(function(storageToRequiredState)
		local config = {
			["saplingsNotWatered"] = "If you wanna proceed further, you need to water every sapling.",
			["youHaveOneMinute"] = "You have one minute to go through portal.",
			["gateIsOpened"] = "Passage is already open.",
		}

		local function areAllTreesWatered()
			return ItemsArePresentOnPositions(DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_positions, DESERT_QUEST_ONE_ANCHOR)
		end

		local function SwapItemsList(positionsList, fromId, toId, anchor)
			if not ItemsArePresentOnPositions(positionsList, anchor) then
				return false
			end
			for _, item in pairs(positionsList) do
				local pos = item.offPos or item.pos
				if anchor then
					pos = anchor:Moved(pos)
				end
				local tile = Tile(pos)
				tile:getItemById(fromId):transform(toId)
			end
			return true
		end

		local function drenchAllTrees()
			SwapItemsList(
				DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_positions,
				DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_id,
				DESERT_QUEST_ONE_WATER_FLOW.dead_tree_id,
				DESERT_QUEST_ONE_ANCHOR
			)
		end

		local function gateIsOpened()
			return not ItemsArePresentOnPositions(DESERT_QUEST_ONE_WATER_FLOW.final_gate, DESERT_QUEST_ONE_ANCHOR)
		end

		local function openGateTemporarily()
			RemoveItems(DESERT_QUEST_ONE_WATER_FLOW.final_gate, DESERT_QUEST_ONE_ANCHOR)
			addEvent(function()
				CreateItems(DESERT_QUEST_ONE_WATER_FLOW.final_gate, DESERT_QUEST_ONE_ANCHOR)
				local portalPos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_WATER_FLOW.final_gate[1].offPos)
				local item = Tile(Position(portalPos)):getItemById(1949)
				item:moveTo(portalPos:Moved(-1, 0, 0))
				item:moveTo(portalPos)
			end, 60 * 1000)
		end

		local tree_branch = Action()

		function tree_branch.onUse(creature, item, fromPosition, itemEx, toPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end

			local message = ""
			if not areAllTreesWatered() then
				message = "saplingsNotWatered"
			elseif gateIsOpened() then
				message = "gateIsOpened"
			else
				message = "youHaveOneMinute"
				drenchAllTrees()
				openGateTemporarily()
			end

			player:say(player:Localizer(Storage.DesertQuestOne.Questline):Get(config[message]), TALKTYPE_MONSTER_SAY)
			return false
		end

		tree_branch:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.TreeLever)
		tree_branch:register()
	end)
	:Script(function(storageToRequiredState)
		local config = { ["waterPumpNotReady"] = "Water pump is not ready yet" }

		local function drenchNearbyTiles(pos)
			local water = Tile(pos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.water_id)
			if not water then
				return false
			else
				water:transform(DESERT_QUEST_ONE_WATER_FLOW.nothing_special)
				addEvent(function()
					drenchNearbyTiles(Position(pos.x + 1, pos.y + 0, pos.z + 0))
					drenchNearbyTiles(Position(pos.x + 0, pos.y + 1, pos.z + 0))
					drenchNearbyTiles(Position(pos.x - 1, pos.y + 0, pos.z + 0))
					drenchNearbyTiles(Position(pos.x + 0, pos.y - 1, pos.z + 0))
				end, 160 * DESERT_QUEST_ONE_WATER_FLOW.watering_rate)
				return true
			end
		end

		local function nextTileIsWood(pos)
			local dryPos = Position(pos)
			dryPos.x = dryPos.x - 1
			dryPos.y = dryPos.y - 1
			dryPos.z = dryPos.z + 1

			local dryTile = Tile(dryPos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.dry_id)
			return dryTile
		end

		local function waterDriedTree(pos)
			local dryPos = Position(pos)
			dryPos.x = dryPos.x - 1
			dryPos.y = dryPos.y - 1
			dryPos.z = dryPos.z + 1
			local dead_tree = Tile(dryPos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.dead_tree_id)
			if dead_tree then
				dead_tree:transform(DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_id)
			end
		end

		local function waterNearbyTiles(pos)
			local tile = Tile(pos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.nothing_special)
			if not tile then
				return false
			end

			if nextTileIsWood(pos) then
				tile:transform(DESERT_QUEST_ONE_WATER_FLOW.water_id)
				addEvent(function()
					waterNearbyTiles(Position(pos.x + 1, pos.y + 0, pos.z + 0))
					waterNearbyTiles(Position(pos.x + 0, pos.y + 1, pos.z + 0))
					waterNearbyTiles(Position(pos.x - 1, pos.y + 0, pos.z + 0))
					waterNearbyTiles(Position(pos.x + 0, pos.y - 1, pos.z + 0))
				end, 100 * DESERT_QUEST_ONE_WATER_FLOW.watering_rate)
			else
				waterDriedTree(pos)
				return false
			end
		end

		local valve = Action()

		function valve.onUse(creature, item, fromPosition, itemEx, toPosition)
			local player = creature:getPlayer()
			if not player:isPlayer() then
				return false
			end

			local pipe_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_WATER_FLOW.pipe_pos)
			local pipe_ready = DESERT_QUEST_ONE_WATER_FLOW.pipe_ready
			local cooldown = DESERT_QUEST_ONE_WATER_FLOW.pipe_cooldown

			if Tile(pipe_pos):getItemById(cooldown) then
				player:say(player:Localizer(Storage.DesertQuestOne.Questline):Get(config.text), TALKTYPE_MONSTER_SAY)
				return false
			end

			local pipe = Tile(pipe_pos):getItemById(pipe_ready)
			pipe:transform(cooldown)
			local start_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_WATER_FLOW.start_pos)
			waterNearbyTiles(start_pos)

			addEvent(function()
				drenchNearbyTiles(start_pos)
			end, 1000 * 5)

			addEvent(function()
				pipe:transform(pipe_ready)
			end, 100 * DESERT_QUEST_ONE_WATER_FLOW.watering_rate * 50 + 1000 * 10)
			return true
		end

		valve:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.PipeValve)
		valve:register()
	end)
	:Script(function(storageToRequiredState)
		local item = Action()

		local function moveGround(from_pos, to_pos)
			if Tile(from_pos):getGround() then
				Tile(from_pos):getGround():moveTo(to_pos)
			end
		end

		local function moveCreature(from_pos, to_pos)
			if Tile(from_pos):getTopCreature() then
				Tile(from_pos):getTopCreature():teleportTo(to_pos)
			end
		end

		local function moveTiles(start_pos, count, dir)
			local from_pos
			local to_pos

			if dir == "+x" then
				for i = 1, count do
					from_pos = Position(start_pos.x + count - i + 1, start_pos.y, start_pos.z)
					to_pos = Position(start_pos.x + count - i + 2, start_pos.y, start_pos.z)
					moveCreature(from_pos, to_pos)
					moveGround(from_pos, to_pos)
				end
			elseif dir == "-x" then
				for i = 1, count do
					from_pos = Position(start_pos.x - count + i - 1, start_pos.y, start_pos.z)
					to_pos = Position(start_pos.x - count + i - 2, start_pos.y, start_pos.z)
					moveCreature(from_pos, to_pos)
					moveGround(from_pos, to_pos)
				end
			elseif dir == "+y" then
				for i = 1, count do
					from_pos = Position(start_pos.x, start_pos.y + count - i + 1, start_pos.z)
					to_pos = Position(start_pos.x, start_pos.y + count - i + 2, start_pos.z)
					moveCreature(from_pos, to_pos)
					moveGround(from_pos, to_pos)
				end
			elseif dir == "-y" then
				for i = 1, count do
					from_pos = Position(start_pos.x, start_pos.y - count + i - 1, start_pos.z)
					to_pos = Position(start_pos.x, start_pos.y - count + i - 2, start_pos.z)
					moveCreature(from_pos, to_pos)
					moveGround(from_pos, to_pos)
				end
			end
		end

		function item.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local pos = item:getPosition()
			local x = pos.x
			local y = pos.y
			local z = pos.z

			if Tile(Position(x + 1, y, z)) and Tile(Position(x + 1, y, z)):getItemById(1127) then
				moveTiles(pos, 6, "+x")
			elseif Tile(Position(x - 1, y, z)) and Tile(Position(x - 1, y, z)):getItemById(1127) then
				moveTiles(pos, 6, "-x")
			elseif Tile(Position(x, y + 1, z)) and Tile(Position(x, y + 1, z)):getItemById(1127) then
				moveTiles(pos, 13, "+y")
			elseif Tile(Position(x, y - 1, z)) and Tile(Position(x, y - 1, z)):getItemById(1127) then
				moveTiles(pos, 13, "-y")
			end

			return true
		end

		item:aid(Storage.DesertQuestOne.Puzzles.MovableTilesPuzzle.Lever)
		item:register()
	end)
