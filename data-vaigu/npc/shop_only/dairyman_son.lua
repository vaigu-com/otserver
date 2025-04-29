local name = "Dairyman Son"
local outfit = {
	lookType = 1371,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 116,
	lookFeet = 95,
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
