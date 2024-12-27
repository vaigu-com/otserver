local name = "Dorian"
local outfit = {
	lookType = 129,
	lookHead = 76,
	lookBody = 35,
	lookLegs = 78,
	lookFeet = 78,
	lookAddons = 2,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Luki, kusze, amunicja to moj chleb powszedni" },
	{ text = "Codziennie z rana ostrze grot kazdej wloczni" },
	{ text = "Kusza czy luk?" },
}
local context = {
	name = name,
	greetJob = JOB_DISTANCE_SOULORB,
	jobs = { JOB_DISTANCE, JOB_SOULORB },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
