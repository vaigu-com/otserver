local name = "Greg"
local outfit = {
	lookType = 128,
	lookHead = 76,
	lookBody = 31,
	lookLegs = 20,
	lookFeet = 20,
	lookAddons = 1,
}
local context = {
	name = name,
	greetJob = JOB_UTILITY,
	jobs = { JOB_UTILITY },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
