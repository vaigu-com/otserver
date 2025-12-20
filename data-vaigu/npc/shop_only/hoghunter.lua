local name = "Hoghunter"
local outfit = {
	lookType = 1186,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 116,
	lookFeet = 76,
	lookAddons = 1,
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
