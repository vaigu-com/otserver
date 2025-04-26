local name = "FejsFak"
local outfit = {
	lookType = 154,
	lookHead = 44,
	lookBody = 59,
	lookLegs = 114,
	lookFeet = 0,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_FURNITURE,
	jobs = { JOB_FURNITURE },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
