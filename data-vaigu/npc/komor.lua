local dialogues = {
	[Storage.TrudnePoczatki.KomorAsked] = {
		[{ max = 0 }] = {
			[{ "help", "pomoc" }] = {
				text = "Wood, wood delivery. It was supposed to arrive two days ago. Probably another riots in Knurow that blocked the road.",
				requiredState = { [Storage.TrudnePoczatki.Rozeznanie] = 2 },
				nextState = {
					[Storage.TrudnePoczatki.KomorAsked] = 1,
					[Storage.TrudnePoczatki.Rozeznanie] = "+1",
				},
				textNoRequiredState = "Better visit Commissioner Fisher first, I cant trust you now.",
			},
		},
	},
	[Storage.IKEAdlazuchwalych.RemanentMain] = {
		[-1] = {
			[{ "misja", "mission" }] = {
				text = "There is one problem with which you could help me. Some furnitures started to disappear from my storages.\nI know for sure that it wasnt Waski's mafia, because they are using wood for different purposes, they are not interested in my furnitures.\nDo you want to find for me who is responsible for stealing my furnitures?",
				requiredState = { [Storage.TrudnePoczatki.DostawaDrewna] = 4 },
			},
			[{ "yes", "tak" }] = {
				text = "Thanks that you agreed to {help}. I hope that its not another mafia.",
				requiredState = { [Storage.TrudnePoczatki.DostawaDrewna] = 4 },
				nextState = { [Storage.IKEAdlazuchwalych.RemanentMain] = 1 },
			},
		},
		[1] = {
			[{ "misja", "mission" }] = {
				text = "Maybe Gypsy knows something about furnitures thief, people like him sticks together...",
				nextState = { [Storage.IKEAdlazuchwalych.RemanentMain] = 2 },
			},
		},
		[2] = {
			[{ "misja", "mission" }] = {
				text = "Maybe Gypsy knows something about furnitures thief, people like him sticks together...",
			},
		},
		[5] = {
			[{ "misja", "mission" }] = {
				text = "Thank you for finding perpetrator. Your reward is upstairs, here is the key to the door.\nMeanwhile I will call to two almighty Mirks, so they will bring my stolen stuff from those undergrounds",
				nextState = { [Storage.IKEAdlazuchwalych.RemanentMain] = 6 },
				rewards = {
					{ id = 2972, actionid = 5008 }, -- ehhhhhhh
				},
				experienceReward = 30000,
			},
		},
		[6] = {
			[{ "list", "lista" }] = {
				text = "I checked the list of stolen items, I saw that he had a ball that Gypsy was looking for. Wait, its not {all}.",
			},
			[{ "all", "wszystko" }] = {
				text = "Recent entries on the list suggest that our thief was stealing food and supplies from the orcs of the south.\nGo to Commissioner Fisher please and tell him about it. Also ask him if he knows something about that thief.",
			},
		},
	},
}
local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Antyki, meble z Ikei, wszystko czego zapragniesz ! Nasz klient nasz pan !",
	},
	{ text = "Pssst, nie chcesz moze zyrandolu z Palacu Prezydenckiego?" },
	{
		text = "Kiedy pytaja mnie co robie aktualnie odpowiadam: handluje meblami !",
	},
	{ text = "Nareszcie wzialem kredyt i zmienilem prace !" },
	{
		text = "Witam, witam, prosze zerknac na asortyment krzesel jaki posiadam, zaiste wyborny!",
	},
	{ text = "Paaaanie kochany, te meble to prosto z Belwederu !" },
}

local outfit = {
	lookType = 273,
	lookHead = 0,
	lookBody = 81,
	lookLegs = 93,
	lookFeet = 0,
	lookAddons = 3,
}
local context = {
	name = "Komor",
	greetJob = JOB_FURNITURE,
	jobs = { JOB_FURNITURE },
	outfit = outfit,
	dialogues = dialogues,
	voices = voices,
}
local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
