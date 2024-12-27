local name = "Jack Sparrow"
local outfit = {
	lookType = 289,
	lookHead = 2,
	lookBody = 67,
	lookLegs = 39,
	lookFeet = 76,
	lookAddons = 1,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Parostatkiem w piekny rejs..." },
	{ text = "...Zabiore Cie wlasnie tam, gdzie pustyni zloty piach..." },
	{ text = "Zapraszam na poklad, poplyniemy w miejsca o ktorych nie sniles..." },
	{ text = "...Przy wtorze klatw bosmana..." },
}
local dialogs = {
	[LOCALIZERS.LOCALIZER_UNIVERSAL] = {
		[{ "sail", "plynac" }] = {
			text = "",
			specialActionsOnSuccess = {
				{
					action = CreateTransportWindow,
					transports = TRANSPORT_ROUTES.JACK_SPARROW_SHIP,
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
			text = "Hello, Im Jack Sparrow - Caribbean King! Would you like to {sail} somewhere?",
		},
		[{ "wood", "drewno", "supply", "dostawa" }] = {
			text = "Ask Woody about the wood supply.",
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
