local name = "Amee"
local outfit = {
	lookType = 136,
	lookHead = 19,
	lookBody = 76,
	lookLegs = 104,
	lookFeet = 73,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_BANK },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
