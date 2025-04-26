local name = "Kirill"
local outfit = {
	lookType = 1581,
	lookHead = 2,
	lookBody = 114,
	lookLegs = 83,
	lookFeet = 94,
	lookAddons = 2,
}

local context = {
	name = name,
	greetJob = JOB_DAILYTASKS_GOLDENOUTFIT,
	jobs = { JOB_DAILYTASK, JOB_GOLDENOUTFIT },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
