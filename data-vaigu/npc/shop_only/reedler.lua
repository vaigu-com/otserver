local name = "Reedler"
local outfit = {
	lookType = 463,
	lookHead = 1,
	lookBody = 120,
	lookLegs = 82,
	lookFeet = 131,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_FISHER,
	jobs = { JOB_FISHER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
