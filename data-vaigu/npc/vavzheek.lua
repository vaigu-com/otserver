local name = "Vavzheek"
local outfit = {
	lookType = 1776,
	lookHead = 2,
	lookBody = 76,
	lookLegs = 28,
	lookFeet = 131,
	lookAddons = 0,
}
local dialogs = {
	[TRAVEL_KEYWORDS[TRANSPORT_TYPE.TRAIN]] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTransportWindow,
				transports = TRANSPORT_ROUTES.VAVZHEEK_TRAIN,
				transportType = TRANSPORT_TYPE.SHIP,
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
	dialogs = dialogs,
	voices = voices,
	checkInteraction = false,
	isTransportNpc = true,
}
NpcRegistry:AppendNpcData(context)
