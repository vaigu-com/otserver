local name = "Mazarinn"
local outfit = {
	lookType = 128,
	lookHead = 57,
	lookBody = 27,
	lookLegs = 105,
	lookFeet = 76,
	lookAddons = 1,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Przesylki kurierskie z Aliexpress tanio !" },
	{ text = "Przez te internety ludzie wysylaja coraz mniej listow..." },
}
local context = {
	name = name,
	greetJob = JOB_POST,
	jobs = { JOB_POST, JOB_BANK },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
