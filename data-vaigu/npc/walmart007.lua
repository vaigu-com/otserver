local dialogs = {
	[Storage.StickyBeginning.WalmartAsked] = {
		[-1] = {
			[{ "help", "pomoc" }] = {
				text = "No need, but if you know some way to get rid of {rats} once and for all, tell me.",
				requiredState = { [Storage.StickyBeginning.Discernment] = 2 },
				nextState = {
					[Storage.StickyBeginning.WalmartAsked] = 1,
					[Storage.StickyBeginning.Discernment] = "+1",
				},
				textNoRequiredState = "It's alright, I don't need any help.",
			},
		},
	},
	[Storage.LocalSupport.FreakingRats] = {
		[-1] = {
			
		},
		[{ min = 1, max = 3 }] = {
			[{ "help", "pomoc" }] = {
				text = "Well, I'm waiting for this poison that will help me exterminate the rats.",
			},
		},
		[3] = {

		},
		[{ min = 4 }] = {
			[{ "help", "pomoc" }] = {
				text = "It's alright, I don't need any help.",
			},
		},
		[4] = {
			[{ "szczur", "szczurow", "rat", "rats" }] = {
				text = "Rats are gone, thanks again.",
			},
			[{ "flaszke", "flaszka", "flask" }] = {
				text = "I heard that it brings you luck, if you catch one of fireflies from magical tree into that.",
			},
		},
	},
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Ten Lidl ciagle probuje kopiowac moje promocje..." },
	{ text = "Promocja na piersi z kurczaka i stejki ! Robcie zapasy !" },
	{ text = "Swieze warzywa i owoce w korzystnych cenach !" },
	{
		text = "Dostawcy bananow dalej nie spelniaja wymogow unijnych wzgledem ich krzywizny...A kare zaplace ja !",
	},
	{ text = "Kukurydza, ziemniaki, marchew, rzodkiew, wszystko bez GMO ! " },
}

local outfit = {
	lookType = 136,
	lookHead = 20,
	lookBody = 100,
	lookLegs = 50,
	lookFeet = 99,
	lookAddons = 3,
}
local context = {
	name = "Walmart007",
	greetJob = JOB_FOOD,
	jobs = { JOB_FOOD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}

NpcRegistry:AppendNpcData(context)
