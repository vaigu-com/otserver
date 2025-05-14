local name = "Dampreefer"
local outfit = {
	lookType = 1279,
	lookHead = 22,
	lookBody = 45,
	lookLegs = 68,
	lookFeet = 98,
	lookAddons = 1,
}
local context = {
	name = name,
	greetJob = JOB_FOOD,
	jobs = { JOB_FOOD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
