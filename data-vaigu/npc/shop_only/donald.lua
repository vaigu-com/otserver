local name = "Donald"
local outfit = {
	lookType = 132,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 130,
	lookFeet = 95,
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
