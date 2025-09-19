local name = "Train Guard"
local outfit = {
	lookType = 512,
	lookHead = 12,
	lookBody = 76,
	lookLegs = 75,
	lookFeet = 76,
	lookAddons = 2,
}
local dialogs = {
	[{ ANY_MESSAGE }] = {
		specialActionsOnSuccess = {
			{
				action = SPECIAL_ACTIONS_UNIVERSAL.dealDamageNonLethal,
				damage = 500,
				damageType = COMBAT_PHYSICALDAMAGE,
				magicEffect = CONST_ME_POFF,
			},
			{ action = SPECIAL_ACTIONS_UNIVERSAL.endDialog },
			{ action = SPECIAL_ACTIONS_UNIVERSAL.npcSay, talkType = TALKTYPE_SAY, text = "What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived." },
		},
	},
	[{ GREET }] = {
		text = "What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived.",
		specialActionsOnSuccess = {
			{
				action = SPECIAL_ACTIONS_UNIVERSAL.dealDamageNonLethal,
				damage = 500,
				damageType = COMBAT_PHYSICALDAMAGE,
				magicEffect = CONST_ME_POFF,
			},
			[SPECIAL_ACTIONS_UNIVERSAL.endDialog] = {},
			[SPECIAL_ACTIONS_UNIVERSAL.npcSay] = {
				talkType = TALKTYPE_SAY,
				text = "What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived.",
			},
		},
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
	spawnedByScript = true,
}
NpcRegistry:AppendNpcData(context)
