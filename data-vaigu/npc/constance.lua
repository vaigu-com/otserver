local name = "Constance"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 57,
	lookLegs = 76,
	lookFeet = 57,
	lookAddons = 0,
}
local context = {
	name = name,
	greetJob = JOB_POST,
	jobs = { JOB_POST},
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
