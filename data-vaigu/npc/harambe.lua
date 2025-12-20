local name = "Harambe"
local outfit = {
	lookType = 116,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "AAAHRRRRRRRR AAAHRRRRRRR AAAHRRRRRRR" },
	{ text = "HUUHHHH HUUUUHHHH HUHHHHHH" },
	{ text = "AAWRRHH AAAWRRRHHH AWRRRH" },
	{ text = "AGRRRRH AAAAGRRRHHH" },
	{ text = "Za  GRRRHH ekwipunek AGRRH wynagrodze was  HRRHH zlotem" },
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
