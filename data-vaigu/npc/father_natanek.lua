local dialogs = {
	[Storage.AssassinsCreedSquurvaali.Localizer] = {
		[Storage.AssassinsCreedSquurvaali.Mission01] = {
			[1] = {
				[{ "mission", "duch", "Ghasstly Princess", "ghasstly princess" }] = {
					text = "If what you're saying is true - and I have no reason to doubt the words of my faithful |PLAYERNAME| - go to {Oldrak}. He will surely know how to help you.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission01] = 2,
					},
				},
			},
			[{ min = 2 }] = {
				[{ "oldrak" }] = {
					text = "Oldrak has currently gone to the steppes. He is teaching the villagers there.",
				},
			},
		},
		[Storage.AssassinsCreedSquurvaali.Mission05] = {
			[4] = {
				[{ "krol krypty", "crypt king", "king of the crypt", "king", "krol" }] = {
					text = "I will be the harbinger of bad news. The Crypt King has managed to regain a portion of power by consuming the essence of a defeated angel. The Crypt King may attempt to regain strength in the Down's Labyrinth. To prevent this, you will need the assistance of Gandalf.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission05] = 5,
					},
				},
			},
		},
	},
}
local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Zaczal diabel jak wsciekniety atakowac, wiedz ze cos sie dzieje...",
	},
	{ text = "Lepiej dac na tace i kupic te blessy, licho nie spi..." },
	{
		text = "Harry Potter, Gwiezdne Wojny, akupunktura, astrologia, bioenergoterapia...",
	},
	{ text = "Horoskopy, Magia, Numerologia, Okultyzm, Tarot, Techno..." },
}

local outfit = {
	lookType = 432,
	lookHead = 0,
	lookBody = 95,
	lookLegs = 20,
	lookFeet = 38,
	lookAddons = 0,
}
local context = {
	name = "Father Natanek",
	greetJob = JOB_MARRIAGE_BLESS,
	jobs = { JOB_MARRIAGE, JOB_BLESS },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}

local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
