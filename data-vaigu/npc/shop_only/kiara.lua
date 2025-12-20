local name = "Kiara"
local outfit = {
	lookType = 147,
	lookHead = 19,
	lookBody = 95,
	lookLegs = 131,
	lookFeet = 114,
	lookAddons = 1,
}

local context = {
	name = name,
	greetJob = JOB_JEWELLER,
	jobs = { JOB_JEWELLER },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
