local name = "Green Obi"
local outfit = {
	lookType = 289,
	lookHead = 0,
	lookBody = 121,
	lookLegs = 115,
	lookFeet = 0,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_FURNITURE,
	jobs = { JOB_FURNITURE },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
