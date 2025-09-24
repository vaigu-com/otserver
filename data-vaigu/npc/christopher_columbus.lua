local name = "Christopher Columbus"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}
local customDialogs = {
	[TRAVEL_KEYWORDS] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTravelWindow,
				travelRoutes = TRAVEL_ROUTES.CRISTOPHER_COLUMBUS_SHIP,
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
		text = "Hello. I can sail you to steppes, Bornholm and island inhabited by quaras. So where you'd like to {sail} to?",
	},
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
