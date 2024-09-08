local outfit = {
	lookType = 144,
	lookHead = 120,
	lookBody = 78,
	lookLegs = 94,
	lookFeet = 78,
	lookAddons = 3,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Kazdy Wiedzmin zaczynal od taskow!" },
	{ text = "Ze potwory to niby nie potwory? I moze mam je jeszcze dokarmiac?" },
	{ text = "Te bestie zjedza cie przy pierwszej okazji, wiec nie mow mi ze to lagodne zwierzeta!" },
	{ text = "Ludzie, ludzie! Te gady trzeba wytepic raz na zawsze z naszego swiata!" },
	{ text = "Kiedys ten swiat byl przyjazny. Te potwory niszcza wszystko co napotkaja." },
	{ text = "Nie chce zeby moje dzieci zyly wsrod potworow!" },
}
local context = {
	name = "The Great Tracker",
	greetJob = JOB_TASKS_IMBUING,
	jobs = { JOB_TASKS, JOB_IMBUING },
	outfit = outfit,
	voices = voices,
}

local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
