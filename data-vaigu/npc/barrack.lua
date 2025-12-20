local name = "Barrack"
local outfit = {
	lookType = 289,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Wykopali mnie z White Housa i teraz robota na poczcie..." },
	{ text = "Skad bierzecie takie dzwonki?" },
	{ text = "Jesli szukasz poczty to dobrze trafiles" },
	{ text = "Dzieki takim jak ty kiedys zostalem prezydentem" },
	{ text = "Co ten Trump teraz odwala to ja nawet nie..." },
}
local customDialogs = {
	[{ GREET }] = {
		text = "Ooga Booga, |PLAYERNAME|. I heard you looking for some loud. {Trade} if you need some, playa. If you good then bounce lil nigga, we be tryin' to hustle.",
	},
}
local context = {
	name = name,
	jobs = { JOB_POST, JOB_BANK },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
