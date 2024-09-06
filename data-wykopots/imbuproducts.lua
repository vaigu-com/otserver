-- Names only
IMBUING_NAMES = {
	scorch = "scorch",
	venom = "venom",
	frost = "frost",
	electrify = "electrify",
	reap = "reap",
	vampirism = "vampirism",
	void = "void",
	strike = "strike",
	lich_shroud = "lich shroud",
	snake_skin = "snake skin",
	dragon_hide = "dragon hide",
	quara_scale = "quara scale",
	cloud_fabric = "cloud fabric",
	demon_presence = "demon presence",
	chop = "chop",
	slash = "slash",
	bash = "bash",
	precision = "precision",
	blockade = "blockade",
	epiphany = "epiphany",
}

-- Names only
IMBUING_LEVELS = {
	basic = "basic",
	intricate = "intricate",
	powerful = "powerful",
}

-- Names only
IMBUING_CATEGORIES = {
	Support = "Support",
	Offensive = "Offensive",
	Defensive = "Defensive",
	Skill_improving = "Skill improving"
}

local imbuingCategories = {
	[1] = {
		categoryName = IMBUING_CATEGORIES.Support,
		imbuements = {
			IMBUING_NAMES.swiftness,
			IMBUING_NAMES.featherweight,
		},
	},
	[2] = {
		categoryName = IMBUING_CATEGORIES.Offensive,
		imbuements = {
			IMBUING_NAMES.scorch,
			IMBUING_NAMES.venom,
			IMBUING_NAMES.frost,
			IMBUING_NAMES.electrify,
			IMBUING_NAMES.reap,
			IMBUING_NAMES.vampirism,
			IMBUING_NAMES.void,
			IMBUING_NAMES.strike,
		},
	},
	[3] = {
		categoryName = IMBUING_CATEGORIES.Defensive,
		imbuements = {
			IMBUING_NAMES.lich_shroud,
			IMBUING_NAMES.snake_skin,
			IMBUING_NAMES.dragon_hide,
			IMBUING_NAMES.quara_scale,
			IMBUING_NAMES.cloud_fabric,
			IMBUING_NAMES.demon_presence,
		},
	},
	[4] = {
		categoryName = IMBUING_CATEGORIES.Skill_improving,
		imbuements = {
			IMBUING_NAMES.chop,
			IMBUING_NAMES.slash,
			IMBUING_NAMES.bash,
			IMBUING_NAMES.precision,
			IMBUING_NAMES.blockade,
			IMBUING_NAMES.epiphany,
		},
	},
}

function GetImbuingCategories()
	return imbuingCategories
end

local imbuingBundleData = {
	[IMBUING_NAMES.scorch] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9636, count = 25 } },
			moneyCost = 37500,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9636, count = 25 },
				[2] = { id = 5920, count = 5 },
			},
			moneyCost = 38250,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9636, count = 25 },
				[2] = { id = 5920, count = 5 },
				[3] = { id = 5954, count = 5 },
			},
			moneyCost = 43250,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.venom] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9686, count = 25 } },
			moneyCost = 10000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9686, count = 25 },
				[2] = { id = 9640, count = 20 },
			},
			moneyCost = 10000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9686, count = 25 },
				[2] = { id = 9640, count = 20 },
				[3] = { id = 21194, count = 2 },
			},
			moneyCost = 20400,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.frost] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9661, count = 25 } },
			moneyCost = 75000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9661, count = 25 },
				[2] = { id = 21801, count = 10 },
			},
			moneyCost = 85000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9661, count = 25 },
				[2] = { id = 21801, count = 10 },
				[3] = { id = 9650, count = 5 },
			},
			moneyCost = 90000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.electrify] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 18993, count = 25 } },
			moneyCost = 10000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 18993, count = 25 },
				[2] = { id = 21975, count = 5 },
			},
			moneyCost = 12000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 18993, count = 25 },
				[2] = { id = 21975, count = 5 },
				[3] = { id = 23508, count = 1 },
			},
			moneyCost = 12700,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.reap] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 11484, count = 25 } },
			moneyCost = 5000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 11484, count = 25 },
				[2] = { id = 9647, count = 20 },
			},
			moneyCost = 11000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 11484, count = 25 },
				[2] = { id = 9647, count = 20 },
				[3] = { id = 10420, count = 5 },
			},
			moneyCost = 13500,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.vampirism] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9685, count = 25 } },
			moneyCost = 37500,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9685, count = 25 },
				[2] = { id = 9633, count = 15 },
			},
			moneyCost = 150000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9685, count = 25 },
				[2] = { id = 9633, count = 15 },
				[3] = { id = 9663, count = 5 },
			},
			moneyCost = 200000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.void] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 11492, count = 25 } },
			moneyCost = 50000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 11492, count = 25 },
				[2] = { id = 20200, count = 25 },
			},
			moneyCost = 125000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 11492, count = 25 },
				[2] = { id = 20200, count = 25 },
				[3] = { id = 22730, count = 5 },
			},
			moneyCost = 147500,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.strike] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 11444, count = 20 } },
			moneyCost = 40000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 11444, count = 20 },
				[2] = { id = 10311, count = 25 },
			},
			moneyCost = 140000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 11444, count = 20 },
				[2] = { id = 10311, count = 25 },
				[3] = { id = 22728, count = 5 },
			},
			moneyCost = 150000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.lich_shroud] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 11466, count = 25 } },
			moneyCost = 15000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 11466, count = 25 },
				[2] = { id = 22007, count = 20 },
			},
			moneyCost = 75000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 11466, count = 25 },
				[2] = { id = 22007, count = 20 },
				[3] = { id = 9660, count = 5 },
			},
			moneyCost = 79000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.snake_skin] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 17823, count = 25 } },
			moneyCost = 10000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 17823, count = 25 },
				[2] = { id = 9694, count = 20 },
			},
			moneyCost = 20000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 17823, count = 25 },
				[2] = { id = 9694, count = 20 },
				[3] = { id = 11702, count = 10 },
			},
			moneyCost = 30000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.dragon_hide] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 5877, count = 20 } },
			moneyCost = 10000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 5877, count = 20 },
				[2] = { id = 16131, count = 10 },
			},
			moneyCost = 45000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 5877, count = 20 },
				[2] = { id = 16131, count = 10 },
				[3] = { id = 11658, count = 5 },
			},
			moneyCost = 50000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.quara_scale] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 10295, count = 25 } },
			moneyCost = 50000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 10295, count = 25 },
				[2] = { id = 10307, count = 15 },
			},
			moneyCost = 56000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 10295, count = 25 },
				[2] = { id = 10307, count = 15 },
				[3] = { id = 14012, count = 10 },
			},
			moneyCost = 61500,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.cloud_fabric] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9644, count = 20 } },
			moneyCost = 7000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9644, count = 20 },
				[2] = { id = 14079, count = 15 },
			},
			moneyCost = 22000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9644, count = 20 },
				[2] = { id = 14079, count = 15 },
				[3] = { id = 9665, count = 10 },
			},
			moneyCost = 28000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.demon_presence] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9639, count = 25 } },
			moneyCost = 5000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9639, count = 25 },
				[2] = { id = 9638, count = 25 },
			},
			moneyCost = 23750,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9639, count = 25 },
				[2] = { id = 9638, count = 25 },
				[3] = { id = 10304, count = 20 },
			},
			moneyCost = 37750,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.swiftness] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 17458, count = 15 } },
			moneyCost = 10000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 17458, count = 15 },
				[2] = { id = 10302, count = 25 },
			},
			moneyCost = 13000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 17458, count = 15 },
				[2] = { id = 10302, count = 25 },
				[3] = { id = 14081, count = 20 },
			},
			moneyCost = 29000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.featherweight] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 25694, count = 20 } },
			moneyCost = 5000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 25694, count = 20 },
				[2] = { id = 25702, count = 10 },
			},
			moneyCost = 35000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 25694, count = 20 },
				[2] = { id = 25702, count = 10 },
				[3] = { id = 20205, count = 5 },
			},
			moneyCost = 42500,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.chop] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 10196, count = 20 } },
			moneyCost = 8000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 10196, count = 20 },
				[2] = { id = 11447, count = 25 },
			},
			moneyCost = 15500,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 10196, count = 20 },
				[2] = { id = 11447, count = 25 },
				[3] = { id = 21200, count = 20 },
			},
			moneyCost = 45500,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.slash] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9691, count = 25 } },
			moneyCost = 5000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9691, count = 25 },
				[2] = { id = 21202, count = 25 },
			},
			moneyCost = 12500,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9691, count = 25 },
				[2] = { id = 21202, count = 25 },
				[3] = { id = 9654, count = 5 },
			},
			moneyCost = 17500,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.bash] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9657, count = 20 } },
			moneyCost = 1600,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9657, count = 20 },
				[2] = { id = 22189, count = 15 },
			},
			moneyCost = 7600,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9657, count = 20 },
				[2] = { id = 22189, count = 15 },
				[3] = { id = 10405, count = 10 },
			},
			moneyCost = 11600,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.precision] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 11464, count = 25 } },
			moneyCost = 12500,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 11464, count = 25 },
				[2] = { id = 18994, count = 20 },
			},
			moneyCost = 42500,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 11464, count = 25 },
				[2] = { id = 18994, count = 20 },
				[3] = { id = 10298, count = 10 },
			},
			moneyCost = 62500,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.blockade] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9641, count = 20 } },
			moneyCost = 16000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9641, count = 20 },
				[2] = { id = 11703, count = 25 },
			},
			moneyCost = 26000,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9641, count = 20 },
				[2] = { id = 11703, count = 25 },
				[3] = { id = 20199, count = 25 },
			},
			moneyCost = 41000,
			taskPointsCost = 6,
		},
	},
	[IMBUING_NAMES.epiphany] = {
		[IMBUING_LEVELS.basic] = {
			items = { [1] = { id = 9635, count = 25 } },
			moneyCost = 25000,
			taskPointsCost = 2,
		},
		[IMBUING_LEVELS.intricate] = {
			items = {
				[1] = { id = 9635, count = 25 },
				[2] = { id = 11452, count = 15 },
			},
			moneyCost = 77500,
			taskPointsCost = 4,
		},
		[IMBUING_LEVELS.powerful] = {
			items = {
				[1] = { id = 9635, count = 25 },
				[2] = { id = 11452, count = 15 },
				[3] = { id = 10309, count = 15 },
			},
			moneyCost = 91000,
			taskPointsCost = 6,
		},
	},
}

function GetImbuingBundleByName(name)
	return imbuingBundleData[name]
end

local function addAdditionalImbuementBundleData()
	for name, levels in pairs(imbuingBundleData) do
		for levelName in pairs(levels) do
			imbuingBundleData[name][levelName].name = name
			imbuingBundleData[name][levelName].levelName = levelName
		end
		imbuingBundleData[name].name = name
	end
end
addAdditionalImbuementBundleData()
