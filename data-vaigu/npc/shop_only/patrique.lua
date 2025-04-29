local name = "Patrique"
local outfit = {
	lookType = 1251,
	lookHead = 68,
	lookBody = 62,
	lookLegs = 57,
	lookFeet = 115,
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
