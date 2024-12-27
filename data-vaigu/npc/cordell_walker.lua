local name = "Cordell Walker"
local outfit = {
	lookType = 289,
	lookHead = 96,
	lookBody = 78,
	lookLegs = 114,
	lookFeet = 97,
	lookAddons = 3,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Mam pewne ciekawe informacje o tutejszym terenie..." },
	{ text = "Moim glownym towarem eksportowym jest bol." },
	{ text = "Gdybym jadl wegiel, sralbym diamentami." },
	{ text = "Ochronie ta czesc mirko przed bandytami kopem z polobrotu." },
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
