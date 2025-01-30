local name = "Tarzan"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}
local dialogs = {
	[{ "sail", "plynac" }] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTransportWindow,
				transports = TRANSPORT_ROUTES.TARZAN_SHIP,
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
	[GREET] = { "You you like me to sail you anywhere?" },
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
