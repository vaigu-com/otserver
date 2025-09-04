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
	[TRAVEL_KEYWORDS[TRAVEL_METHOD.SHIP]] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTravelWindow,
				travelRoutes = TRAVEL_ROUTES.JACK_SPARROW_SHIP,
				travelMethod = TRAVEL_METHOD.SHIP,
			},
		},
		specialRequirements = {
			{
				requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerIsPzLocked,
				requiredOutcome = false,
				textFailedRequirement = "Looks like you have fought someone.. Better step away, I can't trust you.",
			},
		},
	},
	[{ GREET }] = {
		text = "Hello, Im Jack Sparrow - Caribbean King! Would you like to {sail} somewhere?",
	},
	[{ "wood", "drewno", "supply", "dostawa" }] = {
		text = "Ask Woody about the wood supply.",
	},
}

local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
	checkInteraction = false,
	isTransportNpc = true,
}
NpcRegistry:AppendNpcData(context)
