local name = "Boboeater"
local outfit = {
	lookType = 881,
	lookHead = 63,
	lookBody = 0,
	lookLegs = 38,
	lookFeet = 116,
	lookAddons = 2,
}
local dialogs = {
	[LOCALIZERS.LOCALIZER_UNIVERSAL] = {
		[{ ANY_MESSAGE }] = {
			text = "They call me reborn eater, because i have a mortar for reborns in my pants, if you know what i mean. Bring me a fresh Reborn boy, and i will let you go.",
		},
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
