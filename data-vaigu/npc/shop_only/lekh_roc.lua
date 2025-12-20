local name = "Lekh Roc"
local outfit = {
	lookType = 1251,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 119,
	lookFeet = 95,
	lookAddons = 3,
}

local context = {
	name = name,
	greetJob = JOB_JEWELLER,
	jobs = { JOB_JEWELLER },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
