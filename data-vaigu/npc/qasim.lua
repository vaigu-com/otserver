local name = "Qasim"
local outfit = {
	lookType = 610,
	lookHead = 76,
	lookBody = 20,
	lookLegs = 114,
	lookFeet = 19,
	lookAddons = 0,
}
local context = {
	name = name,
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON, JOB_JEWELLER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
