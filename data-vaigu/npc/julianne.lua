local name = "Julianne"
local outfit = {
	lookType = 155,
	lookHead = 2,
	lookBody = 35,
	lookLegs = 32,
	lookFeet = 15,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Mikstury, runy, magia !" },
	{ text = "Sklep magiczny, zapraszam, pelen asortyment !" },
	{ text = "Magiczne napoje i runy na wyprawe zawsze sie przydadza..." },
	{ text = "Abrakadabra, to czary i magia..." },
}
local context = {
	name = name,
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_MAGIC, JOB_WILDCARD },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
