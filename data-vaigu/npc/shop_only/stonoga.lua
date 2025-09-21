local name = "Stonoga"
local outfit = {
	lookType = 1774,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 120,
	lookFeet = 95,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_FISHER,
	jobs = { JOB_FISHER },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
