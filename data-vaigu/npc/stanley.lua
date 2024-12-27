local name = "Stanley"
local outfit = {
	lookType = 131,
	lookHead = 97,
	lookBody = 22,
	lookLegs = 97,
	lookFeet = 57,
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
