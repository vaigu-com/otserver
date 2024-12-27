local name = "Estep"
local outfit = {
	lookType = 154,
	lookHead = 78,
	lookBody = 132,
	lookLegs = 117,
	lookFeet = 117,
	lookAddons = 2,
}
local context = {
	name = name,
	jobs = { JOB_CREATURE_PRODUCT },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
