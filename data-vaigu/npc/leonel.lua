local name = "Leonel"
local outfit = {
	lookType = 129,
	lookHead = 117,
	lookBody = 97,
	lookLegs = 117,
	lookFeet = 42,
	lookAddons = 3,
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
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
