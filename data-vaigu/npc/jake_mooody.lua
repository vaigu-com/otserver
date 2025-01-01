local name = "Jake Mooody"
local outfit = {
	lookType = 131,
	lookHead = 115,
	lookBody = 76,
	lookLegs = 37,
	lookFeet = 116,
	lookAddons = 3,
}
local context = {
	name = name,
	greetJob = JOB_ARMOR_WEAPON ,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
