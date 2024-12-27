local name = "Ali Baba"
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
		[{ "fly", "poleciec", "yes", "tak" }] = {
			text = "",
			specialActionsOnSuccess = {
				{
					action = CreateTransportWindow,
					transports = TRANSPORT_ROUTES.ALI_BABA_CARPET,
					transportType = TRANSPORT_TYPE.CARPET,
				},
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.playerIsPzLocked,
					requiredOutcome = false,
					textNoRequiredCondition = "Looks like you have fought someone.. Better step away, I can't trust you.",
				},
			},
		},
		[ GREET ] = {
			text = "Hello, traveler. Would you like me to {fly} you somewhere?",
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
