local name = "Kalyana"
local outfit = {
	lookType = 150,
	lookHead = 108,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 2,
}
local dialogs = {
	[{ GREET }] = {
		text = "As-salamu alaykum, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you.",
	},
}
local context = {
	name = name,
	jobs = { JOB_POST, JOB_BANK },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
