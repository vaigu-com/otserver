local name = "Hemant"
local outfit = {
	lookType = 153,
	lookHead = 108,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 94,
	lookAddons = 2,
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
