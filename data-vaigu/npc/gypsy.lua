local name = "Gypsy"
local outfit = {
	lookType = 430,
	lookHead = 97,
	lookBody = 1,
	lookLegs = 116,
	lookFeet = 114,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Piekny panie, daj pan zloty pierscionek ja powrozyc..." },
	{
		text = "Spokojnie, nie okradne Cie, mozesz sprzedac u mnie swoje kosztownosci...",
	},
	{ text = "Cooo? Yyyy no tego, mial kurde" },
	{ text = "Byla sakwa z hajsem, nie ma sakwy" },
}
local dialogs = {
	[{ GREET }] = {
		text = "NECK NECK NEEEECKLACES ONLY FOR TWO BUCKS, CHEAP RINGS FOR PRETTY LADIEEES, {LIFE CRYSTAL} EXCHANGE! Take a look at my offer!",
	},
	[{ FAREWELL }] = {
		text = "Bye, be aware of pickpockets!",
	},
}
local context = {
	name = name,
	jobs = { JOB_JEWELLER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
