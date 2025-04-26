local name = "Dejo-Nara"
local outfit = {
	lookType = 270,
	lookHead = 110,
	lookBody = 123,
	lookLegs = 17,
	lookFeet = 76,
	lookAddons = 0,
}

local context = {
	name = name,
	greetJob = JOB_JEWELLER,
	jobs = { JOB_JEWELLER },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
