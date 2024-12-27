local name = "Funfel"
local outfit = {
	lookType = 154,
	lookHead = 114,
	lookBody = 49,
	lookLegs = 125,
	lookFeet = 0,
	lookAddons = 2,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Mikstury, runy, magia !" },
	{
		text = "Ale w tej dzungli goraco i wilgotno, a klimatyzacji nie ma do dzis....",
	},
	{ text = "Sklep magiczny, Funfel zaprasza, pelen asortyment !" },
	{ text = "Magiczne napoje i runy na wyprawe zawsze sie przydadza..." },
	{ text = "Abrakadabra, to czary i magia...." },
	{
		text = "Ehhh, gdyby tylko te cholerne malpy zostawily nasze magazyny w spokoju! Niech ktos pogada z przywodca malp.",
	},
}
local context = {
	name = name,
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_MAGIC, JOB_MAGIC_WILDCARD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
