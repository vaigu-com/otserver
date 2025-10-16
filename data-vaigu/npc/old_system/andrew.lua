local name = "Andrew"
local outfit = {
	lookType = 160,
	lookHead = 97,
	lookBody = 95,
	lookLegs = 58,
	lookFeet = 114,
	lookAddons = 0,
}

local customDialogs = {
	[{ GREET }] = {
		text = "Hello |PLAYERNAME|. You want {help} with some grinding?",
	},
	[{ "help", "pomoc" }] = {
		text = "If you have some small enchanted sapphires, I can turn them into sapphire {dust} for you.",
	},
	[{ "dust", "proch" }] = {
		text = "Here you go.",
		requiredItems = {
			{ id = 675 },
		},
		rewards = {
			{ id = 30004 },
		},
		textNoRequiredItems = "Yeah, maybe if you had some.",
	},
}

local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	walkRadius = 0,
}
NpcRegistry:AppendNpcData(context)
