local name = "Zong"
local outfit = {
	lookType = 698,
	lookHead = 74,
	lookBody = 114,
	lookLegs = 82,
	lookFeet = 85,
	lookAddons = 1,
}
local dialogs = {
	[{ "sail", "plynac" }] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTransportWindow,
				transports = TRANSPORT_ROUTES.ZONG_CAMEL,
				transportType = TRANSPORT_TYPE.CAMEL,
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
		text = "Hey, Im Zong! Would you like to {ride} somewhere?",
	},
}

local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
