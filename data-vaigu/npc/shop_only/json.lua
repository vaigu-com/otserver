local name = "Json"
local outfit = {
	lookType = 760,
	lookHead = 7,
	lookBody = 114,
	lookLegs = 129,
	lookFeet = 115,
	lookAddons = 0,
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
