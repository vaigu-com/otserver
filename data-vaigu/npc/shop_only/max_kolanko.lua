local name = "Max Kolanko"
local outfit = {
	lookType = 278,
	lookHead = 0,
	lookBody = 76,
	lookLegs = 19,
	lookFeet = 96,
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
