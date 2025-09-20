local name = "Moustachilles"
local outfit = {
	lookType = 268,
	lookHead = 97,
	lookBody = 38,
	lookLegs = 95,
	lookFeet = 114,
	lookAddons = 0,
}

local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	incomprehensibleError = "Go away, or even better: flip off.",
}
NpcRegistry:AppendNpcData(context)
