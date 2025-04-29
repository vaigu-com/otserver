local name = "Kreon"
local outfit = {
	lookType = 1680,
	lookHead = 58,
	lookBody = 95,
	lookLegs = 116,
	lookFeet = 120,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_POST, JOB_BANK },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
