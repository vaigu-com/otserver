local name = "Theseus"
local outfit = {
	lookType = 143,
	lookHead = 57,
	lookBody = 40,
	lookLegs = 34,
	lookFeet = 33,
	lookAddons = 1,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Zebrales sporo zelastwa? Smialo, pohandlujmy.." },
	{ text = "Skupie ekwipunek jaki zebrales w korzystnej cenie !" },
}
local context = {
	name = name,
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
