local name = "Woody"
local outfit = {
	lookType = 102,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Chlop jak domb ze mnie, nie ma co" },
	{ text = "Kazda ksiazke czytam z zaciekawieniem od deski do deski" },
	{ text = "Ehh te korniki ciagle mnie gryza i nie daja mi spokoju" },
	{
		text = "Podobno kiedys bylem malym chlopcem ale potem zamienilem sie w drewno",
	},
	{ text = "Pinokio moj syjamski blizniaku, tesknie za Toba..." },
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
