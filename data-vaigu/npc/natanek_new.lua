local dialogs = {
	[LOCALIZER_UNIVERSAL] = {
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