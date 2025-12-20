local name = "Jew"
local outfit = {
	lookType = 130,
	lookHead = 38,
	lookBody = 76,
	lookLegs = 57,
	lookFeet = 76,
	lookAddons = 0,
}
local context = {
	name = name,
	greetJob = JOB_POST,
	jobs = { JOB_POST },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
