Storage.RaajAssassinOutfit = {}
QuestRewards.OutfitsAddons.Universal.Assassin0 = {
	{ outfitId = 152, addons = 0 },
	{ outfitId = 156, addons = 0 },
}

local name = "Ra'Aj"
local outfit = {
	lookType = 1490,
	lookHead = 0,
	lookBody = 91,
	lookLegs = 83,
	lookFeet = 79,
	lookAddons = 3,
}

local outfitRequiredItems = {
	{ id = 5898, count = 30 },
	{ id = 5882, count = 10 },
	{ id = 5881, count = 30 },
	{ id = 5895, count = 20 },
	{ id = 5905, count = 20 },
	{ id = 5906, count = 10 },
}
local customDialogs = {
	[{ GREET }] = {
		text = "Hello, are you interested in trading some gems? Or perhaps you want to help me with my {outfit} collection?",
		requiredState = {
			[Storage.RaajAssassinOutfit] = MISSION_NOT_STARTED,
		},
	},
	[{ GREET }] = {
		text = JOB_GREETING[JOB_JEWELLER],
		requiredState = {
			[Storage.RaajAssassinOutfit] = MISSION_FINISHED,
		},
	},
	[{ "outfit", "strojami" }] = {
		text = "Here you go.",
		requiredItems = outfitRequiredItems,
		textNoRequiredItems = YOU_NEED_TO_BRING_THE_FOLLOWING_ITEMS,
		requiredState = {
			[Storage.RaajAssassinOutfit] = MISSION_NOT_STARTED,
		},
		nextState = {
			[Storage.RaajAssassinOutfit] = MISSION_FINISHED,
		},
		outfitRewards = QuestRewards.OutfitsAddons.Universal.Assassin0,
	},
}

local context = {
	name = name,
	greetJob = JOB_JEWELLER,
	jobs = { JOB_JEWELLER },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
