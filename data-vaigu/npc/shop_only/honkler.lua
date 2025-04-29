local name = "Honkler"
local outfit = {
	lookType = 153,
	lookHead = 54,
	lookBody = 118,
	lookLegs = 79,
	lookFeet = 131,
	lookAddons = 2,
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
