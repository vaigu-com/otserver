local name = "Arni"
local outfit = {
	lookType = 131,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "NIE WIEM CO O TYM MYSLEC..." },
	{ text = "Jak chcesz to dam ci pewne informacje.." },
	{ text = "Kaaaasiu mam dla Ciebie kwiaaatyyy" },
	{ text = "Moim idolem jest Arnold Schwarzenegger" },
	{ text = "KTO POMALOWAL RURY?" },
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
