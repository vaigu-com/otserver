local name = "Groover"
local outfit = {
	lookType = 908,
	lookHead = 0,
	lookBody = 34,
	lookLegs = 26,
	lookFeet = 116,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_BANK },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
