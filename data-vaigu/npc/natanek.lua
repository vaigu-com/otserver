local dialogs = {
	[Storage.AssassinsCreedSquurvaali.Questline] = {
		[1] = {
			[{ "mission", "duch", "Ghasstly Princess", "ghasstly princess" }] = {
				text = "If what you're saying is true - and I have no reason to doubt the words of my faithful |PLAYERNAME| - go to {Oldrak}. He will surely know how to help you.",
				nextState = {
					[Storage.AssassinsCreedSquurvaali.Mission01] = 2,
					[Storage.AssassinsCreedSquurvaali.Questline] = 2,
				},
			},
		},
		[{ min = 2 }] = {
			[{ "oldrak" }] = {
				text = "Oldrak has currently gone to the steppes. He is teaching the villagers there.",
			},
		},
		[17] = {
			[{ "krol krypty", "crypt king", "king of the crypt", "king", "krol" }] = {
				text = "I will be the harbinger of bad news. The Crypt King has managed to regain a portion of power by consuming the essence of a defeated angel. The Crypt King may attempt to regain strength in the Down's Labyrinth. To prevent this, you will need the assistance of Gandalf.",
				nextState = {
					[Storage.AssassinsCreedSquurvaali.Questline] = 18,
					[Storage.AssassinsCreedSquurvaali.Mission05] = 5,
				},
			},
		},
	},
	[Storage.SultanPrime.Questline] = {
		[{ "mission", "misja", "naszyjnik", "amulet", "necklace" }] = {
			text = "I'd prefer this information to stay between us. Let's agree that you'll take what I received from the faithful today, and in exchange, you'll forget what Sultan showed you.",
			nextTopic = 10,
		},
		[{ "dostalem", "donated" }] = {
			requiredtopic = { min = 10, max = 10 },
			nextTopic = 0,
			text = "Here, this is your reward.",
			nextState = {
				[Storage.SultanPrime.Questline] = 14,
				[Storage.SultanPrime.Mission03] = 6,
			},
			rewards = { { id = 3043, count = 2 } },
			expReward = 800000,
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
	name = "Father Natanek New",
	greetJob = JOB_MARRIAGE_BLESS,
	jobs = { JOB_MARRIAGE, JOB_BLESS },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}

local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
