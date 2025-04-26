local name = "Gus"
local outfit = {
	lookType = 931,
	lookHead = 76,
	lookBody = 48,
	lookLegs = 122,
	lookFeet = 57,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_FOOD,
	jobs = { JOB_FOOD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
