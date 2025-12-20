local name = "Blantix"
local outfit = {
	lookType = 1051,
	lookHead = 39,
	lookBody = 132,
	lookLegs = 114,
	lookFeet = 113,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
