local dialogs = {
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Luki, kusze, amunicja to moj chleb powszedni" },
	{ text = "Codziennie z rana ostrze grot kazdej wloczni" },
	{ text = "Co drugi przychodzi i krzyczy daaaaaj kamieniaaaaaa" },
	{ text = "Za Tuska to sie dobrze krecil interes a teraz..." },
	{ text = "Kusza czy luk? Zapraszam do debaty..." },
}
local outfit = {
	lookType = 134,
	lookHead = 57,
	lookBody = 59,
	lookLegs = 40,
	lookFeet = 76,
	lookAddons = 0,
}
local context = {
	name = "Lebesgue The Philosopher",
	greetJob = JOB_DISTANCE_SOULORB,
	jobs = { JOB_SOULORB, JOB_DISTANCE },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}

NpcRegistry:AppendNpcData(context)
