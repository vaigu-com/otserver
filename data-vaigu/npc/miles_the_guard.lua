local name = "Miles, The Guard"
local outfit = {
	lookType = 131,
	lookHead = 0,
	lookBody = 19,
	lookLegs = 19,
	lookFeet = 19,
	lookAddons = 0,
}
local dialogs = {
	[{ "camp", "obozu", "oboz" }] = {
		text = "Nearest bandit camp is located east from here. Moustachilles is the leader there.",
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
