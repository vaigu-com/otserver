local name = "Ha'Shish"
local outfit = {
	lookType = 1243,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 116,
	lookFeet = 76,
	lookAddons = 1,
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
