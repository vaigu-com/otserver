local name = "Christopher Columbus"
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
		[{ "sail", "plynac" }] = {
			text = "",
			specialActionsOnSuccess = {
				{
					action = CreateTransportWindow,
					transports = TRANSPORT_ROUTES.CRISTOPHER_COLUMBUS_SHIP,
					transportType = TRANSPORT_TYPE.SHIP,
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
		[GREET] = {
			text = "Hello. I can sail you to steppes, Bornholm and island inhabited by quaras. So where you'd like to {sail} to?",
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
