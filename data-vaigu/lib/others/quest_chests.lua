questChests = {
	---------------------------------------------------------
	-- Example Quest Box 1
	---------------------------------------------------------
	[5000] = {
		minLevel = 50,
		items = {
			[1] = {
				type = "item",
				item = 3043,
				count = 1,
				aid = 100,
				desc = { ["PL"] = "smiechawaTV", ["EN"] = "laughter" },
			},
			[2] = { type = "item", item = 3071, count = 1 },
			[3] = { type = "experience", amount = 20000 },
			[4] = {
				type = "outfit",
				name = "assassin",
				femaleId = 156,
				maleId = 152,
			},
			[5] = {
				type = "addon",
				outfit = "nobleman",
				addonNumber = 1,
				femaleId = 140,
				maleId = 132,
			},
			[6] = { type = "mount", mountName = "Orc", mountId = 20 },
		},
	},
	[5001] = {
		minLevel = 50,
		items = {
			[1] = { type = "item", item = 3370, count = 1 },
			[2] = { type = "experience", amount = 1000 },
		},
	},
	[5010] = {
		minLevel = 15,
		items = {
			[1] = { type = "item", item = 3404, count = 1 }, -- leopard
			[2] = { type = "experience", amount = 1000 },
		},
	},
	[5011] = {
		minLevel = 16,
		items = {
			[1] = { type = "item", item = 3322, count = 1 }, -- dhammer
			[2] = { type = "experience", amount = 1000 },
		},
	},
	[5012] = {
		minLevel = 15,
		items = {
			[1] = { type = "item", item = 3318, count = 1 }, -- kaxe
			[2] = { type = "experience", amount = 800 },
		},
	},
	[5013] = {
		minLevel = 18,
		items = {
			[1] = { type = "item", item = 5880, count = 3 }, -- iron ore
			[2] = { type = "item", item = 813, count = 1 }, -- terra boots
			[3] = { type = "item", item = 3323, count = 1 }, -- dwarven axe
			[4] = { type = "experience", amount = 2000 },
		},
	},
	[5014] = {
		minLevel = 15,
		items = {
			[1] = { type = "item", item = 3039, count = 1 }, -- red gem
			[2] = { type = "experience", amount = 1500 },
		},
	},
	[5015] = {
		minLevel = 25,
		items = {
			[1] = { type = "item", item = 25698, count = 1 }, -- butterfly ring
			[2] = { type = "item", item = 25737, count = 3 }, -- rainbow quartz
			[3] = { type = "experience", amount = 1500 },
		},
	},
	[5016] = {
		minLevel = 15,
		items = {
			[1] = { type = "item", item = 3557, count = 1 }, -- plegi
			[2] = { type = "item", item = 17859, count = 1 }, -- spiky club
			[3] = { type = "item", item = 3093, count = 1 }, -- club ring
			[4] = { type = "item", item = 3035, count = 8 }, -- hajs
			[5] = { type = "experience", amount = 1500 },
		},
	},
	[5017] = {
		minLevel = 20,
		items = {
			[1] = { type = "item", item = 3049, count = 1 }, -- stealth
			[2] = { type = "item", item = 3046, count = 1 }, -- swiecaca
			[3] = { type = "item", item = 21175, count = 1 }, -- mino shield
			[4] = { type = "experience", amount = 4000 },
		},
	},
	[5018] = {
		minLevel = 25,
		items = {
			[1] = { type = "item", item = 3280, count = 1 }, -- fire sword
			[2] = { type = "item", item = 3061, count = 1 }, -- life crystal
			[3] = { type = "item", item = 5948, count = 8 }, -- red drag leather
			[4] = { type = "experience", amount = 8000 },
		},
	},
	[5019] = {
		minLevel = 12,
		items = {
			[1] = { type = "item", item = 5921, count = 1 }, -- heaven blossom
			[2] = { type = "item", item = 6299, count = 1 }, -- death ring
			[3] = { type = "item", item = 3016, count = 1 }, -- ruby necklace
			[4] = { type = "item", item = 3039, count = 1 }, -- red gem
			[5] = { type = "experience", amount = 2000 },
		},
	},
	-- ToDo: remake to questChest (same as in _startup.lua)
	[5020] = {
		minLevel = 12,
		storageId = Storage.IKEAdlazuchwalych.TakeBall,
		items = {
			[1] = { type = "item", item = 3076, count = 1 }, -- crystal ball
			[2] = { type = "experience", amount = 3000 },
		},
	},
	-- ToDo: remake to questChest (same as in _startup.lua)
	[5021] = {
		minLevel = 30,
		storageId = Storage.IKEAdlazuchwalych.TakeReward,
		items = {
			[1] = { type = "item", item = 16251, count = 1 }, -- golem wrench
			[2] = { type = "item", item = 3010, count = 1 }, -- emerald
			[3] = { type = "item", item = 3028, count = 3 }, -- diamond
			[4] = { type = "experience", amount = 2000 },
		},
	},
	-- ToDo: remake to questChest (same as in _startup.lua)
	[5022] = {
		minLevel = 15,
		storageId = Storage.IKEAdlazuchwalych.TakeKey,
		items = {
			[1] = { type = "item", item = 7934, count = 1 }, -- key
			[2] = { type = "item", item = 3055, count = 1 }, -- plat amulet
			[3] = { type = "item", item = 3357, count = 1 }, -- plat armor
			[4] = { type = "item", item = 3557, count = 1 }, -- plate legs
			[5] = { type = "experience", amount = 2000 },
		},
	},
	[5023] = {
		minLevel = 12,
		items = {
			[1] = {
				type = "item",
				item = 5921,
				count = 1,
				aid = 111,
				desc = { ["PL"] = "smiechawaTV", ["EN"] = "laughter" },
			}, -- heaven blossom
			[2] = { type = "experience", amount = 2000 },
		},
	},
}
