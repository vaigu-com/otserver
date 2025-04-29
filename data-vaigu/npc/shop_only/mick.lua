local name = "Mick"
local outfit = {
	lookType = 1056,
	lookHead = 52,
	lookBody = 62,
	lookLegs = 57,
	lookFeet = 115,
	lookAddons = 0,
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
