local name = "Zong"
local outfit = {
	lookType = 698,
	lookHead = 74,
	lookBody = 114,
	lookLegs = 82,
	lookFeet = 85,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_JEWELLER,
	jobs = { JOB_JEWELLER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
