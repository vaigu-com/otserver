local name = "Monica"
local outfit = {
	lookType = 142,
	lookHead = 52,
	lookBody = 12,
	lookLegs = 38,
	lookFeet = 19,
	lookAddons = 1,
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
	greetJob =  JOB_MAGIC_WILDCARD,
	jobs = { JOB_MAGIC, JOB_WILDCARD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
