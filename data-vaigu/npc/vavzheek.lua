local name = "Vavzheek"
local outfit = {
	lookType = 1776,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 28,
	lookFeet = 131,
	lookAddons = 0,
}
local customDialogs = {
	[TRAVEL_KEYWORDS] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTravelWindow,
				travelRoutes = TRAVEL_ROUTES.VAVZHEEK_TRAIN,
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
		text = "Hello, im the conductor of this train. Do you need a {ride}?",
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
