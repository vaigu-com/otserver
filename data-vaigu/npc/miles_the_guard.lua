local name = "Miles, The Guard"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}
local dialogs = {
	[LOCALIZERS.LOCALIZER_UNIVERSAL] = {
		[{ "thief", "zlodziej" }] = {
			text = "I dint see anything suspicious.",
		},
	},
	[Storage.TheInquisition.MilesGuard] = {
		[{ max = 0 }] = {
			[{ "trouble", "problemy" }] = {
				text = "I'm fine. There's no trouble at all.",
				requiredState = {
					[Storage.TheInquisition.Mission01] = { neq = MISSION_NOT_STARTED },
				},
				nextState = {
					[Storage.TheInquisition.MilesGuard] = 1,
					[Storage.TheInquisition.Mission01] = "+1",
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectPlayer,
					},
				},
			},
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
