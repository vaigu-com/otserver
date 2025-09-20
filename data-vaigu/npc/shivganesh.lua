local name = "Shivganesh"
local outfit = {
	lookType = 146,
	lookHead = 96,
	lookBody = 57,
	lookLegs = 0,
	lookFeet = 97,
	lookAddons = 3,
}
local context = {
	name = name,
	greetJob = JOB_FOOD,
	jobs = { JOB_FOOD },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
