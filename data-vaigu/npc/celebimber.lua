local name = "Celebimber"
local outfit = {
	lookType = 62,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}
local context = {
	name = name,
	greetJob = JOB_DISTANCE,
	jobs = { JOB_DISTANCE, JOB_JEWELLER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
