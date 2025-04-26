local name = "Stuu"
local outfit = {
	lookType = 610,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 116,
	lookFeet = 76,
	lookAddons = 2,
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
