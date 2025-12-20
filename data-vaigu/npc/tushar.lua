local name = "Tushar"
local outfit = {
	lookType = 367,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
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
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
