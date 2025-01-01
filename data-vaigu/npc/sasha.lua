local name = "Sasha"
local outfit = {
	lookType = 146,
	lookHead = 97,
	lookBody = 22,
	lookLegs = 22,
	lookFeet = 117,
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
