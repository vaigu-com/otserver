local name = "Tarzan"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}
local customDialogs = {
	[{ "sail", "plynac" }] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTravelWindow,
				travelRoutes = TRAVEL_ROUTES.TARZAN_SHIP,
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
	[{ GREET }] = { "You you like me to sail you anywhere?" },
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	checkInteraction = false,
	isTransportNpc = true,
}
NpcRegistry:AppendNpcData(context)
