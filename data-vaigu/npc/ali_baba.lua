local name = "Ali Baba"
local outfit = {
	lookType = 146,
	lookHead = 76,
	lookBody = 19,
	lookLegs = 130,
	lookFeet = 21,
	lookAddons = 2,
}
local dialogs = {
	[{ "fly", "poleciec", "yes", "tak" }] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTravelWindow,
				travelRoutes = TRAVEL_ROUTES.ALI_BABA_CARPET,
				travelMethod = TRAVEL_METHOD.CARPET,
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
		text = "Hello, traveler. Would you like me to {fly} you somewhere?",
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
