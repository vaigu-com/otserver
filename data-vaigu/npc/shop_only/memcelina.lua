local name = "Memcelina"
local outfit = {
	lookType = 269,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 130,
	lookFeet = 95,
	lookAddons = 2,
}

local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_BANK },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
