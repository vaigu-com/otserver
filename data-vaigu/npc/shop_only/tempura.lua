local name = "Tempura"
local outfit = {
	lookType = 1332,
	lookHead = 116,
	lookBody = 38,
	lookLegs = 95,
	lookFeet = 0,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
