print("ghasstly_princess.lua")
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
	lookType = 1219,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 0,
	lookFeet = 76,
	lookAddons = 0,
}
local context = {
	name = "Ghasstly Princess",
	greetJob = nil,
	jobs = nil,
	outfit = outfit,
	dialogs = nil,
	voices = voices,
}

NpcRegistry:AppendNpcData(context)
